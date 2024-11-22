module my_bram #(
    parameter integer BRAM_ADDR_WIDTH = 15,
    parameter INIT_FILE = "input.txt",
    parameter OUT_FILE = "output.txt"
)(
    input wire [BRAM_ADDR_WIDTH-1:0] BRAM_ADDR,
    input wire BRAM_CLK,
    input wire [31:0] BRAM_WRDATA,
    output reg [31:0] BRAM_RDDATA,
    input wire BRAM_EN,
    input wire BRAM_RST,
    input wire [3:0] BRAM_WE,
    input wire done
);

    reg [31:0] mem[0:8191];
    wire [BRAM_ADDR_WIDTH-3:0] addr = BRAM_ADDR[BRAM_ADDR_WIDTH-1:2];
    reg [31:0] dout;
    
    // code for reading & writing
    initial begin
        if (INIT_FILE != "") begin
            // read data from INIT_FILE and store them into mem
            $readmemh(INIT_FILE, mem);
        end
        wait(done)
            //write data stored in mem into OUT_FILE
            $writememh(OUT_FILE, mem);
    end
        
    // code for BRAM implementation
    always @(posedge BRAM_CLK or posedge BRAM_RST)
        if(BRAM_RST)
            BRAM_RDDATA <= 0;
        else
            if(BRAM_EN)
                if(BRAM_WE == 4'b0000)
                    BRAM_RDDATA <= dout;
                else
                    dout <= BRAM_WRDATA;
    
    always @(posedge BRAM_CLK)
        if(BRAM_WE == 4'b0000)
            dout <= mem[addr];
        else
            mem[addr] <= dout & {{8{BRAM_WE[3]}}, {8{BRAM_WE[2]}}, {8{BRAM_WE[1]}}, {8{BRAM_WE[0]}}};
        
endmodule
        