`timescale 1ns / 1ps

module testbench;

parameter DATA_WIDTH = 33;
parameter ADDR_WIDTH = 11;

logic clk;
logic write_en;
logic [DATA_WIDTH-2:0] data_in;
logic [DATA_WIDTH-1:0] data_out;
logic [ADDR_WIDTH-1:0] address;
logic [DATA_WIDTH-2:0] top_crc_out;

top dut (
  .clk(clk),
  .write_en(write_en),
  .data_in(data_in),
  .data_out(data_out),
  .address(address),
  .top_crc_out(top_crc_out)
);

integer i;

// Toggle clock
always #5 clk = ~clk;

initial begin
  clk = 1;
  write_en = 1;
  data_in = 0;
  address = 0;
   #10;

  // Write some data to SRAM
  write_en = 0;
//  for (i = 0; i < 1024; i = i + 4) begin
//    address = i;
    //data_in = i;
    address = 0;
    data_in = 32'hbabecafe;
    #10;
//  end
  
  //address = 0;
  //data_in = 32'hbabecafe;
  
  write_en = 1;

  // Read data from SRAM and compute CRC
    //  for (i = 0; i < 1024; i = i + 4) begin
    //    address = i;
    //    #5;
    //  end

  address = 0;
  // Wait for CRC to stabilize
  #10;
    
  // Check CRC
  if (top_crc_out != 32'ha5769b57) begin
    $display("Test failed: CRC mismatch!");
  end else begin
    $display("Test passed: CRC match!");
  end
  write_en = 0;
  // End simulation
  #10;
  $finish;
end
endmodule
