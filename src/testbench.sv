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
//new
logic [3:0] crc_type;

top_new dut (
  .clk(clk),
  .write_en(write_en),
  .data_in(data_in),
  .data_out(data_out),
  .address(address),
  .top_crc_out(top_crc_out),
  .crc_type(crc_type)
);

integer i;

// Toggle clock
always #5 clk = ~clk;

initial begin
  clk = 1;
  write_en = 1;
  data_in = 0;
  address = 0;
  crc_type = 4'b1111;
  #10;

  // Write data to SRAM address 0
  write_en = 0;
//for (i = 0; i < 1024; i = i + 4) begin
    //address = i;
    //data_in = i;
    address = 0;
    data_in = 32'hbabecafe;
    #10;
    //end
  
  //address = 0;
  //data_in = 32'hbabecafe;
  
  write_en = 1;

  // Read data from SRAM and compute CRC
    //for (i = 0; i < 1024; i = i + 4) begin
    //  address = i;
    //  #5;
    //  end

  address = 0;
  // Wait for CRC to stabilize
  #10;
  
  $display("Checking CRC-32");
  // Check CRC
  if (top_crc_out != 32'ha5769b57) begin
    $display("CRC-32 Test failed: CRC mismatch! CRC mismatch! Calculated: %h, Expected: 0xa5769b57", top_crc_out);
  end else begin
    $display("CRC-32 Test passed: CRC match! Calculated: %h, Expected: 0x3e05", top_crc_out);
  end
  write_en = 0;
  
//CRC-16 check
  crc_type = 4'b0000;
  $display("Checking CRC-16");
  write_en = 1;
  address = 0;
  #10
  // Check CRC
  if (top_crc_out != 'h00003E05) begin  //initial value 0xffff, no reflection, poly - 0x8005
    $display("CRC-16 Test failed: CRC mismatch! Calculated: %h, Expected: 0x3e05", top_crc_out);
  end else begin
    $display("CRC-16 Test passed: CRC match! Calculated: %h, Expected: 0x3e05", top_crc_out);
  end
  
  write_en = 0; 
  
  // End simulation
  #10;
  $finish;
end


endmodule
