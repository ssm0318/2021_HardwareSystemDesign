module pe_controller (aclk, aresetn, start, rddata, wrdata, rdaddr, done);
    input                   aclk, aresetn, start;
    input [31:0]            rddata;
    output [31:0]           wrdata;
    output [4:0]            rdaddr;
    output                  done;
    
    reg [1:0]               present_state, next_state;
    reg [5:0]               counter_load;
    reg [4:0]               counter_calc;
    reg [3:0]               counter_done;
    reg                     rst_load, rst_calc, rst_done;
    reg                     pe_en;
    
    parameter              S_IDLE = 3'd0, S_LOAD = 3'd1, S_CALC = 3'd2, S_DONE = 3'd4;
    wire                    valid_en;
    
    wire [31:0] ain;
    wire [31:0] bin;
    reg valid;
    wire dvalid;
    wire [31:0] dout;
    
    // PE
    my_pe MY_PE (
        .aclk(aclk),
        .aresetn(aresetn),
        .ain(ain),
        .bin(bin),
        .valid(valid),
        .dvalid(dvalid),
        .dout(dout)
    );
   
    // global buffer
    reg [31:0] global_buffer1 [15:0];
    reg [31:0] global_buffer2 [15:0];

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
                if(counter_load == 32)
                    next_state = S_CALC;
                else
                    next_state = present_state;
            S_CALC:
                if(counter_calc == 16)
                    next_state = S_DONE;
                else 
                    next_state = present_state;
            S_DONE:
                if(counter_done == 8)
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
            S_DONE: rst_done = 0;  // counter for S_DONE continues to tick
            default: rst_done = 1;
        endcase
        
    // Operations for S_LOAD
    assign rdaddr = counter_load;
    
    always @(posedge aclk)
        if (counter_load > 0 && counter_load <= 32) begin
            if (counter_load <= 16) 
                global_buffer1[counter_load - 1] = rddata;
            else
                global_buffer2[counter_load - 17] = rddata;
        end
    
    // Operations for S_CALC
    assign ain = global_buffer1[counter_calc];
    assign bin = global_buffer2[counter_calc];

    assign valid_en = ((present_state == S_LOAD) && (next_state == S_CALC) ||
                      ((next_state == S_CALC) && (counter_calc < 15) && dvalid)); 

    always @(posedge aclk)
        valid <= valid_en && !valid ? 1'b1 : 1'b0;
    
    // Operations for S_DONE
    assign done = (present_state == S_DONE) ? 1 : 0;
    assign wrdata = done ? dout: 0;
endmodule