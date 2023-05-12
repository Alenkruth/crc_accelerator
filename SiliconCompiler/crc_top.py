#!/usr/bin/env python3

import siliconcompiler
#import sram
    
#design = 'crc_top'
die_width = 1000
die_height = 1000

from os import getcwd
from sram import freepdk45_sram_4k

#from freepdk45_sram_4k import setup

#def main():
#    cwd = getcwd();
#    if "integration/" in cwd:
#    	fill = ""
#    else: fill = "integration/"
    
chip = siliconcompiler.Chip('crc_top')
chip.load_target("freepdk45_demo")

# Set input source files.
chip.input('crc_top.v')
chip.input('crc.v')
chip.input('sram/freepdk45_sram_4k.bb.v')

# Set clock period, so that we won't need to provide an SDC constraints file.
chip.clock('clk', period=10)

# Set die outline and core area.
chip.set('constraint', 'outline', [(0,0), (die_width, die_height)])
chip.set('constraint', 'corearea', [(10,10), (die_width-10, die_height-10)])

# Setup SRAM macro library.
from sram import freepdk45_sram_4k
chip.use(freepdk45_sram_4k)
chip.add('asic', 'macrolib', 'freepdk45_sram_4k')

# SRAM pins are inside the macro boundary; no routing blockage padding is needed.
chip.set('tool', 'openroad', 'task', 'route', 'var', 'grt_macro_extension', '0')
# Disable CDL file generation until we can find a CDL file for the SRAM block.
chip.set('tool', 'openroad', 'task', 'export', 'var', 'write_cdl', 'false')

# Place macro instance.
#chip.set('constraint', 'component', 'sram', 'placement', (500.0, 250.0, 0.0))
#chip.set('constraint', 'component', 'sram', 'rotation', 270)

# Build on a remote server and generate summary
chip.set('option', 'remote', False)
chip.run()
chip.summary()
chip.show()

#if __name__ == '__main__':
#    main()
