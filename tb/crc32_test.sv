`timescale 1ns / 1ps
/**
 * File              : crc32.sv
 * Author            : Alenkruth Krishnan Murali, Khyati Kiyawat
 * Date              : 11.04.2023
 */


module crc32_test;

reg [31:0] message_in;
reg [31:0] compute_in;
wire [31:0] message_out;
reg clk_in;
reg rst_in;
reg [31:0] polynomial_in;

crc32 DUT (.message_i(message_in),
           .compute_i(compute_in), 
           .message_o(message_out),
           .polynomial_i(polynomial_in),
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
    polynomial_in = 32'hEDB88320;
    #(period);
    message_in = 32'hBABECAFE;
    #period;
    rst_in = 1'b0;
    #period
    rst_in = 1'b1;
    #period
    compute_in = 1'b1;
    #period
    rst_in = 1'b0;
    #period
    rst_in = 1'b1;	
    #(period*64*2);
    message_in = 32'h00000000;
    compute_in = 1'b0;
    rst_in = 'b0;
    #(period*10);
    rst_in = 1'b1;
    #(period*100);
end

endmodule
