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
    input wire [31:0] compute_i,
    input wire [31:0] message_i,
    input wire [31:0] polynomial_i,
    output wire [31:0] message_o
    );
    
    reg [31:0] polynomial = 32'h04C11DB7;  // edb88320;
    // assign message_o = message_i ^ polynomial;
    reg [63:0] padded_message_i = {message_i, 32'h0};
    reg [63:0] padded_polynomial = {polynomial, 32'h0};
    reg [5:0] count = 6'd63;
    reg [31:0] crc_out = 'h0;
    
    wire compute = compute_i[0];
    
    assign message_o = crc_out;
    
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            crc_out <= 32'h0;
            // reset is required before computation can start. Else the old values of message will be read
            padded_polynomial <= {polynomial, 32'h0};
            padded_message_i <= {message_i, 32'h0};
            count <= 6'd63;
        end
        else begin
            if (compute) begin
                if (padded_message_i[count]) begin
                    padded_message_i <= padded_message_i ^ padded_polynomial;
                end
                padded_polynomial <= padded_polynomial >> 1;
                count <= count - 1;
                if (count == 6'd32) begin
                    crc_out <= padded_message_i[31:0];
                end
                /*else begin
                    message_o <= 32'h0;
                end*/
            end
            /*else message_o <= 32'h0;*/
        end
    end
    /*generate
        always_comb begin
            for (i = 31; i>=0; i++) begin
                padded_message_i = 
            end
        end
    endgenerate
    */ 
endmodule
