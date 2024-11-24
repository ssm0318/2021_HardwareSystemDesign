`timescale 1ns / 1ps

module tb_my_one_sec_checker();
    reg GCLK;
    reg BTNC;

    initial begin
        // start
        GCLK <= 1;
        #10;
        BTNC <= 1;
        #10;
        BTNC <= 0;

        // two cycle reset
        #200;
        BTNC <= 1;
        #20;
        BTNC <= 0;

        // short reset
        #213;
        BTNC <= 1;
        #2;
        BTNC <= 0;
        #5;

        // long reset
        #202;
        BTNC <= 1;
        #36;
        BTNC <= 0;
        #2;

        // starts at 700ns point
    end

    one_sec_checker MY_ONE_SEC_CHECKER (
        .GCLK(GCLK),
        .BTNC(BTNC)
    );

    always #5 GCLK = ~GCLK;
endmodule
