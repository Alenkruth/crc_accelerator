/**
 * File              : crc32.sv
 * Author            : Alenkruth Krishnan Murali, Khyati Kiyawat
 * Date              : 11.04.2023
 * Last Modified Date: 19.04.2023
 * Last Modified By  : Alenkruth Krishnan Murali <contact@alenkruth.com>
 */

`timescale 1ns / 1ps


module crc32(
    input clk_i,
    input rst_i,
    // unlike fpga, we can keep compute as a signle bit
    input compute_i,
    input wire [31:0] message_i,
    // input polynomial is represented LSB first.
    // it will be reversed internally.
    input wire [31:0] polynomial_i,
    output wire [31:0] message_o
    );
    
    // reg [31:0] polynomial = 32'h04C11DB7;  // edb88320;
    wire [31:0] polynomial; // store reversed polynomial
    genvar i;
    generate
    for (i=0; i<32; i=i+1) assign polynomial[i] = polynomial_i[31-i];
    endgenerate
    
    reg [63:0] padded_message_i; // = {message_i, 32'h0};
    reg [63:0] padded_polynomial; // = {polynomial, 32'h0};
    reg [5:0] count = 6'd63;
    reg [31:0] crc_out = 'h0;
    
    assign message_o = crc_out;
    
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            crc_out <= 32'h0;
            // reset is required before computation can start. 
            // Else the old values of message will be read
            
            // for a n bit CRC, we use a n+1 bit polynomial
            // In this polynomial, the n+1th bit, is usually 1
            // so it is not included in the 32bit input. This is by standard.
            // We add the 1 over here and pad the polynomial with zeros.
            // There are several desifn choices including padding with ones.
            // We are padding with zeros to keep it simple.
            padded_polynomial <= {1'b1, polynomial, 31'h0};
            padded_message_i <= {message_i, 32'h0};
            count <= 6'd63;
        end
        else begin
            if (compute_i) begin
                if (padded_message_i[count]) begin
                    padded_message_i <= padded_message_i ^ padded_polynomial;
                end
                padded_polynomial <= padded_polynomial >> 1;
                count <= count - 1;
                // we shift right 32 times.
                if (count == 6'd31) begin
                    crc_out <= padded_message_i[31:0];
                end
                /*else begin
                    message_o <= 32'h0;
                end*/
            end
            /*else message_o <= 32'h0;*/
        end
    end

endmodule
