module crc_top #(
    parameter ADDR_WIDTH = 11,
    parameter DATA_WIDTH = 33)(
    input clk,
    input write_en,
    input [DATA_WIDTH-2:0] data_in,
	input [ADDR_WIDTH-1:0] address,
	//input crc_address,
	output [DATA_WIDTH-1:0] data_out,
  	output [DATA_WIDTH-2:0] top_crc_out
  	//output match
    );  

wire [DATA_WIDTH-1:0] data_out_read;


freepdk45_sram_4kbytes_1rw_32x1024_8 SRAM (
                                          .clk0(clk),
                                          .csb0(1'b0),
                                          .web0(write_en),
                                          .wmask0(4'b1111),
                                          .spare_wen0(1'b0),
                                          .addr0(address),
                                          .din0({1'b0,data_in}),
                                          .dout0(data_out)
                                          );

crc32 crc_mpeg2 (
                .data_in(data_out_read[31:0]),
                .init(32'hffffffff),
                .crc_out(top_crc_out)
                );

assign data_out_read = data_out;

endmodule
