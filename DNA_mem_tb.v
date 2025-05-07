`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2025 04:41:06 PM
// Design Name: 
// Module Name: DNA_mem_tb
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


module DNA_mem_tb;

    // Inputs
    reg clk;
    reg rst;
    reg en;
    reg [31:0] ref_32_i;
    reg [31:0] read_32_i;

    // Outputs
    wire [1:0] read_2_o;
    wire [1:0] ref_2_o;

    // Instantiate the Unit Under Test (UUT)
    DNA_mem uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .ref_32_i(ref_32_i),
        .read_32_i(read_32_i),
        .read_2_o(read_2_o),
        .ref_2_o(ref_2_o)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        // Khởi tạo đầu vào
        rst = 1;
        en = 0;
        ref_32_i = 32'hAAAA_FFFF;  // Mẫu dữ liệu tham chiếu
        read_32_i = 32'hCCCC_3333; // Mẫu dữ liệu đọc

        #12; // Đợi 2 cạnh xung clock
        rst = 0;

        // Kích hoạt en để load dữ liệu vào thanh ghi
        #10;
        en = 1;

        // Quan sát 16 chu kỳ kế tiếp để xem từng cặp 2-bit

        #200 $finish;
    end

endmodule

