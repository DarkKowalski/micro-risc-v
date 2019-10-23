`timescale 1ns/1ps

module test_bench();

    reg CLOCK_50;
    reg rst;

    initial begin
        CLOCK = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50 // 50 MHz
    end

    // TODO: adjust durations
    initial begin
        rst = 1'b1; // set rst signal
        #185 rst = 1'b0; // reset rst signal after 195 time units
        #2000 $stop; // stop simulation after 2000 time units
    end

    // TODO: instantiate sopc and run test bench

endmodule