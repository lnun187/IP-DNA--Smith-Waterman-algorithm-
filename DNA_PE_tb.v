`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2025 03:42:11 PM
// Design Name: 
// Module Name: DNA_PE_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DNA_PE_tb;

    // Inputs
    reg clk;
    reg rst;
    reg en_i;
    reg [1:0] read_2_i;
    reg [1:0] ref_2_i;
    reg [3:0] ID_i;
    reg [31:0] score_i;
    reg [2:0] match;
    reg [2:0] mismatch;
    reg [2:0] gap;

    // Outputs
    wire [31:0] score_o;
    wire [1:0] ref_2_o;
    wire [31:0] matrix_o0, matrix_o1, matrix_o2, matrix_o3;
    wire [31:0] matrix_o4, matrix_o5, matrix_o6, matrix_o7;
    wire [31:0] matrix_o8, matrix_o9, matrix_o10, matrix_o11;
    wire [31:0] matrix_o12, matrix_o13, matrix_o14, matrix_o15;
    integer i;
    // Instantiate the Unit Under Test (UUT)
    DNA_PE #(.ID(2), .ADDR_WIDTH(1)) uut (
        .clk(clk),
        .rst(rst),
        .en_i(en_i),
        .read_2_i(read_2_i),
        .ref_2_i(ref_2_i),
        .score_i(score_i),
        .match(match),
        .mismatch(mismatch),
        .gap(gap),
        .score_o(score_o),
        .ref_2_o(ref_2_o),
        .matrix_o0(matrix_o0), .matrix_o1(matrix_o1), .matrix_o2(matrix_o2), .matrix_o3(matrix_o3),
        .matrix_o4(matrix_o4), .matrix_o5(matrix_o5), .matrix_o6(matrix_o6), .matrix_o7(matrix_o7),
        .matrix_o8(matrix_o8), .matrix_o9(matrix_o9), .matrix_o10(matrix_o10), .matrix_o11(matrix_o11),
        .matrix_o12(matrix_o12), .matrix_o13(matrix_o13), .matrix_o14(matrix_o14), .matrix_o15(matrix_o15)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Test procedure
    initial begin
        // Initial values
        rst = 1;
        en_i = 0;
        read_2_i = 2'b00;
        ref_2_i = 2'b11;
        ID_i = 4'd0;
        score_i = 32'd0;
        match = 3'd2;
        mismatch = 3'd1;
        gap = 3'd2;
        // Reset pulse
        #20;
        rst = 0;
        #20
        en_i = 1;
        // Apply first input
        #20
        for(i = 0; i < 48; i = i + 1) begin
            #5
            read_2_i = $urandom%10;
            ref_2_i = $urandom%10; 
            #5 score_i = $urandom%10;
        end
        #5
        read_2_i = 2'b00; // 'A'
        ref_2_i = 2'b00;  // 'A'
        #5 score_i = 32'd0;
        #5;        
        read_2_i = 2'b10; // 'G'
        ref_2_i = 2'b00;  // 'A'
        #5 score_i = 32'd5;
        #5;
        read_2_i = 2'b01; // 'T'
        ref_2_i = 2'b11;  // 'C'
        #5 score_i = 32'd1;
        #5;
        read_2_i = 2'b10; // 'C'
        ref_2_i = 2'b01;  // 'A'
        #5 score_i = 32'd0;
        #10;
        en_i = 0;
        #50;
        $finish;
    end
endmodule
