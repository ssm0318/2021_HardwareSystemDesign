`timescale 1ns / 1ps

module tb_fp_ip();

    // for my IP    
    reg [32-1:0] ain;
    reg [32-1:0] bin;
    reg [32-1:0] cin;
    reg rst;
    reg clk;
    wire [32-1:0] res;
    wire dvalid;
        // for test
    integer i;
    // random test vector generation
    initial begin
            clk <= 0;
            rst <= 0;
        for(i=0; i<32; i=i+1) begin
            ain = {5'b1000, $urandom%(2**26)}; 
            bin = {5'b1000, $urandom%(2**26)}; 
            cin = {5'b1000, $urandom%(2**26)}; 
            #20;
        end
    end
    
    always #5 clk = ~clk;
    
    floating_point_MAC UUT(
        .aclk(clk),
        .aresetn(~rst),
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tvalid(1'b1),
        .s_axis_c_tvalid(1'b1),
        .s_axis_a_tdata(ain),
        .s_axis_b_tdata(bin),
        .s_axis_c_tdata(cin),
        .m_axis_result_tvalid(dvalid),
        .m_axis_result_tdata(res)
    );
    
endmodule