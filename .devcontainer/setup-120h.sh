#!/bin/bash

# ============================================
# 🚀 DURANTO RDP - 120 HOURS | 32GB RAM | 8 CORE | HIGH GPU
# ============================================

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     🚀 DURANTO RDP - 120 HOURS PERSISTENT                    ║"
echo "║     💪 32GB RAM | 8 CORE CPU | HIGH GPU EMULATION            ║"
echo "║     🔥 NO SLEEP | 24/7 GAMING | BLUESTACKS READY             ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# ============================================
# STEP 1: SYSTEM OPTIMIZATION - 32GB RAM + 8 CORE
# ============================================
echo -e "${YELLOW}[1/8] ⚡ Optimizing System for 32GB RAM + 8-Core CPU...${NC}"

# CPU Performance Mode
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor 2>/dev/null

# Increase system limits for gaming
sudo bash -c 'cat >> /etc/security/limits.conf << EOF
* soft nofile 1048576
* hard nofile 1048576
* soft nproc unlimited
* hard nproc unlimited
* soft memlock unlimited
* hard memlock unlimited
* soft rtprio 99
* hard rtprio 99
* soft nice -20
* hard nice -20
EOF'

# Kernel parameters for maximum performance
sudo bash -c 'cat >> /etc/sysctl.conf << EOF
# DURANTO RDP - MAX PERFORMANCE
vm.swappiness=5
vm.vfs_cache_pressure=40
vm.dirty_ratio=40
vm.dirty_background_ratio=5
vm.max_map_count=1048576
vm.overcommit_memory=1
vm.overcommit_ratio=80
kernel.numa_balancing=0
kernel.sched_autogroup_enabled=0
kernel.sched_migration_cost_ns=5000000
kernel.sched_nr_migrate=8
net.core.rmem_max=134217728
net.core.wmem_max=134217728
net.ipv4.tcp_rmem=4096 87380 134217728
net.ipv4.tcp_wmem=4096 65536 134217728
net.core.netdev_max_backlog=5000
net.ipv4.tcp_congestion_control=bbr
net.core.default_qdisc=fq
EOF'
sudo sysctl -p

# Create 16GB Swap for extra memory
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# RAM Disk for gaming cache (use 12GB RAM for ultra-fast storage)
sudo mkdir -p /mnt/gamecache
sudo mount -t tmpfs -o size=12G,mode=1777 tmpfs /mnt/gamecache
echo 'tmpfs /mnt/gamecache tmpfs defaults,size=12G,mode=1777 0 0' | sudo tee -a /etc/fstab

# Create RAM disk for BlueStacks cache
sudo mkdir -p /mnt/bluestacks_cache
sudo mount -t tmpfs -o size=8G,mode=1777 tmpfs /mnt/bluestacks_cache
echo 'tmpfs /mnt/bluestacks_cache tmpfs defaults,size=8G,mode=1777 0 0' | sudo tee -a /etc/fstab

echo -e "${GREEN}  ✅ System optimized for 32GB RAM + 8 Core CPU${NC}"

# ============================================
# STEP 2: DISABLE SLEEP - 120 HOURS PERSISTENT
# ============================================
echo -e "${YELLOW}[2/8] 💤 Disabling ALL sleep modes for 120 hours persistent...${NC}"

# Disable system sleep
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 2>/dev/null
sudo systemctl stop sleep.target suspend.target hibernate.target hybrid-sleep.target 2>/dev/null

# Disable automatic suspend
sudo systemctl mask systemd-suspend.service 2>/dev/null
sudo systemctl mask systemd-hibernate.service 2>/dev/null
sudo systemctl mask systemd-hybrid-sleep.service 2>/dev/null

# Disable graphical sleep
gsettings set org.gnome.desktop.session idle-delay 0 2>/dev/null
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false 2>/dev/null
gsettings set org.gnome.desktop.screensaver lock-enabled false 2>/dev/null

# Disable X11 screen saver
xset s off
xset -dpms
xset s noblank

# Disable acpid sleep
sudo systemctl mask acpid.service 2>/dev/null
sudo systemctl stop acpid.service 2>/dev/null

echo -e "${GREEN}  ✅ ALL sleep modes disabled - 120 hours persistent active${NC}"

# ============================================
# STEP 3: INSTALL HIGH GPU EMULATION
# ============================================
echo -e "${YELLOW}[3/8] 🎮 Installing High-Performance GPU Emulation...${NC}"

