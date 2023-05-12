import siliconcompiler

def setup(chip):
    # Core values.
    design = 'freepdk45_sram_4k'
    stackup = chip.get('option', 'stackup')

    # Create Library object to represent the macro.
    lib = siliconcompiler.Library(chip, design)
    lib.set('output', stackup, 'gds', 'sram/freepdk45_sram_4kbytes_1rw_32x1024_8.gds')
    lib.set('output', stackup, 'lef', 'sram/freepdk45_sram_4kbytes_1rw_32x1024_8.lef')
    # Set the 'copy' field to True to pull these files into the build directory during
    # the 'import' task, which makes them available for the remote workflow to use.
    lib.set('output', stackup, 'gds', True, field='copy')
    lib.set('output', stackup, 'lef', True, field='copy')
    return lib
