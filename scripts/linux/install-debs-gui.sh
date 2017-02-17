#!/bin/bash

set -eux -o pipefail

# Base packages.
PACKAGES=""

# Terminator.
PACKAGES="${PACKAGES}
    xfce4-terminal"

# Nmap.
PACKAGES="${PACKAGES}
    nmap"

# Yakuake.
PACKAGES="${PACKAGES}
    yakuake"

# Install the packages.
sudo apt-get install -y ${PACKAGES}
