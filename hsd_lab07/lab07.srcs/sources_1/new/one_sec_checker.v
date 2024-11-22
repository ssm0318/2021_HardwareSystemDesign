`timescale 1ns / 1ps

module one_sec_checker(
    input GCLK,
    input BTNC,
    output [7:0] LD
    );

    parameter [26:0] load_val = 27'd100000000;
//    parameter [26:0] load_val = 27'd10;  // for testbench only
    reg [26:0] down_counter = load_val;
    parameter [7:0] fully_lit = 8'b11111111;
    reg [7:0] up_counter;
    wire rst, load, tick;
    
    assign rst = BTNC;
    assign load = (down_counter <= 1);
    
    // down counter: synchronous reset
    always @(posedge GCLK)
        if(rst)
            down_counter <= 0;
        else 
            if(load)
                down_counter <= load_val;
            else
                down_counter <= down_counter - 1;
    
    assign tick = (down_counter == 1);
    
    // up counter: synchronous reset
    always @(posedge GCLK)
        if(rst)
            up_counter <= fully_lit;
        else if((up_counter == fully_lit) && load)
                up_counter <= 0;
        else
            if(tick)
                up_counter <= up_counter + 1;
            
    assign LD = up_counter;
    
endmodule
