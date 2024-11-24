`timescale 1ns / 1ps

/*
    ain: 1st operand (unsigned)
    bin: 2nd operand (unsigned)
    dout: multiplication and accumulation result
    en:
        ==1: fused multiplier computes output
        ==0: fused multiplier initialize output as 0
    clk: clock
*/

module my_fusedmult #(
    parameter BITWIDTH = 32
)
(
    input [BITWIDTH-1:0] ain,
    input [BITWIDTH-1:0] bin,
    input en,
    input clk,
    output [2*BITWIDTH-1:0] dout
);

wire [2*BITWIDTH-1:0] pass_partial, pass_res;
reg [2*BITWIDTH-1:0] out;
assign dout = out;

my_mul #(.BITWIDTH(BITWIDTH))
multiplier(.ain(ain), .bin(bin), .dout(pass_partial));

my_add #(.BITWIDTH(2*BITWIDTH)) 
accumulator(.ain(pass_partial), .bin(out), .dout(pass_res));

always @(posedge clk) 
    begin
        out <= en ? pass_res : 0;
    end
endmodule


