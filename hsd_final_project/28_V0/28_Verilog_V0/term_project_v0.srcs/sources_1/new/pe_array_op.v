module pe_array_v2 (S_AXI_ACLK, S_AXI_ARESETN, start, BRAM_RDDATA, BRAM_WRDATA, BRAM_ADDR, done, BRAM_WE, BRAM_CLK);
    parameter              V_SIZE = 8;
    localparam              NUM_DIAG = 2*V_SIZE;
    localparam              NUM_PE = V_SIZE*V_SIZE;
    
    input                   S_AXI_ACLK, S_AXI_ARESETN, start;
    input [31:0]            BRAM_RDDATA;
    output [31:0]           BRAM_WRDATA;
    output [31:0]           BRAM_ADDR;
    output                  done;
    output [3:0]            BRAM_WE;
    output                  BRAM_CLK;
    
    // states
    localparam              S_IDLE = 2'd0, S_COMP = 2'd1, S_DONE = 2'd2;
    reg [1:0]               present_state, next_state;
    reg [7:0]               counter_load;
    reg [3:0]               counter_calc;
    reg [6:0]               counter_harv;
    reg [2:0]               counter_done;
    reg                     load_done, calc_done, harv_done, done_done;
    reg                     rst_load, rst_calc, rst_harv, rst_done;
        
    // for PE
    wire [31:0]             ain [NUM_PE-1:0];
    wire [31:0]             bin [NUM_PE-1:0];
    reg                     valid [NUM_PE-1:0];
    wire                    dvalid [NUM_PE-1:0];
    wire [31:0]             dout [NUM_PE-1:0];
    reg [31:0]              res [NUM_PE-1:0];
    
    // global buffer
    reg [31:0]              global_buffer1 [NUM_PE-1:0];
    reg [31:0]              global_buffer2 [NUM_PE-1:0];
    
    wire aclk = S_AXI_ACLK;
    wire aclk_180;
    wire aresetn = S_AXI_ARESETN;
    assign BRAM_CLK = aclk_180; 
    
    
    // bram clock
    clk_wiz_0 u_clk (.clk_out1(aclk_180), .clk_in1(aclk));
    
    
    // PEs
    genvar i;
    generate 
        for (i = 0; i < NUM_PE; i = i+1) begin: MY_PE_ARRAY
            my_pe MY_PE (
                .aclk(aclk),
                .aresetn(aresetn && next_state != S_IDLE),  // reset when new matrix comes in
                .ain(ain[i]),
                .bin(bin[i]),
                .valid(valid[i]),
                .dvalid(dvalid[i]),
                .dout(dout[i])
            );
        end
    endgenerate
   
   
    // counter
    always @(*) begin
        load_done = (present_state == S_COMP) && (counter_load == 127);
        calc_done = (present_state == S_COMP) && (counter_calc == 8) && dvalid[NUM_PE-1];
        harv_done = (present_state == S_COMP) && (counter_harv == 63);
        done_done = (present_state == S_DONE) && (counter_done == 4);
    end

    always @(posedge aclk) begin
        counter_load <= rst_load ? 0 : !load_done ? counter_load + 1 : counter_load;
        counter_calc <= rst_calc ? 0 : !calc_done && valid[NUM_PE-1] ? counter_calc + 1 : counter_calc;
        counter_harv <= rst_harv ? -8 : !harv_done ? counter_harv + 1 : counter_harv;
        counter_done <= rst_done ? 0 : !done_done ? counter_done + 1 : counter_done;
    end
    
    
    // part 1: initialize to state S_IDLE and update present state register
    always @(posedge aclk or negedge aresetn)
        if(!aresetn)
            present_state <= S_IDLE;
        else
            present_state <= next_state;
           
                
    // part 2: determine next state
    always @(*)
        case(present_state)
            S_IDLE: next_state <= (start) ? S_COMP : present_state;
            S_COMP: next_state <= (harv_done) ? S_DONE : present_state;
            S_DONE: next_state <= (done_done) ? S_IDLE : present_state;
            default: next_state <= S_IDLE;
        endcase
  
        
    // part 3: evaluate output (in this case internal registers)
    always @(*)
        case(present_state)
            S_COMP: rst_load = 0;   // counter for S_LOAD continues to tick
            default: rst_load = 1;
        endcase
    always @(*)
        case(present_state)
            S_COMP: rst_calc = 0;  // counter for S_CALC continues to tick
            default: rst_calc = 1;
        endcase
    always @(*)
        case(present_state)
            S_COMP: rst_harv = counter_calc != 8;
            default: rst_harv = 1;  // counter for S_HARV continues to tick
        endcase
    always @(*)
        case(present_state)
            S_DONE: rst_done = 0;  // counter for S_DONE continues to tick
            default: rst_done = 1;
        endcase
               
                
    // Operations for S_LOAD
    reg [31:0] addr;
    assign BRAM_ADDR = (BRAM_WE) ? (counter_harv) << 2 : ((counter_load & 1'b1) ? (counter_load >> 4) + (V_SIZE * ((counter_load & 4'b1111) >> 1)) : (NUM_PE + (counter_load >> 1))) << 2;
    always @(posedge aclk)
        addr <= (BRAM_ADDR) >> 2;
     
    always @(posedge aclk)
        if (counter_load > 0 && counter_load <= 128) begin
            if (addr < NUM_PE) 
                global_buffer1[addr] = BRAM_RDDATA;
            else
                global_buffer2[addr - NUM_PE] = BRAM_RDDATA;
        end
    
    
    // Operations for S_CALC
    genvar m, n;
    for (m = 0; m < V_SIZE; m = m+1) begin
        for (n = 0; n < V_SIZE; n = n+1) begin
            assign ain[m * V_SIZE + n] = global_buffer1[m * V_SIZE + counter_calc];
            assign bin[m * V_SIZE + n] = global_buffer2[n + counter_calc * V_SIZE];
        end
    end
    

    // valid_en
    genvar x;
    wire valid_en [NUM_PE-1:0];
    assign valid_en[0] = (counter_load == 2) || (counter_load > 2 && counter_calc < 8 && dvalid[0]);
    assign valid_en[1] = (counter_load == 3) || (counter_calc > 0 && counter_calc < 8 && dvalid[1]);
    assign valid_en[8] = (counter_load == 4) || (counter_calc > 0 && counter_calc < 8 && dvalid[8]);
    assign valid_en[9] = (counter_load == 4) || (counter_calc > 0 && counter_calc < 8 && dvalid[9]);
    assign valid_en[2] = (counter_load == 5) || (counter_calc > 0 && counter_calc < 8 && dvalid[2]);
    assign valid_en[10] = (counter_load == 5) || (counter_calc > 0 && counter_calc < 8 && dvalid[10]);
    for (x = 16; x <= 18; x = x+1) begin
        assign valid_en[x] = (counter_load == 6) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end
    for (x = 3; x <= 19; x = x+8) begin
        assign valid_en[x] = (counter_load == 7) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end    
    for (x = 24; x <= 27; x = x+1) begin
        assign valid_en[x] = (counter_load == 8) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end
    for (x = 4; x <= 28; x = x+8) begin
        assign valid_en[x] = (counter_load == 9) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end      
    for (x = 32; x <= 36; x = x+1) begin
        assign valid_en[x] = (counter_load == 10) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end
    for (x = 5; x <= 37; x = x+8) begin
        assign valid_en[x] = (counter_load == 11) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end      
    for (x = 40; x <= 45; x = x+1) begin
        assign valid_en[x] = (counter_load == 12) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end
    for (x = 6; x <= 46; x = x+8) begin
        assign valid_en[x] = (counter_load == 13) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end   
    for (x = 48; x <= 54; x = x+1) begin
        assign valid_en[x] = (counter_load == 14) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end
    for (x = 7; x <= 55; x = x+8) begin
        assign valid_en[x] = (counter_load == 15) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end      
    for (x = 56; x <= 63; x = x+1) begin
        assign valid_en[x] = (counter_load == 16) || (counter_calc > 0 && counter_calc < 8 && dvalid[x]);
    end
    
    
    // valid signal
    integer k;
    always @(posedge aclk)
        for (k = 0; k < NUM_PE; k = k+1) begin
            valid[k] <= valid_en[k] && !valid[k] ? 1'b1 : 1'b0;
        end
        
        
    // res
    integer j;
    always @(posedge aclk)
        if (!aresetn || present_state == S_IDLE)
            for (j = 0; j < NUM_PE; j = j+1)
                res[j] <= 'd0;
        else
            if (present_state == S_COMP && next_state == S_COMP)
                for (j = 0; j < NUM_PE; j = j + 1)
                    res[j] <= dout[j];
            else
                for (j = 0; j < NUM_PE; j = j + 1)
                    res[j] <= res[j];
        
        
    // Operations for S_HARV
    assign BRAM_WE = ((counter_harv < 64) && (present_state == S_COMP)) ? 4'b1111 : 4'b0000;
    assign BRAM_WRDATA = (present_state == S_COMP) ? dout[counter_harv]: 0;    
    
    
    // Operations for S_DONE
    assign done = (present_state == S_DONE) ? 1 : 0;
                    
endmodule