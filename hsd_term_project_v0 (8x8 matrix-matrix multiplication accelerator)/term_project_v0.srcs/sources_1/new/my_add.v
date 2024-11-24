
`timescale 1ns / 1ps

/*
    ain: 1st operand (unsigned)
    bin: 2nd operand (unsigned)
    dout: summation result
    overflow:
        ==1: if overflow is detected
        ==0: otherwise
*/

module my_add #(
    parameter BITWIDTH = 32
)
(
    input [BITWIDTH-1:0] ain,
    input [BITWIDTH-1:0] bin,
    output [BITWIDTH-1:0] dout,
    output overflow
);

assign {overflow, dout} = ain + bin;

endmodule