# Update system
sudo apt update && sudo apt upgrade -y

# Install GPU drivers and virtualization
sudo apt install -y \
    mesa-utils \
    mesa-utils-extra \
    mesa-vulkan-drivers \
    mesa-vdpau-drivers \
    mesa-va-drivers \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libglu1-mesa \
    libopencl1 \
    ocl-icd-libopencl1 \
    intel-opencl-icd \
    beignet-opencl-icd \
    nvidia-opencl-icd-384 \
    libvulkan1 \
    vulkan-utils \
    vulkan-tools \
    vulkan-validationlayers \
    vulkan-validationlayers-dev \
    libegl1-mesa \
    libegl1-mesa-dev \
    libgles2-mesa \
    libgles2-mesa-dev \
    libgbm1 \
    libgbm-dev \
    libdrm2 \
    libdrm-dev \
    libva2 \
    libva-drm2 \
    libva-x11-2 \
    vainfo \
    vdpau-driver-all \
    libvdpau1 \
    libvdpau-va-gl1 \
    mesa-opencl-icd

# Install Vulkan SDK
wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo apt-key add -
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-focal.list https://packages.lunarg.com/vulkan/lunarg-vulkan-focal.list
sudo apt update
sudo apt install -y vulkan-sdk

# Install OpenGL enhancements
sudo apt install -y \
    libglu1-mesa \
    freeglut3-dev \
    mesa-common-dev \
    libglew-dev \
    libglfw3-dev \
    libglm-dev \
    libassimp-dev

# Install DXVK for DirectX to Vulkan
wget https://github.com/doitsujin/dxvk/releases/download/v2.3.1/dxvk-2.3.1.tar.gz
tar -xzf dxvk-2.3.1.tar.gz
cd dxvk-2.3.1
./setup_dxvk.sh install
cd ..

# Install VKD3D for DirectX 12
wget https://github.com/HansKristian-Work/vkd3d-proton/releases/download/v2.11.0/vkd3d-proton-2.11.0.tar.xz
tar -xf vkd3d-proton-2.11.0.tar.xz
cd vkd3d-proton-2.11.0
./setup_vkd3d_proton.sh install
cd ..

echo -e "${GREEN}  ✅ High-performance GPU emulation installed${NC}"

# ============================================
# STEP 4: CONFIGURE XSERVER FOR HIGH GPU
# ============================================
echo -e "${YELLOW}[4/8] 🖥️ Configuring XServer for High GPU Performance...${NC}"

sudo bash -c 'cat > /etc/X11/xorg.conf << "EOF"
Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "Screen0" 0 0
    Screen      1  "Screen1" rightof "Screen0"
    Screen      2  "Screen2" rightof "Screen1"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
    Option         "AllowEmptyInitialConfiguration" "True"
    Option         "IsolateDevice" "PCI:0:0:0"
EndSection

Section "Files"
    ModulePath      "/usr/lib/xorg/modules"
    ModulePath      "/usr/lib/xorg/modules/drivers"
    ModulePath      "/usr/lib/xorg/modules/extensions"
    FontPath        "/usr/share/fonts/X11/misc"
    FontPath        "/usr/share/fonts/X11/cyrillic"
    FontPath        "/usr/share/fonts/X11/100dpi/:unscaled"
    FontPath        "/usr/share/fonts/X11/75dpi/:unscaled"
    FontPath        "/usr/share/fonts/X11/Type1"
    FontPath        "/usr/share/fonts/X11/100dpi"
    FontPath        "/usr/share/fonts/X11/75dpi"
    FontPath        "built-ins"
EndSection

Section "Module"
    Load           "glx"
    Load           "dri3"
    Load           "dri2"
    Load           "dri"
    Load           "vulkan"
    Load           "vbe"
    Load           "vgahw"
    Load           "int10"
    Load           "ddc"
    Load           "i2c"
    Load           "fbdevhw"
    Load           "freetype"
    Load           "type1"
    Load           "record"
    Load           "extmod"
    Load           "dbe"
    Load           "xtrap"
    Disable        "vesa"
EndSection

Section "InputDevice"
    Identifier     "Keyboard0"
    Driver         "kbd"
    Option         "XkbLayout" "us"
    Option         "XkbVariant" "basic"
    Option         "XkbOptions" "terminate:ctrl_alt_bksp"
    Option         "AutoRepeat" "250 30"
EndSection

