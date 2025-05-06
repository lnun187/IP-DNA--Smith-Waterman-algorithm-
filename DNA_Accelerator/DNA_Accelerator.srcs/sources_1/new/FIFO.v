`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2025 03:47:37 PM
// Design Name: 
// Module Name: FIFO
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

module FIFO #(DATA_WIDTH = 8)(
    input clk, reset,
    input en,
    input wr,
    input [6:0] ADDR_WIDTH,
    input [DATA_WIDTH - 1 : 0] w_data, //writing data
    input rd,
    output [DATA_WIDTH - 1 : 0] r_data //reading data

    );

    //signal
    reg done;
    wire [31 : 0] w_addr, r_addr;
    wire [31 : 0] data_r;
    assign r_data = done ? data_r : 'b0;
    always @(posedge clk, posedge reset) begin
        if(reset) done = 1'b0;
        else if(en && (w_addr == 2 ** ADDR_WIDTH - 2)) done = 1'b1;
    end
    //instantiate registers file
    register_file #(.DATA_WIDTH(DATA_WIDTH))
        reg_file_unit(
            .clk(clk),
            .w_en(en & wr),

            .r_addr(r_addr), //reading address
            .w_addr(w_addr), //writing address

            .w_data(w_data), //writing data
            .r_data(data_r) //reading data
        
        );

    //instantiate fifo ctrl
    fifo_ctrl fifo_ctrl(
            .clk(clk), 
            .reset(reset),
            .ADDR_WIDTH(ADDR_WIDTH),
            .wr(en & wr), 
            .rd(en & rd),
            .w_addr(w_addr),
            .r_addr(r_addr)
        );

endmodule
