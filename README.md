# Parameterized CRC Accelerator
A parameterized CRC accelerator in Verilog, interfaced with AMD-Xilinx Zynq 7000 through AXI-Lite
and implemented on a Pynq-Z1 Board from Digilent.

## Using the Accelerator in your projects/Reproducing the Results.
The designed accelerator is integrated as an IP with AMD-Xilinx Vivado IP Manager.
The block diagram of the design can be found [here](docs/reports_and_proposals/design_1.pdf).

A detailed report can be found in our [UVA ECE Wiki page](http://venividiwiki.ee.virginia.edu/mediawiki/index.php/Parameterized_CRC_Accelerator#Objective_and_Introduction_to_the_Project). (Accessible through the UVA network). 
The XML version of the page can be found [here](docs/reports_and_proposals/wiki.xml).

In order to reproduce the results, you will need a Pynq-Z1 board which boots from 
the provided SD card image and is able to connect to the internet.
Steps to follow:
- Download/Clone this repository and checkout the dev_fpga branch.
- Connect to your board to the internet and access the board with the IP assigned to it.
- Once you log into the Jupyter Notebook Server hosted on the board, upload the [overlay](./overlay) 
  directory to the root directory of the board. The demo should irrespective of the path.
- Open the _overlay_ directory within the localhost and then open the [crc_demo.ipynb](./overlay/crc_demo.ipynb)
  file.
- The jupyter notebook should open and you should be able to execute the code present.

## Changelog
2023-05-09: The repository has undergone multiple changes including multiple revisions
to the top CRC module. The overlay directory contains the Pynq Overlay and the associated 
Jupyter notebook.

2023-04-19: The current version is unoptimized. The design was synthesizable
on Xilinx Vivado 2021 with the Zynq 7000 as the target. The design is also
simulable on ModelSim. The design does not synthesize with Yosys on the OpenLane
flow.
