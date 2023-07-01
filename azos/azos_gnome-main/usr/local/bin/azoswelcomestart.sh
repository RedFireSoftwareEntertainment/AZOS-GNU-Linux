#!/bin/bash

if [ -e /usr/bin/azoswelcome.py ]
then
    pip install pywebview
    python /usr/bin/azoswelcome.py
    rm /usr/bin/azoswelcome.py
    pip uninstall pywebview
else
    echo "azoswelcome.py was already executed once in this system so we skip it."
fi

echo "we are also going to move all the extentions for the AZOS desktop from the 'tobeaddedext' folder to the 'extentions' folder"
mv 
