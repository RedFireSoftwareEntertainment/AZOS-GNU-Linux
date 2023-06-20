#!/usr/bin/env bash

###########
###Legal###
###########

#This is a free and opensource script. It doesn't and will never cost money. Our trademark and redistribution policy applies
#here too since this is part of The AZOS Operating System project. You can read it in the legal page of the official AZOS 
#project website.

#© Red Fire Software Entertainment(2019 - 2023). All rights reserved.


invalid(){
 echo "Invalid Choice"
 exit
}

updatesystem(){
  echo "AZOS will check for updates..."
  sudo pacman -Syu
  sudo flatpak update
  clear
  echo "Done updating the system..."
  sleep 3
  clear
  exit
}

istlorupdatewine(){
  sudo pacman -S wine
  sudo pacman -S winetricks
  sudo pacman -S wine-nine
  sudo pacman -S wine-mono
  sudo pacman -S lib32-vkd3d
  sudo pacman -S vkd3d
  clear
  echo "Wine installed/updated"
  sleep 3
  clear
  exit
}
unistwine(){
  sudo pacman -R winetricks
  sudo pacman -R wine-nine
  sudo pacman -R wine-mono
  sudo pacman -R lib32-vkd3d
  sudo pacman -R vkd3d
  sudo pacman -R wine
  clear
  echo "Wine uninstalled"
  sleep 3
  clear
  exit
}

managewinappsupport(){
  clear
  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
  echo "           THE AZOS CENTER             "
  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
  echo "---------------------------------------"
  echo "Windows App Support Manager"
  echo "---------------------------------------"
  echo ""
  echo ""
  echo "1. Install/Update Wine"
  echo "2. Uninstall Wine and Windows App Support"
  echo "3. Back to Main Menu"
  echo ""
  read -p "azoscenter>winappsupportmanager>" waschoice
  case $waschoice in
    1 ) istlorupdatewine ;;
    2 ) unistwine ;;
    3 ) main ;;
    
    * ) invalid ;;
  esac
  clear
}



#demanage(){
#  clear
#  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
#  echo "           THE AZOS CENTER             "
#  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
#  echo "---------------------------------------"
#  echo "Desktop Environment Manager"
#  echo "---------------------------------------"
#  echo ""
#  echo ""
#  echo "1. Install Default AZOS Desktop (GNOME/ GNU Network Object Model Environment)"
#  echo "2. Install KDE Plasma (K Desktop Environment)" 
#  echo "3. Install XFCE (XForms Common Environment)"
#  echo "4. Install dwm (Dynamic Window Manager)"
#  echo "4. Back"
#  echo ""
#  read -p "azoscenter>demanage>" demchoice
#  case $demchoice in
#    1 ) istlorupdatewine ;;
#    2 ) unistwine ;;
#    3 ) main ;;
#    4 ) main ;;
#    
#    * ) invalid ;;
#  esac
#  clear
#}

main(){ while true
do
  clear
  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
  echo "           THE AZOS CENTER             "
  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
  echo "---------------------------------------"
  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
  echo "  1. Check and/or perform system update"
  echo "  2. Manage Windows App Support        "
  echo "  3. Change Desktop Environment (Coming Soon)"
  echo "  4. Exit                              "
  echo "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
  echo ""
  echo ""
  echo -e "\n"
  read -p "azoscenter>" choice
  case $choice in
    1 ) updatesystem ;;
    2 ) managewinappsupport  ;;
    3 ) main ;;
    4 ) exit ;;
    
    * ) invalid ;;
  esac
done
}

main















