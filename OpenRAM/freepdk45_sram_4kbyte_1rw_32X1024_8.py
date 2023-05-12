"""
Single port, 4 kbytes SRAM, with byte write, useful for RISC-V processor main
memory.
"""
word_size = 32 # Bits
num_words = 1024
human_byte_size = "{:.0f}kbytes".format((word_size * num_words)/1024/8)

# Allow byte writes
write_size = 8 # Bits

# Single port
num_rw_ports = 1
num_r_ports = 0
num_w_ports = 0
num_spare_rows = 1
num_spare_cols = 1
ports_human = '1rw'

#import os
#exec(open(os.path.join(os.path.dirname(__file__), 'sky130_sram_common.py')).read())

tech_name = "freepdk45"
nominal_corner_only = True

# Local wordlines have issues with met3 power routing for now
#local_array_size = 16

#route_supplies = "ring"
#route_supplies = "left"
check_lvsdrc = True
#uniquify = True
#perimeter_pins = False
#netlist_only = True
#analytical_delay = False

output_name = "{tech_name}_sram_{human_byte_size}_{ports_human}_{word_size}x{num_words}_{write_size}".format(**locals())
output_path = "temp/{output_name}".format(**locals())

