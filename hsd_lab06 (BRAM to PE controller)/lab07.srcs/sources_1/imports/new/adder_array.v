`timescale 1ns / 1ps

module adder_array (cmd, ain0, ain1, ain2, ain3, bin0, bin1, bin2, bin3, dout0, dout1, dout2, dout3, overflow);
    input [2:0] cmd;
    input [31:0] ain0, ain1, ain2, ain3;
    input [31:0] bin0, bin1, bin2, bin3;
    output [31:0] dout0, dout1, dout2, dout3;
    output[3:0] overflow;
    
    wire [31:0] ain[3:0];
    wire [31:0] bin[3:0];
    wire [31:0] dout[3:0];
    
    assign {ain[0], ain[1], ain[2], ain[3]} = {ain0, ain1, ain2, ain3};
    assign {bin[0], bin[1], bin[2], bin[3]} = {bin0, bin1, bin2, bin3};
    assign {dout[0], dout[1], dout[2], dout[3]} = {dout0, dout1, dout2, dout3};
    
    assign dout0 = ((cmd == 0) || (cmd == 4)) ? (ain0 + bin0) : 0;
    assign dout1 = ((cmd == 1) || (cmd == 4)) ? (ain1 + bin1) : 0;
    assign dout2 = ((cmd == 2) || (cmd == 4)) ? (ain2 + bin2) : 0;
    assign dout3 = ((cmd == 3) || (cmd == 4)) ? (ain3 + bin3) : 0;
    
    genvar i;
    generate
        for(i = 0; i < 4; i = i+1) begin: ADDER_ARRAY
            my_add adder(ain[i], bin[i], dout[i], overflow[i]);
        end
    endgenerate
endmodule