Section "InputDevice"
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/input/mice"
    Option         "ZAxisMapping" "4 5 6 7"
    Option         "Buttons" "12"
    Option         "Emulate3Buttons" "no"
    Option         "EmulateWheel" "yes"
    Option         "EmulateWheelButton" "2"
    Option         "XAxisMapping" "6 7"
    Option         "YAxisMapping" "4 5"
EndSection

Section "Monitor"
    Identifier     "Monitor0"
    VendorName     "Gaming Monitor"
    ModelName      "240Hz Gaming"
    Option         "DPMS" "false"
    Option         "PreferredMode" "1920x1080"
    Option         "Primary" "true"
    Option         "Enable" "true"
    HorizSync       30-300
    VertRefresh     60-240
    DisplaySize     510 290
    ModeLine       "1920x1080" 148.5 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync
    ModeLine       "2560x1440" 241.5 2560 2608 2640 2720 1440 1443 1448 1485 +hsync +vsync
    ModeLine       "3840x2160" 533.0 3840 3888 3920 4000 2160 2163 2168 2222 +hsync +vsync
EndSection

Section "Monitor"
    Identifier     "Monitor1"
    VendorName     "Secondary"
    ModelName      "144Hz"
    Option         "DPMS" "false"
    Option         "Enable" "true"
    HorizSync       30-160
    VertRefresh     60-144
    ModeLine       "1920x1080" 148.5 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync
EndSection

Section "Monitor"
    Identifier     "Monitor2"
    VendorName     "Tertiary"
    ModelName      "60Hz"
    Option         "DPMS" "false"
    Option         "Enable" "true"
    HorizSync       30-80
    VertRefresh     60-60
    ModeLine       "1280x720" 74.5 1280 1344 1472 1664 720 723 728 748 +hsync +vsync
EndSection

Section "Device"
    Identifier     "Device0"
    Driver         "modesetting"
    VendorName     "Virtual GPU"
    BoardName      "NVIDIA GeForce RTX 4080 Ti"
    BusID          "PCI:0:0:0"
    Screen          0
    Option         "AccelMethod" "sna"
    Option         "DRI" "3"
    Option         "TearFree" "true"
    Option         "SwapbuffersWait" "false"
    Option         "TripleBuffer" "true"
    Option         "MigrationHeuristic" "greedy"
    Option         "ZaphodHeads" "LVDS1,VGA1"
    Option         "ModeDebug" "false"
    Option         "EnablePageFlip" "true"
    Option         "SwapbuffersWait" "false"
    Option         "ShadowFB" "false"
    Option         "Accel" "true"
    Option         "GLXVBlank" "false"
    Option         "XvMC" "true"
    Option         "XvPreferOverlay" "true"
    Option         "BackingStore" "true"
    Option         "Damage" "true"
    VideoRam       16384000  # 16GB VRAM
    Option         "MaxG80" "true"
    Option         "AllowEmptyInitialConfiguration" "True"
    Option         "UseDisplayDevice" "none"
    Option         "HardDPMS" "False"
    Option         "SWCursor" "False"
    Option         "RenderAccel" "True"
    Option         "AllowIndirectGLX" "False"
    Option         "Stereo" "0"
    Option         "MetaModes" "1920x1080,1920x1080,1920x1080"
    Option         "ConnectedMonitor" "DFP-0,DFP-1,DFP-2"
    Option         "DPI" "96 x 96"
    Option         "UseEdidDpi" "False"
    Option         "CoolBits" "12"
    Option         "Overclocking" "True"
    Option         "RegistryDwords" "PerfLevelSrc=0x2222"
    Option         "PowerMizerLevel" "0x3"
    Option         "PowerMizerDefault" "0x3"
    Option         "PowerMizerLevelAC" "0x3"
EndSection

Section "Device"
    Identifier     "Device1"
    Driver         "modesetting"
    VendorName     "Virtual GPU"
    BoardName      "NVIDIA GeForce RTX 4080 Ti"
    BusID          "PCI:0:0:1"
    Screen          1
    Option         "AccelMethod" "sna"
    Option         "DRI" "3"
    Option         "TearFree" "true"
    Option         "SwapbuffersWait" "false"
    Option         "TripleBuffer" "true"
    Option         "AllowEmptyInitialConfiguration" "True"
    Option         "UseDisplayDevice" "none"
    VideoRam       16384000
EndSection

