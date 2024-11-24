`timescale 1ns / 1ps

module tb();

    // for my IP
    reg [32-1:0] ain;
    reg [32-1:0] bin;
    reg [32-1:0] cin;
    reg rst;
    reg clk;
    reg en;
    reg sub;
    wire [64-1:0] res;
    
    // for test
    integer i;
    // random test vector generation
    initial begin
            clk <= 0;
            rst <= 0;
            sub <= 0;
            en <= 1;
        for(i=0; i<32; i=i+1) begin
            ain = $urandom%(2**31);
            bin = $urandom%(2**31);
            cin = $urandom%(2**31);
            #10;
        end
    end
    
    always #5 clk = ~clk;
    
    xbip_multadd_0 UUT(
        .CLK(clk),
        .CE(en),
        .SCLR(rst),
        .SUBTRACT(sub),
        .A(ain),
        .B(bin),
        .C(cin),
        .P(res)
    );
    
endmodule