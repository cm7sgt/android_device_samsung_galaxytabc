This is a beta build of CyanogenMod 7 gingerbread
by Technomancer TCMAN-dmg on freenode.net and irc.droid-life.com

Bug reports: open issues at http://github.com/cm7sgt/android_device_samsung_galaxytab/issues

This build is for beta testing, not for general consumption

CREDITS

See http://cmsgs.com for more info
The github for CMSGS Tab is http://github.com/cm7sgt

It is based on great work of CyanogenMod and CM SGS/Teamhacksung http://cmsgs.com

Thanks to codeworkx, coolya and noobnl and all beta testers.

INSTALLATION

Your Tab should be partitioned with gt-p1000_mr.pit
It should have Gingerbread bootloaders from JQ1.
Please use Bell I9000 JK5 modem.bin for AT&T Tab, and JQ1 modem.bin for Euro tabs. I am not sure about T-mobile, try JQ1.

To flash it, flash at least zImage and factoryfs.ext4 using Heimdall http://www.glassechidna.com.au/products/heimdall/
setup_fs should automatically reformat data,dbdata and cache to ext4 on first boot.
If not please reboot to recovery and try wipe from recovery.

Status
Voice: OK
3G Data: OK
Wifi: works
BT: sometimes stuck on startup, doesnt fully pair
GPS: working
Lights: OK
Sensors: OK
Camera: OK

Issues and workarounds
* Stuck on CM boot ani after flash
    After first install please start in recovery and do full wipe (select "wipe data/factory reset in recovery)

* BT doesnt start
    Try again
    Try rebooting
    If that doesnt help try "adb shell stop hciattach" Sometimes hciattach service gets stuck when starting.

Changelog:
2011-05-30
    Fix problems with headphones/headsets and libaudio, kanged common-aries libaudio.
    Added OMX libraries and overlay from common-aries.

2011-05-28r2
    Fixed setup_fs so it properly formats partitions.
    Enabled more tablet tweaks (soft buttons).
    Removed format for .android_secure in recovery, should fix wipe.
2011-05-28
    Switched to Gingerbread kernel 2.6.35.7 recently released by Samsung.
    Use JQ1 binary drivers for OpenGL, sensors, lights, copybit, overylay, camera etc, so they all work!
    Portrait is default orientation now, ro.sf.hwrotation=90 is set and touchscreen events are rotated in input layer so they match.

2011-04-21
    Fix mounting Tab as USB drive (ums switch in kernel reported "ums online" instead of "online" that vold expects)
    Fixed phone calls. Reapply RIL.java and RILConstants.java patches from cmsgs frameworks_base.

2011-04-20
    Cleanup of init scripts, added /sdcard and /emmc links.

2011-04-05
    Fixed suid/root issues. Refreshed and rebuilt with latest.

2011-03-30
    Built from new repo branched off teamhacksung.
    overlay and libstagefrighthw (video accell) disabled so it is stable now.
    Camera is disabled (stubbed).
    data, dbdata and cache partition switched to ext4.

2011-03-02
    Added source modules for pvrsrvkm, s3c_bc and s3c_lcd to kernel sources and build them from scratch
    Refreshed, merged and rebuilt, media scanner works again
2011-03-01
    Refreshed and merged latest frameworks etc from CM repo
    Rebuilt everything
    Use vold built from source

2011-02-17
    Refreshed repo and rebuild
    initramfs built from sources instead of checked in, still far from automated build tho ;-(
2011-02-07
    Refreshed repo and rebuilt.
    Backed out codeworkx's bluetooth fix, it seems to make things worse. Added stopping and cleaning up hciattach if it fails. Now if Bluetooth start fails, just try starting it again.
    Removed overlay and copybit built from source, they cant both be installed. Use binary copybit since the ones built from the source use wrong kernel headers. Camera shows some signs of life now.
    Patched code that calls gralloc to remove usage flags not known by froyo gralloc.
    
2011-02-03 New kernel from Update1
    Refreshed repo and rebuild with latest
    added codeworkx's brcm_patchram_plus fix that should hopefully fix bluetooth initialization
    
2011-01-31 GPS should work now
    Used Nexus S GPS binaries
    Switched to init compiled from sources
    Switched to CWM 3.x (still very broken)

2011-01-29 Fixed 3G data

2011-01-28 First beta release


--
Dominik