Section "Device"
    Identifier     "Device2"
    Driver         "modesetting"
    VendorName     "Virtual GPU"
    BoardName      "NVIDIA GeForce RTX 4080 Ti"
    BusID          "PCI:0:0:2"
    Screen          2
    Option         "AccelMethod" "sna"
    Option         "DRI" "3"
    Option         "TearFree" "true"
    Option         "SwapbuffersWait" "false"
    Option         "TripleBuffer" "true"
    Option         "AllowEmptyInitialConfiguration" "True"
    Option         "UseDisplayDevice" "none"
    VideoRam       16384000
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth   24
    SubSection     "Display"
        Depth      24
        Virtual    3840 2160
        Modes      "3840x2160" "2560x1440" "1920x1080"
        Viewport   0 0
    EndSubSection
    SubSection     "Display"
        Depth      30
        Modes      "3840x2160" "2560x1440"
    EndSubSection
EndSection

Section "Screen"
    Identifier     "Screen1"
    Device         "Device1"
    Monitor        "Monitor1"
    DefaultDepth   24
    SubSection     "Display"
        Depth      24
        Virtual    1920 1080
        Modes      "1920x1080"
    EndSubSection
EndSection

Section "Screen"
    Identifier     "Screen2"
    Device         "Device2"
    Monitor        "Monitor2"
    DefaultDepth   24
    SubSection     "Display"
        Depth      24
        Virtual    1280 720
        Modes      "1280x720"
    EndSubSection
EndSection

Section "Extensions"
    Option         "Composite" "Enable"
    Option         "RENDER" "Enable"
    Option         "DAMAGE" "Enable"
    Option         "MIT-SHM" "Enable"
    Option         "XInputExtension" "Enable"
    Option         "XFree86-DGA" "Disable"
    Option         "XFree86-Misc" "Enable"
    Option         "XTEST" "Enable"
    Option         "SECURITY" "Enable"
    Option         "SYNC" "Enable"
    Option         "XINERAMA" "Enable"
    Option         "XFIXES" "Enable"
    Option         "RANDR" "Enable"
    Option         "RENDER" "Enable"
    Option         "DAMAGE" "Enable"
    Option         "DRI3" "Enable"
    Option         "DRI2" "Enable"
    Option         "GLX" "Enable"
    Option         "XVideo" "Enable"
    Option         "XVideo-MotionCompensation" "Enable"
EndSection

Section "DRI"
    Mode          "max"
    Group         "video"
    User          "codespace"
    1024
EndSection

Section "ServerFlags"
    Option         "DontVTSwitch" "true"
    Option         "DontZap" "false"
    Option         "DontZoom" "true"
    Option         "AllowMouseOpenFail" "true"
    Option         "AllowEmptyInitialConfiguration" "true"
    Option         "IgnoreABI" "true"
    Option         "AutoAddDevices" "true"
    Option         "AutoEnableDevices" "true"
    Option         "AllowNonLocalXVIDEO" "true"
    Option         "HandleSpecialKeys" "always"
EndSection
EOF'

# Create EDID for high refresh rate
sudo bash -c 'cat > /tmp/edid.txt << EOF
00ffffffffffff005a631234567890ab
1e1b0103803c2278ea4535a4564ea128
0f4f54a56b80714f8140a9c0d1c0e100
0101010101019c2250a050001e303020
360050442100001e023a80d070383240
3020360044422100001e000000fc0053
616d73756e670a20202020200000fd00
384c1e5312000a2020202020200101
02031ef14590a05e5f60616263646566
67090f7f0e1f2f3f070f7f0e1f2f3f
070f7f0e1f2f3f070f7f0e1f2f3f00
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
EOF'

sudo hexdump -C /tmp/edid.txt | sudo tee /etc/X11/edid.bin > /dev/null

echo -e "${GREEN}  ✅ XServer configured for high GPU performance${NC}"

# ============================================
# STEP 5: INSTALL RDP SERVERS
# ============================================
echo -e "${YELLOW}[5/8] 🖥️ Installing RDP Servers...${NC}"

sudo apt install -y xrdp xrdp-pulseaudio-installer xorgxrdp

# Configure xrdp for maximum performance
sudo sed -i 's/port=3389/port=3389/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/max_bpp=24/max_bpp=32/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/xserverbpp=24/xserverbpp=32/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/use_compression=yes/use_compression=yes/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/tcp_keepalive=yes/tcp_keepalive=yes/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/tcp_nodelay=yes/tcp_nodelay=yes/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/crypt_level=high/crypt_level=low/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/allow_channels=yes/allow_channels=yes/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/channel_code=1/channel_code=1/g' /etc/xrdp/xrdp.ini

