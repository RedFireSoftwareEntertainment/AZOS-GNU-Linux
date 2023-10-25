#!/bin/bash

# Licenced under the GNU GPL 3.0
# Part of AZOS GNU/Linux and all legal information from this legal page apply here: https://sites.google.com/view/azosofficialsite/legal

CURDIR=$(pwd)

# Make azrepo
makeazrepo () {
chmod +x etc/azrepo/x86_64/makerepo.sh
cd etc/azrepo/x86_64/
./makerepo.sh
cd "$CURDIR"
}

sudo ./steps.sh
