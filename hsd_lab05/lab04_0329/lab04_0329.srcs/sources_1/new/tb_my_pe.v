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
initial begin
    for(i=1; i<16; i=i+1) begin
        gb1[i] <= $urandom%(2**31);
        gb2[i] <= $urandom%(2**31);
    end
    
    #10
    
    aclk = 0;
    aresetn = 1;
    #10
    
    valid = 1;
    ain = gb1[0];
    bin = gb2[0];
    valid = 0;
    
    for(i=1; i<16; i=i+1) begin
        wait(dvalid);
        valid = 1;
        ain = gb1[i];
        bin = gb2[i];
        #10
        valid = 0;
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
