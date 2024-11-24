module pe_array#(
    parameter H_SIZE = 8
)
(
    input                   start,
    input                   S_AXI_ACLK,
    input                   S_AXI_ARESETN,
    output                  done,
    
    input [31:0]            BRAM_RDDATA,
    output [31:0]           BRAM_WRDATA,
    output [4:0]            BRAM_ADDR,
    output                  BRAM_CLK
);
    
    wire aclk = S_AXI_ACLK;
    wire aresetn = S_AXI_ARESETN;
    
    
    genvar i;
    generate
        for(i = 0; i < H_SIZE; i = i+1) begin: PE_CONTROLLERS
            pe_controller pe_controller (
                .aclk(aclk),
                .aresetn(aresetn),
                .start(start),
                .rddata(rddata),
                .wrdata(wrdata),
                .rdaddr(rdaddr),
                .done(done)
            );
        end
    endgenerate
    
endmodule