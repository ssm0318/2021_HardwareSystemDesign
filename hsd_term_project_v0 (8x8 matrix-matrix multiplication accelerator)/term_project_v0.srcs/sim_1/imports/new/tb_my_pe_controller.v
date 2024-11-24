`timescale 1ns / 1ps

module tb_my_pe_controller();
    reg aclk;
    reg aresetn;
    reg start;
    reg [31:0] rddata;
    wire [31:0] wrdata;
    wire [4:0] rdaddr;
    wire done;    

    reg [31:0] mem[0:31]; // 32 of 32 bit data
    
    integer i;
    
    initial begin
        aclk <= 1;
        start <= 0;
        aresetn <= 0;
        
        for(i=0; i<32; i=i+1) begin
            mem[i] = i % 2 == 0 ? 32'h40000000 : 32'h40800000;
//            mem[i] = i; // for S_LOAD debugging only
        end
        
        #10;
        aresetn <= 1;
        start <= 1; 
    end
    
    always @(posedge aclk)
        rddata <= mem[rdaddr];
    
    pe_controller MY_PE_CONT (
        .aclk(aclk),
        .aresetn(aresetn),
        .start(start),
        .rddata(rddata),
        .wrdata(wrdata),
        .rdaddr(rdaddr),
        .done(done)
    );
    
    always #5 aclk = ~aclk;
endmodule