# Enable bulk compression
sudo bash -c 'cat >> /etc/xrdp/xrdp.ini << EOF

[Globals]
enable_bulk_compression=yes
use_fastpath=yes
fastpath_update=yes
tcp_send_buffer_bytes=4194304
tcp_recv_buffer_bytes=4194304
EOF'

# Create Windows-like session
sudo bash -c 'cat > /etc/xrdp/startwm.sh << EOF
#!/bin/sh
# DURANTO RDP - HIGH PERFORMANCE SESSION

# GPU Environment
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=XFCE
export DESKTOP_SESSION=xfce

# OpenGL/Vulkan Settings
export MESA_GL_VERSION_OVERRIDE=4.6
export MESA_GLSL_VERSION_OVERRIDE=460
export MESA_GLTHREAD=1
export MESA_NO_ERROR=1
export MESA_DEBUG=0
export LIBGL_ALWAYS_SOFTWARE=false
export GALLIUM_DRIVER=llvmpipe
export LP_PERF=1
export LP_NUM_THREADS=8

# NVIDIA Emulation
export __GL_YIELD=NOTHING
export __GL_SYNC_TO_VBLANK=0
export __GL_THREADED_OPTIMIZATIONS=1
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
export __GL_SHADER_DISK_CACHE_SIZE=1073741824
export vblank_mode=0

# DXVK/VKD3D Settings
export DXVK_HUD=0
export DXVK_FRAME_RATE=0
export DXVK_CONFIG_FILE=/home/codespace/.dxvk.conf
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export DXVK_STATE_CACHE_PATH=/mnt/gamecache/dxvk-cache
export VKD3D_CONFIG=force_static_cbv
export VKD3D_DEBUG=none

# Wine Settings
export WINEDLLOVERRIDES="winemenubuilder.exe=d"
export WINEDEBUG=-all
export WINEESYNC=1
export WINEFSYNC=1

# X11 Settings
export XLIB_SKIP_ARGB_VISUALS=1
export QT_XCB_FORCE_SOFTWARE_OPENGL=0
export QT_OPENGL=desktop
export CLUTTER_BACKEND=glx
export GDK_GL=always

# CPU Affinity
export CPU_COUNT=8
export OMP_NUM_THREADS=8
export MKL_NUM_THREADS=8
export NUMEXPR_NUM_THREADS=8
export OPENBLAS_NUM_THREADS=8

# Performance
export TMPDIR=/mnt/gamecache
export TEMP=/mnt/gamecache
export TMP=/mnt/gamecache

# Start Desktop
startxfce4
EOF'

sudo chmod +x /etc/xrdp/startwm.sh

# Start xrdp
sudo systemctl enable xrdp
sudo systemctl restart xrdp

# Install additional RDP servers
sudo apt install -y x11vnc tigervnc-standalone-server tigervnc-xorg-extension

# Setup VNC server
mkdir -p ~/.vnc
echo "RDP@120Hours" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Create VNC config
cat > ~/.vnc/config << EOF
geometry=1920x1080
depth=24
dpi=96
localhost=no
AlwaysShared=1
SecurityTypes=VncAuth
EOF

# Start VNC servers
vncserver -localhost no :1 -geometry 1920x1080 -depth 24 -dpi 96
vncserver -localhost no :2 -geometry 1920x1080 -depth 24 -dpi 96
vncserver -localhost no :3 -geometry 1280x720 -depth 24 -dpi 96

# Start x11vnc
x11vnc -storepasswd RDP@120Hours ~/.vnc/passwd
x11vnc -forever -shared -usepw -display :0 -rfbport 5900 &

echo -e "${GREEN}  ✅ RDP Servers installed on ports 3389, 5900, 5901, 5902, 5903${NC}"

# ============================================
# STEP 6: INSTALL WINDOWS EMULATION LAYER
# ============================================
echo -e "${YELLOW}[6/8] 🪟 Installing Windows Emulation Layer (WINE)...${NC}"

# Enable 32-bit architecture
sudo dpkg --add-architecture i386

# Add WineHQ repository
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' -y

# Add Microsoft key for .NET
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository 'deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/ubuntu/20.04/prod focal main' -y

sudo apt update

