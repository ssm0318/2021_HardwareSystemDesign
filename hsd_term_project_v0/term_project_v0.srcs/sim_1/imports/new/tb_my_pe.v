`timescale 1ns / 1ps

module tb_my_pe ();
    parameter L_RAM_SIZE = 6;
    
    reg aclk;
    reg aresetn;
    reg [31:0] ain;
    reg [31:0] bin;
    reg valid;
    wire dvalid;
    wire [31:0] dout;
    
    // global buffer
    reg [31:0] gb1 [0:2**L_RAM_SIZE - 1];
    reg [31:0] gb2 [0:2**L_RAM_SIZE - 1];
    
    integer i;
    integer count;
    
    initial begin
        for(i=0; i<16; i=i+1) begin
            gb1[i] = 32'h40000000;
            gb2[i] = 32'h40000000;
        end
        aclk = 0;
        aresetn = 0;
        #10;
        aresetn = 1;
        valid = 0;
        
        #10;
        valid = 1;
        ain = gb1[0];
        bin = gb2[0];
        #20;
        valid = 0;
        count = 5'd0;
    end
        
    always @(posedge aclk) begin        
        while(count < 16) begin
            wait(dvalid);
            #10;
            valid = 1;
            ain = gb1[count];
            bin = gb2[count];
            #20;
            valid = 0;
            count = count + 1;
        end
    end
        
    my_pe MY_PE (
        .aclk(aclk),
        .aresetn(aresetn),
        .ain(ain),
        .bin(bin),
        .valid(valid),
        .dvalid(dvalid),
        .dout(dout)
    );

    always #5 aclk = ~aclk;

endmodule
