#!/bin/bash

# Revision: 2023.04.10
# (GNU/General Public License version 3.0)
# by eznix (https://sourceforge.net/projects/ezarch/)\

#Based on steps.sh by eznix, modified to suit AZOS GNU/Linux by Red Fire Software Entertainment

#LEGAL INFO ABOUT AZOS GNU/Linux DOES NOT APPLY HERE!
#THIS SOFTWARE IS UNDER THE TERMS OF EZNIX!

# ----------------------------------------
# Define Variables
# ----------------------------------------

LCLST="en_US"
# Format is language_COUNTRY where language is lower case two letter code
# and country is upper case two letter code, separated with an underscore

KEYMP="us"
# Use lower case two letter country code

KEYMOD="pc105"
# pc105 and pc104 are modern standards, all others need to be researched

MYUSERNM="live"
# use all lowercase letters only

MYUSRPASSWD=""
# Pick a password of your choice

RTPASSWD="root"
# Pick a root password

MYHOSTNM="azos"
# Pick a hostname for the machine

CURDIR=$(pwd)

# ----------------------------------------
# Functions
# ----------------------------------------

# Display line error
handlerror () {
clear
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
}

# Clean up
cleanup () {
[[ -d ./azdir ]] && rm -r ./azdir
[[ -d ./work ]] && rm -r ./work
[[ -d ./out ]] && mv ./out ../
sleep 2
}

# Requirements and preparation
prepreqs () {
pacman -S --needed --noconfirm archiso mkinitcpio-archiso
}

# Copy azdir to working directory and azrepo to /etc
cpazdir () {
cp etc/azrepo /etc
cp -r /usr/share/archiso/configs/releng/ ./azdir
rm ./azdir/airootfs/etc/motd
rm -r ./azdir/airootfs/etc/pacman.d
rm -r ./azdir/airootfs/etc/xdg
rm -r ./azdir/grub
rm -r ./azdir/efiboot
rm -r ./azdir/syslinux
}

# Remove auto-login, cloud-init, hyper-v, ied, sshd, & vmware services
rmunitsd () {
rm -r ./azdir/airootfs/etc/systemd/system/cloud-init.target.wants
rm -r ./azdir/airootfs/etc/systemd/system/getty@tty1.service.d
rm ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/hv_fcopy_daemon.service
rm ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/hv_kvp_daemon.service
rm ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/hv_vss_daemon.service
rm ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/vmware-vmblock-fuse.service
rm ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/vmtoolsd.service
rm ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/sshd.service
rm ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/iwd.service
}

# Add cups, haveged, NetworkManager, & sddm systemd links
addnmlinks () {
mkdir -p ./azdir/airootfs/etc/systemd/system/network-online.target.wants
mkdir -p ./azdir/airootfs/etc/systemd/system/multi-user.target.wants
mkdir -p ./azdir/airootfs/etc/systemd/system/printer.target.wants
mkdir -p ./azdir/airootfs/etc/systemd/system/sockets.target.wants
mkdir -p ./azdir/airootfs/etc/systemd/system/timers.target.wants
mkdir -p ./azdir/airootfs/etc/systemd/system/sysinit.target.wants
ln -sf /usr/lib/systemd/system/NetworkManager-wait-online.service ./azdir/airootfs/etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service
ln -sf /usr/lib/systemd/system/NetworkManager-dispatcher.service ./azdir/airootfs/etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service
ln -sf /usr/lib/systemd/system/NetworkManager.service ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/NetworkManager.service
ln -sf /usr/lib/systemd/system/haveged.service ./azdir/airootfs/etc/systemd/system/sysinit.target.wants/haveged.service
ln -sf /usr/lib/systemd/system/cups.service ./azdir/airootfs/etc/systemd/system/printer.target.wants/cups.service
ln -sf /usr/lib/systemd/system/cups.socket ./azdir/airootfs/etc/systemd/system/sockets.target.wants/cups.socket
ln -sf /usr/lib/systemd/system/cups.path ./azdir/airootfs/etc/systemd/system/multi-user.target.wants/cups.path
ln -sf /usr/lib/systemd/system/sddm.service ./azdir/airootfs/etc/systemd/system/display-manager.service
}

# Copy files to customize the ISO
cpmyfiles () {
cp pacman.conf ./azdir/
cp profiledef.sh ./azdir/
cp packages.x86_64 ./azdir/
cp -r grub ./azdir/
cp -r efiboot ./azdir/
cp -r syslinux ./azdir/
cp -r etc ./azdir/airootfs/
cp -r usr ./azdir/airootfs/
}

# Set hostname
sethostname () {
echo "${MYHOSTNM}" > ./azdir/airootfs/etc/hostname
}

