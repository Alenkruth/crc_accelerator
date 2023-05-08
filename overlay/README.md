# CRC32MPEG Accelerator Demonstrated on Pynq Z1.

The Accelerator is integrated with the Zynq7000 PS present on the PynqZ1 board.
The accelerator is interfaced with the PS through AXI lite.
The IP is mapped in the memory space of the PS.

The [crc_demo.ipynb](./crc_demo.ipynb) is the notebook which demonstrates the
AXI IP interacting with the Zynq Processing System.

The notebook is commented and documented to make it easier for everyone to 
follow.
The main takeaway from the demonstration is that the CRC32 accelerator is  
~60x faster than a python crc library while computing for a 4kB image.
To our knowledge, the ARM processor on the Zynq7000 FPGA does not have a 
dedicated CRC Accelerator on board.
This explains the speedup we get from a dedicated accelerator.