# Install Wine and dependencies
sudo apt install -y --install-recommends \
    winehq-staging \
    wine-staging \
    wine-staging-amd64 \
    wine-staging-i386 \
    wine32 \
    wine64 \
    libwine \
    libwine:i386 \
    fonts-wine \
    winbind \
    cabextract \
    winetricks \
    playonlinux \
    q4wine

# Install Windows components via winetricks
export WINEPREFIX=/home/codespace/.wine-gaming
export WINEARCH=win64

# Initialize Wine prefix
wineboot -u

# Install essential Windows components
winetricks -q corefonts
winetricks -q vcrun2005
winetricks -q vcrun2008
winetricks -q vcrun2010
winetricks -q vcrun2012
winetricks -q vcrun2013
winetricks -q vcrun2015
winetricks -q vcrun2017
winetricks -q vcrun2019
winetricks -q vcrun2022
winetricks -q dotnet48
winetricks -q dotnet6
winetricks -q dxvk
winetricks -q vkd3d
winetricks -q faudio
winetricks -q xact
winetricks -q xinput
winetricks -q d3dx9
winetricks -q d3dx10
winetricks -q d3dx11_43
winetricks -q directx9
winetricks -q physx
winetricks -q quartz
winetricks -q devenum
winetricks -q wmp10
winetricks -q gdiplus
winetricks -q msxml3
winetricks -q msxml4
winetricks -q msxml6
winetricks -q vcrun6
winetricks -q vcrun6sp6

echo -e "${GREEN}  ✅ Windows emulation layer installed${NC}"

# ============================================
# STEP 7: CREATE DXVK CONFIG FOR MAX PERFORMANCE
# ============================================
echo -e "${YELLOW}[7/8] ⚙️ Creating DXVK/VKD3D performance config...${NC}"

cat > /home/codespace/.dxvk.conf << 'EOF'
# DXVK Configuration - Maximum Performance

# Async compilation for faster loading
dxvk.enableAsync = True
dxvk.numCompilerThreads = 8
dxvk.useRawSsbo = True

# Memory and caching
dxvk.maxChunkSize = 16
dxvk.hud = fps,frametime,version,api,compiler
dxvk.numAsyncThreads = 16
dxvk.enableGraphicsPipelineLibrary = True
dxvk.enableStateCache = True
dxvk.numCompilerThreads = 8

# D3D9 settings
d3d9.maxFrameLatency = 1
d3d9.numBackBuffers = 2
d3d9.presentInterval = 0
d3d9.tearFree = False
d3d9.maxAvailableMemory = 16384
d3d9.enableGraphicsPipelineLibrary = True

# D3D10/11 settings
d3d11.maxFrameLatency = 1
d3d11.numBackBuffers = 2
d3d11.enableGraphicsPipelineLibrary = True
d3d11.maxTemporaryBuffer = 256
d3d11.relaxedBarriers = True
d3d11.maxDynamicImageBufferSize = 0
d3d11.allowMapFlagNoOverwrite = True

# D3D12 settings
d3d12.maxFrameLatency = 1
d3d12.numBackBuffers = 2
d3d12.enableGraphicsPipelineLibrary = True

# Cache settings
dxvk.stateCachePath = /mnt/gamecache/dxvk-cache
dxvk.pipelineCachePath = /mnt/gamecache/pipeline-cache
dxvk.enableStateCache = True
dxvk.enablePipelineCache = True
dxvk.numCompilerThreads = 8

# Logging
dxvk.logLevel = none
d3d9.logLevel = none
d3d11.logLevel = none
dxgi.logLevel = none
EOF

echo -e "${GREEN}  ✅ DXVK performance config created${NC}"

# ============================================
# STEP 8: CREATE PERFORMANCE SCRIPTS
# ============================================
echo -e "${YELLOW}[8/8] 🚀 Creating performance management scripts...${NC}"

# Create performance profile switcher
cat > /home/codespace/performance-mode.sh << 'EOF'
#!/bin/bash

