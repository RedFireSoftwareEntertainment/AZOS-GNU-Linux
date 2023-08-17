#!/bin/bash

if [ -e /usr/bin/azoswelcome.py ]
then
    pip install pywebview 
    python /usr/bin/azoswelcome.py 
    rm /usr/bin/azoswelcome.py 
    pip uninstall pywebview
    systemctl start clamav-daemon.service
    freshclam 
    clamscan --recursive --infected /home/$USER 
    exit 
else
    freshclam 
    clamscan --recursive --infected /home/$USER 
    exit  
fi





