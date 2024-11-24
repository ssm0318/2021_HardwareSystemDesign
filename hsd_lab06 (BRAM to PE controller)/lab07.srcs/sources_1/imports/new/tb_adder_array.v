`timescale 1ns / 1ps

module tb_adder_array();
    reg [2:0] cmd;
    reg [31:0] ain0, ain1, ain2, ain3;
    reg [31:0] bin0, bin1, bin2, bin3;
    wire [31:0] dout0, dout1, dout2, dout3;
    wire [3:0] overflow;
    
    // for test
    integer i;
    // random test vector generation
    initial begin
        for(i=0; i<32; i=i+1) begin
            cmd = $urandom%(2**2);
            ain0 = $urandom%(2**31);
            ain1 = $urandom%(2**31);
            ain2 = $urandom%(2**31);
            ain3 = $urandom%(2**31);
            bin0 = $urandom%(2**31);
            bin1 = $urandom%(2**31);
            bin2 = $urandom%(2**31);
            bin3 = $urandom%(2**31);
            #10;
        end
    end
    
    adder_array my_adder_array(
        cmd, ain0, ain1, ain2, ain3, bin0, bin1, bin2, bin3, dout0, dout1, dout2, dout3, overflow
    );
endmodule
