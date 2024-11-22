`timescale 1ns / 1ps

module tb_my_bram ();
    parameter integer BRAM_ADDR_WIDTH = 15;
    
    reg [BRAM_ADDR_WIDTH-1:0] BRAM_ADDR;
    reg BRAM_CLK;
    wire [31:0] BRAM_WRDATA;
    wire [31:0] BRAM_RDDATA1;
    wire [31:0] BRAM_RDDATA2;
    reg BRAM_EN;
    reg BRAM_RST;
    reg done;
        
    integer i;
    initial begin
        BRAM_CLK <= 1;
        BRAM_ADDR <= 0;
        BRAM_RST <= 0;
        BRAM_EN <= 1;
        for (i=0; i<8; i=i+1) begin
            #30;
            BRAM_ADDR <= BRAM_ADDR + 3'b100;
        end
        #10;
        done <= 1;
    end

always #5 BRAM_CLK = ~BRAM_CLK;

my_bram BRAM1(
    .BRAM_ADDR(BRAM_ADDR),
    .BRAM_CLK(BRAM_CLK),
    .BRAM_WRDATA(BRAM_WRDATA),
    .BRAM_RDDATA(BRAM_RDDATA1),
    .BRAM_EN(BRAM_EN),
    .BRAM_RST(BRAM_RST),
    .BRAM_WE(4'b0000),
    .done(1'b0)
);

my_bram BRAM2(
    .BRAM_ADDR(BRAM_ADDR),
    .BRAM_CLK(BRAM_CLK),
    .BRAM_WRDATA(BRAM_RDDATA1),
    .BRAM_RDDATA(BRAM_RDDATA2),
    .BRAM_EN(BRAM_EN),
    .BRAM_RST(BRAM_RST),
    .BRAM_WE(4'b1111),
    .done(done)
); 

endmodule