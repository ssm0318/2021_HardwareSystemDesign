module my_pe #(
    parameter L_RAM_SIZE = 6
    )
    (
        // clk/reset
        input aclk,
        input aresetn,
        // port A
        input [31:0] ain,
        // port B
        input [31:0] bin,
        //integrated valid signal
        input valid,
        // computation result
        output dvalid,
        output [31:0] dout
    );
    
    reg [31:0] psum_reg;
    
    always @(posedge aclk)
        if (!aresetn)
            psum_reg <= 0;
        else
            psum_reg <= dvalid ? dout : psum_reg;
    
    floating_point_0 my_float(
        .aclk(clk),
        .aresetn(aresetn),
        .s_axis_a_tvalid(valid),
        .s_axis_b_tvalid(valid),
        .s_axis_c_tvalid(valid),
        .s_axis_a_tdata(ain),
        .s_axis_b_tdata(bin),
        .s_axis_c_tdata(psum_reg),
        .m_axis_result_tvalid(dvalid),
        .m_axis_result_tdata(dout)
    );
endmodule