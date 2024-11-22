//module one_sec_checker(
//    input GCLK,
//    input BTNC,
//    output [7:0] LD
//    );
    
//    parameter cnt_width = 8;
//    parameter load_val = {cnt_width{1'b1}};
//    reg [cnt_width-1:0] down_counter;
//    reg [cnt_width-1:0] up_counter;
//    reg rst;
//    reg load = 1'b1;
    
//    // rst & load 1
//    always @(posedge BTNC) begin
//        rst <= 1'b1;
//        load <= 1'b1;
//    end
    
//    // rst 0
//    always @(negedge BTNC)
//        rst <= 1'b0;
        
//    // load 0
//    always @(posedge GCLK)
//        if(!rst && load)
//            load <= 1'b0;
    
//    // down_counter
//    always @(posedge GCLK)
//        down_counter <= load ? load_val : down_counter - 1;
            
//    integer i;
//    assign LD = up_counter;
            
//    always @(posedge GCLK)
//        if(load)
//            up_counter <= 0;
//        else
//            // up_counter = (load_val+1) - down_counter
//            //      (=) (load_val+1) + (~down_counter + 1)
//            //      (=) (load_val+2) + ~(down_counter)
//            for(i=0; i<cnt_width; i=i+1) begin
//                up_counter = (load_val+2) + ~(down_counter);
//            end
             
//endmodule