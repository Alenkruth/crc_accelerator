#!/usr/bin/env python3

import siliconcompiler                        # import python package
from os import getcwd
  
chip = siliconcompiler.Chip('crc')  # create chip object
chip.input('crc.v')                 # define list of source files
#chip.input(f'{fill}parameterized_crc.sdc')               # set constraints file
chip.load_target("freepdk45_demo")        # load predefined target
#chip.load_target("skywater130_demo")        # load predefined target
# let us try runnin the same thing on the Siliconcompiler server farm
chip.set('option', 'remote', False)
chip.run()                                # run compilation
chip.summary()                            # print results summary
chip.show()                               # show layout file

if __name__ == '__main__':
    main()
