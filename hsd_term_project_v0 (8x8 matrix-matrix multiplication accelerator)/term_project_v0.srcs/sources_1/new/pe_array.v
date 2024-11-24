module pe_array_v1 (aclk, aresetn, start, rddata, wrdata, rdaddr, done);
    parameter              V_SIZE = 8;
    localparam              NUM_PE = V_SIZE*V_SIZE;

    input                   aclk, aresetn, start;
    input [31:0]            rddata;
    output [31:0]           wrdata;
    output [7:0]            rdaddr;
    output                  done;
    
    reg [2:0]               present_state, next_state;
    reg [7:0]               counter_load;
    reg [3:0]               counter_calc;
    reg [6:0]               counter_harv;
    reg [2:0]               counter_done;
    reg                     rst_load, rst_calc, rst_harv, rst_done;
    reg                     pe_en;
   
    parameter              S_IDLE = 3'd0, S_LOAD = 3'd1, S_CALC = 3'd2, S_HARV = 3'd3, S_DONE = 3'd4;
    wire                    valid_en;
    
    wire [31:0]             ain [NUM_PE-1:0];
    wire [31:0]             bin [NUM_PE-1:0];
    reg                     valid;
    wire                    dvalid;
    wire [31:0]             dout [NUM_PE-1:0];
    reg [31:0]              res [NUM_PE-1:0];
    
    // global buffer
    reg [31:0]              global_buffer1 [NUM_PE-1:0];
    reg [31:0]              global_buffer2 [NUM_PE-1:0];
    
    genvar i;
    generate 
        for (i = 0; i < NUM_PE; i = i+1) begin: MY_PE_ARRAY
            my_pe MY_PE (
                .aclk(aclk),
                .aresetn(aresetn && next_state != S_IDLE),  // reset when new matrix comes in
                .ain(ain[i]),
                .bin(bin[i]),
                .valid(valid),
                .dvalid(dvalid),
                .dout(dout[i])
            );
        end
    endgenerate

    // Counter
    always @(posedge aclk)
        if(rst_load) 
            counter_load <= 0;
        else 
            counter_load <= counter_load + 1;
    always @(posedge aclk)
        if(rst_calc) 
            counter_calc <= 0;
        else 
            counter_calc <= dvalid ? counter_calc + 1 : counter_calc;
    always @(posedge aclk)
        if(rst_harv)
            counter_harv <= 0;
        else
            counter_harv <= counter_harv + 1;
    always @(posedge aclk)
        if(rst_done) 
            counter_done <= 0;
        else 
            counter_done <= counter_done + 1;
        
    // part 1: initialize to state S_IDLE and update present state register
    always @(posedge aclk or negedge aresetn)
        if(!aresetn)
            present_state <= S_IDLE;
        else
            present_state <= next_state;
            
    // part 2: determine next state
    always @(*)
        case(present_state)
            S_IDLE:
                if(start)
                    next_state = S_LOAD;
                else
                    next_state = present_state;
            S_LOAD:
                if(counter_load == 128)
                    next_state = S_CALC;
                else
                    next_state = present_state;
            S_CALC:
                if(counter_calc == 8)
                    next_state = S_HARV;
                else 
                    next_state = present_state;
            S_HARV:
                if(counter_harv == 64)
                    next_state = S_DONE;
                else
                    next_state = present_state;
            S_DONE:
                if(counter_done == 4)
                    next_state = S_IDLE;
                else
                    next_state = present_state;
        endcase
        
    // part 3: evaluate output (in this case internal registers)
    always @(*)
        case(present_state)
            S_IDLE: pe_en = 0;
            default: pe_en = 1;
        endcase
    always @(*)
        case(present_state)
            S_LOAD: rst_load = 0;   // counter for S_LOAD continues to tick
            default: rst_load = 1;
        endcase
    always @(*)
        case(present_state)
            S_CALC: rst_calc = 0;  // counter for S_CALC continues to tick
            default: rst_calc = 1;
        endcase
    always @(*)
        case(present_state)
            S_HARV: rst_harv = 0;
            S_DONE: rst_harv = 0;
            default: rst_harv = 1;  // counter for S_HARV continues to tick
        endcase
    always @(*)
        case(present_state)
            S_DONE: rst_done = 0;  // counter for S_DONE continues to tick
            default: rst_done = 1;
        endcase
        
    // Operations for S_LOAD
    assign rdaddr = counter_load;
    
    always @(posedge aclk)
        if (counter_load > 0 && counter_load <= 128) begin
            if (counter_load <= 64) 
                global_buffer1[counter_load - 1] = rddata;
            else
                global_buffer2[counter_load - 65] = rddata;
        end

    assign valid_en = ((present_state == S_LOAD) && (next_state == S_CALC) ||
                      ((next_state == S_CALC) && (counter_calc < 7) && dvalid)); 

    // Operations for S_CALC
    genvar m, n;
    for (m = 0; m < V_SIZE; m = m+1) begin
        for (n = 0; n < V_SIZE; n = n+1) begin
            assign ain[m * V_SIZE + n] = global_buffer1[m * V_SIZE + counter_calc];
            assign bin[m * V_SIZE + n] = global_buffer2[n + counter_calc * V_SIZE];
        end
    end
    
    integer j;
    always @(posedge aclk)
        if (!aresetn || present_state == S_IDLE)
            for (j = 0; j < NUM_PE; j = j+1)
                res[j] <= 'd0;
        else
            if (present_state == S_CALC && next_state == S_HARV)
                for (j = 0; j < NUM_PE; j = j + 1)
                    res[j] <= dout[j];
            else
                for (j = 0; j < NUM_PE; j = j + 1)
                    res[j] <= res[j];

    always @(posedge aclk)
        valid <= valid_en && !valid ? 1'b1 : 1'b0;
        
    // Operations for S_HARV
    assign wrdata = (present_state == S_HARV) ? res[counter_harv]: 0;
    
    // Operations for S_DONE
    assign done = (present_state == S_DONE) ? 1 : 0;
endmodule