# Create passwd file
crtpasswd () {
echo "root:x:0:0:root:/root:/usr/bin/bash
"${MYUSERNM}":x:1010:1010::/home/"${MYUSERNM}":/bin/bash" > ./azdir/airootfs/etc/passwd
}

# Create group file
crtgroup () {
echo "root:x:0:root
sys:x:3:"${MYUSERNM}"
adm:x:4:"${MYUSERNM}"
wheel:x:10:"${MYUSERNM}"
log:x:18:"${MYUSERNM}"
network:x:90:"${MYUSERNM}"
floppy:x:94:"${MYUSERNM}"
scanner:x:96:"${MYUSERNM}"
power:x:98:"${MYUSERNM}"
uucp:x:810:"${MYUSERNM}"
audio:x:820:"${MYUSERNM}"
lp:x:830:"${MYUSERNM}"
rfkill:x:840:"${MYUSERNM}"
video:x:850:"${MYUSERNM}"
storage:x:860:"${MYUSERNM}"
optical:x:870:"${MYUSERNM}"
sambashare:x:880:"${MYUSERNM}"
users:x:985:"${MYUSERNM}"
"${MYUSERNM}":x:1010:" > ./azdir/airootfs/etc/group
}

# Create shadow file
crtshadow () {
usr_hash=$(openssl passwd -6 "${MYUSRPASSWD}")
root_hash=$(openssl passwd -6 "${RTPASSWD}")
echo "root:"${root_hash}":14871::::::
"${MYUSERNM}":"${usr_hash}":14871::::::" > ./azdir/airootfs/etc/shadow
}

# create gshadow file
crtgshadow () {
echo "root:!*::root
sys:!*::"${MYUSERNM}"
adm:!*::"${MYUSERNM}"
wheel:!*::"${MYUSERNM}"
log:!*::"${MYUSERNM}"
network:!*::"${MYUSERNM}"
floppy:!*::"${MYUSERNM}"
scanner:!*::"${MYUSERNM}"
power:!*::"${MYUSERNM}"
uucp:!*::"${MYUSERNM}"
audio:!*::"${MYUSERNM}"
lp:!*::"${MYUSERNM}"
rfkill:!*::"${MYUSERNM}"
video:!*::"${MYUSERNM}"
storage:!*::"${MYUSERNM}"
optical:!*::"${MYUSERNM}"
sambashare:!*::"${MYUSERNM}"
"${MYUSERNM}":!*::" > ./azdir/airootfs/etc/gshadow
}

# Set the keyboard layout
setkeylayout () {
echo "KEYMAP="${KEYMP}"" > ./azdir/airootfs/etc/vconsole.conf
}

# Create 00-keyboard.conf file
crtkeyboard () {
mkdir -p ./azdir/airootfs/etc/X11/xorg.conf.d
echo "Section \"InputClass\"
        Identifier \"system-keyboard\"
        MatchIsKeyboard \"on\"
        Option \"XkbLayout\" \""${KEYMP}"\"
        Option \"XkbModel\" \""${KEYMOD}"\"
EndSection" > ./azdir/airootfs/etc/X11/xorg.conf.d/00-keyboard.conf
}

# Set and fix locale.conf, locale.gen, and keyboard
crtlocalec () {
sed -i "s/pc105/"${KEYMOD}"/g" ./azdir/airootfs/etc/default/keyboard
sed -i "s/us/"${KEYMP}"/g" ./azdir/airootfs/etc/default/keyboard
sed -i "s/en_US/"${LCLST}"/g" ./azdir/airootfs/etc/default/locale
sed -i "s/en_US/"${LCLST}"/g" ./azdir/airootfs/etc/locale.conf
echo ""${LCLST}".UTF-8 UTF-8" > ./azdir/airootfs/etc/locale.gen
echo "C.UTF-8 UTF-8" >> ./azdir/airootfs/etc/locale.gen
}

# Start mkarchiso
runmkarchiso () {
mkarchiso -v -w ./work -o ./out ./azdir
}

# ----------------------------------------
# Run Functions
# ----------------------------------------

handlerror
prepreqs
cleanup
cpazdir
addnmlinks
rmunitsd
cpmyfiles
sethostname
crtpasswd
crtgroup
crtshadow
crtgshadow
setkeylayout
crtkeyboard
crtlocalec
runmkarchiso


# Disclaimer:
#
# THIS SOFTWARE IS PROVIDED BY EZNIX “AS IS” AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL EZNIX BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# END
#
# Disclaimer:
#
# THIS SOFTWARE IS PROVIDED BY RED FIRE SOFTWARE ENTERTAINMENT “AS IS” AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL RED FIRE SOFTWARE ENTERTAINMENT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# END
#