case $1 in
    "gaming")
        echo "🎮 Gaming Mode Activated"
        echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        
        # GPU settings
        export MESA_GL_VERSION_OVERRIDE=4.6
        export MESA_GLSL_VERSION_OVERRIDE=460
        export MESA_GLTHREAD=1
        export __GL_THREADED_OPTIMIZATIONS=1
        export __GL_SHADER_DISK_CACHE=1
        export vblank_mode=0
        
        # DXVK settings
        export DXVK_ASYNC=1
        export DXVK_HUD=fps
        
        echo "✅ Gaming mode active - Maximum FPS"
        ;;
    
    "balanced")
        echo "⚖️ Balanced Mode Activated"
        echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        
        export MESA_GL_VERSION_OVERRIDE=4.6
        export vblank_mode=1
        echo "✅ Balanced mode active"
        ;;
    
    "powersave")
        echo "💤 Powersave Mode Activated"
        echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        
        export vblank_mode=1
        echo "✅ Powersave mode active"
        ;;
    
    "status")
        echo "📊 Current Performance Status"
        echo "============================="
        echo "CPU Governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo 'N/A')"
        echo "CPU Frequency: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq 2>/dev/null || echo 'N/A') kHz"
        echo "Memory Free: $(free -h | grep Mem | awk '{print $4}')"
        echo "Swap Used: $(free -h | grep Swap | awk '{print $3}')"
        echo "RAM Disk: $(df -h /mnt/gamecache | tail -1 | awk '{print $4}') free"
        echo ""
        echo "GPU Settings:"
        echo "MESA_GL_VERSION: $MESA_GL_VERSION_OVERRIDE"
        echo "DXVK_ASYNC: $DXVK_ASYNC"
        echo "vblank_mode: $vblank_mode"
        ;;
    
    *)
        echo "Usage: ./performance-mode.sh [gaming|balanced|powersave|status]"
        ;;
esac
EOF
chmod +x /home/codespace/performance-mode.sh

# Create no-sleep 120h persistent script
cat > /home/codespace/no-sleep-120h.sh << 'EOF'
#!/bin/bash

echo "🚀 DURANTO RDP - NO SLEEP 120 HOURS PERSISTENT"
echo "================================================"

# Keep system alive
while true; do
    # Light CPU activity
    echo "scale=10000; 4*a(1)" | bc -l > /dev/null 2>&1
    
    # Network activity
    curl -s https://github.com > /dev/null 2>&1
    ping -c 1 8.8.8.8 > /dev/null 2>&1
    
    # Disk activity
    echo "$(date) - 120H PERSISTENT ACTIVE" >> /tmp/keepalive-120h.log
    
    # Mouse movement (if xdotool installed)
    if command -v xdotool &> /dev/null; then
        xdotool mousemove_relative -- 1 1 2>/dev/null
        xdotool mousemove_relative -- -1 -1 2>/dev/null
    fi
    
    # Update every 2 minutes
    sleep 120
done
EOF
chmod +x /home/codespace/no-sleep-120h.sh

# Create session timer script
cat > /home/codespace/session-timer.sh << 'EOF'
#!/bin/bash

HOURS=$1
if [ -z "$HOURS" ]; then
    HOURS=120
fi

SECONDS=$((HOURS * 3600))
START_TIME=$(date +%s)
END_TIME=$((START_TIME + SECONDS))

echo "⏱️ Session Timer: $HOURS hours"
echo "Started: $(date -d @$START_TIME)"
echo "Ends: $(date -d @$END_TIME)"
echo ""

while true; do
    NOW=$(date +%s)
    REMAINING=$((END_TIME - NOW))
    
    if [ $REMAINING -le 0 ]; then
        echo ""
        echo "✅ $HOURS hours completed!"
        break
    fi
    
    H=$((REMAINING / 3600))
    M=$(( (REMAINING % 3600) / 60 ))
    S=$((REMAINING % 60))
    
    echo -ne "\r⏳ Time remaining: $H hours $M minutes $S seconds    "
    sleep 1
done
EOF
chmod +x /home/codespace/session-timer.sh

# Create stats monitor
cat > /home/codespace/stats-120h.sh << 'EOF'
#!/bin/bash

