export ALLOW_MISSING_DEPENDENCIES=true
git clone https://gitlab.com/HayateDevTH/avb_tool -b main out/host/linux-x86/bin
sudo chmod +rwx out/host/linux-x86/bin/avbtool
chmod a+x device/samsung/a12s/mkbootimg
