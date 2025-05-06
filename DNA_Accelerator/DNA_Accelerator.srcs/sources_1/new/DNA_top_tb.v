`timescale 1ns / 1ps

module DNA_top_tb;

    // Inputs
    reg clk;
    reg rst;
    reg start_i;
    reg [31:0] ref_32_i;
    reg [31:0] read_32_i;

    // Outputs
    wire en_o;
    wire [31:0] addr_ref_o;
    wire [31:0] addr_read_o;
    wire [31:0] addr_matrix_o;
    wire [31:0] matrix_o0, matrix_o1, matrix_o2, matrix_o3;
    wire [31:0] matrix_o4, matrix_o5, matrix_o6, matrix_o7;
    wire [31:0] matrix_o8, matrix_o9, matrix_o10, matrix_o11;
    wire [31:0] matrix_o12, matrix_o13, matrix_o14, matrix_o15;
    wire [31:0] read_prv, read, score_i;
    wire [3:0] count;
    reg [2:0] match;
    reg [2:0] mismatch;
    reg [2:0] gap;
    reg [6:0] ADDR_WIDTH;
    // Instantiate the Unit Under Test (UUT)
    DNA_top uut (
        .clk(clk),
        .rst(rst),
        .start_i(start_i),
        .ADDR_WIDTH(ADDR_WIDTH),
        .match(match),
        .mismatch(mismatch),
        .gap(gap),
        .ref_32_i(ref_32_i),
        .read_32_i(read_32_i),
        .en_o(en_o),
        .addr_ref_o(addr_ref_o),
        .addr_read_o(addr_read_o),
        .addr_matrix_o(addr_matrix_o),
        .matrix_o0(matrix_o0), .matrix_o1(matrix_o1), .matrix_o2(matrix_o2), .matrix_o3(matrix_o3),
        .matrix_o4(matrix_o4), .matrix_o5(matrix_o5), .matrix_o6(matrix_o6), .matrix_o7(matrix_o7),
        .matrix_o8(matrix_o8), .matrix_o9(matrix_o9), .matrix_o10(matrix_o10), .matrix_o11(matrix_o11),
        .matrix_o12(matrix_o12), .matrix_o13(matrix_o13), .matrix_o14(matrix_o14), .matrix_o15(matrix_o15),
        .count(count), .read_prv_i(read_prv), .read_i(read), .score_i(score_i)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        start_i = 0;
        match = 3'd2;
        mismatch = 3'd1;
        gap = 3'd2;
        ref_32_i = 32'b00000100000001010101011110010101;
        ADDR_WIDTH = 1;
        read_32_i = 32'b00000111100101010101111001010101; // Dummy data

        // Reset pulse
        #20 rst = 0;

        // Wait a bit, then start
        #20 start_i = 1;
        #10 start_i = 0;
        #200
        ref_32_i = 32'b00000111100001010101011110010101;  // Dummy data
        // Continue simulation for some time
        #2000;

        // Finish simulation
        $finish;
    end

    // Optional monitor for debugging
    initial begin
        $monitor("Time: %t | en_o: %b | addr_ref: %d | matrix_o0: %h", 
                 $time, en_o, addr_ref_o, matrix_o0);
    end

endmodule
