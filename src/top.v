module crc32(
  input [31:0] data_in,
  input [31:0] init,
  output [31:0] crc_out
);

parameter NUM_WMASKS = 4 ;
parameter ADDR_WIDTH = 11 ;
parameter DATA_WIDTH = 33 ;

module freepdk45_sram_4kbytes_1rw_32x1024_8(
`ifdef USE_POWER_PINS
    inout vdd,
    inout gnd,
`endif
// Port 0: RW
    input clk0, //clock
    input csb0, //active low chip select
    input web0, //active low write control
    input wmask0,   //write mask
    input spare_wen0,  //spare mask
    input [ADDR_WIDTH-1:0] addr0,
    input [DATA-WIDTH-1:0] din0,
    output [DATA-WIDTH-1:0] dout0
  );

  
