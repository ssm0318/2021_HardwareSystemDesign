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
    
    reg [31:0] psum;
    wire [31:0] res;
    
    wire signed [7:0] ain_int [3:0];
    wire signed [7:0] bin_int [3:0];
    
    assign dout = psum;
    
    always @(posedge aclk)
        if (!aresetn)
            psum <= 0;
        else
            psum <= dvalid ? res : psum;
    
    genvar i;
    
    // ain
    generate
        for(i = 0; i < 4; i=i+1) begin: AIN_INT
            assign ain_int[i] = ain[i*8+7:0];
        end
    endgenerate
    
    // bin
    generate
        for(i = 0; i < 4; i=i+1) begin: BIN_INT
            assign bin_int[i] = bin[i*8+7:0];
        end
    endgenerate
    
    assign res = ain_int[0] * bin_int[0] + ain_int[1] * bin_int[1] + ain_int[2] * bin_int[2] + ain_int[3] * bin_int[3];
    
endmodule