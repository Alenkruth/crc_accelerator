(* blackbox *)
module freepdk45_sram_4kbytes_1rw_32x1024_8(
`ifdef USE_POWER_PINS
    vdd,
    gnd,
`endif
// Port 0: RW
    input clk0,
    input csb0,
    input web0,
    input [3:0] wmask0,
    input [10:0] addr0,
    input spare_wen0,
    input [31:0] din0,
    output reg [31:0] dout0
  );
endmodule
