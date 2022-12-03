# Amstrad/Schneider CPC floppy controllers

> :warning: **This is a work in progress**: Don't fabricate PCBs from these files yet!

This project started as attempt to clone the Vortex F1-D floppy
controller, which supports two 720k DSDD drives.  The desire was to
have a controller that can support four drives at the same time.  The
starting point was a capture of the original PCB into a schematic,
which can be found in the [original](original/) directory.

![Vortex F1-D PCB](original-pcb-front-populated.jpg)

Multiple variants have been designed, but none of the designs in this
repository have been tested, don't fabricate any PCBs at this point!

# no-rom

![rendered picture of the no-rom PCB variant (front)](no-rom/vortex-f1-d-no-rom-front.png)
![rendered picture of the no-rom PCB variant (back)](no-rom/vortex-f1-d-no-rom-back.png)

The [no-rom](no-rom/) variant contains a revised, but wasteful address
decoder and no ROM socket.  It works to some extent, but the first
revisions contained multiple errors and required several patches.  The
version in this repository has the fixes applied, but was not yet
fabricated and tested.

# no-rom-cpld

![rendered picture of the no-rom-cpld variant (front)](no-rom-cpld/vortex-f1-d-no-rom-cpld-front.png)
![rendered picture of the no-rom-cpld variant (back)](no-rom-cpld/vortex-f1-d-no-rom-cpld-back.png)

The [no-rom-cpld](no-rom-cpld/) variant replaces the TTL chips with a
CPLD, reducing the part count significantly.

# rom-cpld

![rendered picture of the rom-cpld variant (front)](rom-cpld/vortex-f1-d-cpld-front.png)
![rendered picture of the rom-cpld variant (back)](rom-cpld/vortex-f1-d-cpld-back.png)

The [rom-cpld](rom-cpld/) variant adds a Flash ROM that can act as a universal
ROM box in addition to holding an operating system ROM to drive the
floppy disk controller.

