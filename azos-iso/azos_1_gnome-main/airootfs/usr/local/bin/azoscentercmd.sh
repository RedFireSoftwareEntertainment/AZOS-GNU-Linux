#!/usr/bin/env bash

invalid(){
 echo "Invalid Choice"
 exit
}

updatesystem(){
  echo "AZOS will check for updates..."
  sudo pacman -Syu
  clear
  echo "Done updating the system..."
  sleep 3
  clear
  exit
}

istlorupdatewine(){
  sudo pacman -S wine
  clear
  echo "Wine installed/updated"
  sleep 3
  clear
  exit
}
unistwine(){
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