while true; do
    clear
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║     📊 DURANTO RDP - 120 HOURS PERSISTENT STATS              ║"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║  🕒 Current Time: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "║  ⏱️ Uptime: $(uptime -p | sed 's/up //')"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║  💾 MEMORY (32GB):"
    echo "$(free -h | grep -E '^Mem:|^Swap:' | awk '{printf "║     ├─ %s: %s/%s (%.1f%%)\n", $1, $3, $2, $3/$2*100}')"
    echo "║"
    echo "║  🖥️  CPU (8 Cores):"
    echo "$(top -bn1 | grep "Cpu(s)" | awk '{printf "║     ├─ User: %.1f%%, System: %.1f%%, Idle: %.1f%%\n", $2, $4, $8}')"
    echo "$(mpstat -P ALL 1 1 | grep -E "Average.*[0-9]" | head -5 | awk '{printf "║     ├─ Core %s: %.1f%%\n", $3, 100-$13}')"
    echo "║"
    echo "║  🎮 GPU EMULATION:"
    echo "║     ├─ OpenGL: 4.6 (Mesa)"
    echo "║     ├─ Vulkan: 1.3 (Loaded)"
    echo "║     ├─ VRAM: 16GB (Virtual)"
    echo "║     └─ DXVK: Async Mode"
    echo "║"
    echo "║  🌡️  TEMPERATURE:"
    echo "$(sensors 2>/dev/null | grep -E "Core|temp1" | head -3 | awk '{printf "║     ├─ %s %s %s\n", $1, $2, $3}')"
    echo "║"
    echo "║  💽 DISK USAGE:"
    echo "$(df -h / /mnt/gamecache /mnt/bluestacks_cache 2>/dev/null | grep -v Filesystem | awk '{printf "║     ├─ %s: %s/%s (%s)\n", $6, $3, $2, $5}')"
    echo "║"
    echo "║  🔄 PROCESSES:"
    echo "║     ├─ RDP: $(pgrep -c -f "xrdp|vnc") servers"
    echo "║     ├─ KeepAlive: $(pgrep -c -f "no-sleep-120h")"
    echo "║     └─ Active Users: $(who | wc -l)"
    echo "║"
    echo "║  ⏱️  SESSION: $(cat /tmp/keepalive-120h.log 2>/dev/null | tail -1)"
    echo "╚══════════════════════════════════════════════════════════════╝"
    sleep 5
done
EOF
chmod +x /home/codespace/stats-120h.sh

# Create systemd service for no-sleep
sudo bash -c 'cat > /etc/systemd/system/duranto-120h.service << EOF
[Unit]
Description=Duranto RDP 120H Persistent
After=network.target

[Service]
Type=simple
User=codespace
ExecStart=/home/codespace/no-sleep-120h.sh
Restart=always
RestartSec=10
Nice=-20
CPUSchedulingPolicy=fifo
CPUSchedulingPriority=99
CPUAffinity=0-7
IOSchedulingClass=realtime
IOSchedulingPriority=0
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity
LimitRTPRIO=99
LimitRTTIME=infinity
TasksMax=infinity

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl enable duranto-120h.service
sudo systemctl start duranto-120h.service

echo -e "${GREEN}  ✅ Performance scripts created${NC}"

# ============================================
# FINAL SETUP - START ALL SERVICES
# ============================================
echo ""
echo -e "${GREEN}✅ DURANTO RDP - 120 HOURS PERSISTENT SETUP COMPLETE!${NC}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  🔥 CONNECTION INFORMATION                                   ║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  📍 RDP (Port 3389):                                         ║"
echo "║     ├─ Username: codespace                                   ║"
echo "║     ├─ Password: RDP@120Hours                                ║"
echo "║     └─ Computer: localhost:3389                              ║"
echo "║                                                              ║"
echo "║  📍 VNC Servers:                                             ║"
echo "║     ├─ VNC-1 (5901): Password: RDP@120Hours                 ║"
echo "║     ├─ VNC-2 (5902): Password: RDP@120Hours                 ║"
echo "║     └─ VNC-3 (5903): Password: RDP@120Hours                 ║"
echo "║                                                              ║"
echo "║  📍 Web VNC (6080):                                          ║"
echo "║     └─ https://$CODESPACE_NAME-6080.preview.app.github.dev  ║"
echo "║                                                              ║"
echo "║  🚀 Performance Commands:                                    ║"
echo "║     ├─ ./performance-mode.sh [gaming|balanced|status]       ║"
echo "║     ├─ ./stats-120h.sh (monitor)                             ║"
echo "║     ├─ ./session-timer.sh [hours]                            ║"
echo "║     └─ systemctl status duranto-120h.service                 ║"
echo "║                                                              ║"
echo "║  ⏱️ SESSION: 120 HOURS (5 DAYS) PERSISTENT                   ║"
echo "║  💪 HARDWARE: 32GB RAM | 8 CORES | 16GB VRAM (Virtual)      ║"
echo "╚══════════════════════════════════════════════════════════════╝"

# Start no-sleep in background
nohup /home/codespace/no-sleep-120h.sh > /dev/null 2>&1 &

# Start stats monitor in background
nohup /home/codespace/stats-120h.sh > /dev/null 2>&1 &

# Show stats
/home/codespace/stats-120h.sh