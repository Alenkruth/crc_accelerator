`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 06:09:22 PM
// Design Name: 
// Module Name: crc32_test
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


module crc32_test;

reg [31:0] message_in;
reg compute_in;
wire [31:0] message_out;
reg clk_in;
reg rst_in;

crc32 DUT (.message_i(message_in),
           .compute_i(compute_in), 
           .message_o(message_out),
           .clk_i(clk_in),
           .rst_i(rst_in)
);

localparam period = 10;

initial begin
    clk_in = 1'b0;
    forever #period clk_in = ~clk_in;
end

initial begin
    rst_in = 'b1;
    compute_in = 1'b1;
    #(period*10);
    rst_in = 1'b0;
    compute_in = 1'b0;
    #(period*10);
    rst_in = 'b1;
    compute_in = 1'b0;
    #(period);
    message_in = 32'hFFEEFFEE;
    #period;
    rst_in = 1'b0;
    #period
    rst_in = 1'b1;
    #period
    compute_in = 1'b1;
    #(period*64);
    message_in = 32'h00000000;
    compute_in = 1'b0;
    rst_in = 'b0;
    #(period*10);
    rst_in = 1'b1;
    #(period*100);
end

endmodule
