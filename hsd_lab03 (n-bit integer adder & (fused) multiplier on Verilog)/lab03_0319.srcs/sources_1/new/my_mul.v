`timescale 1ns / 1ps

/*
    ain: 1st operand (unsigned)
    bin: 2nd operand (unsigned)
    dout: multiplication result
*/

module my_mul #(
    parameter BITWIDTH = 32
)

(
    input [BITWIDTH-1:0] ain,
    input [BITWIDTH-1:0] bin,
    output [2*BITWIDTH-1:0] dout
);

assign dout = ain * bin;

endmodule