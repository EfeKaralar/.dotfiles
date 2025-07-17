#!/bin/bash

#
# This script loads back the default Awesome WM config in case something goes wrong.
#

# Safely copy the deafault Awesome config to the Current Awesome config
scp -vr ~/.config/awesome-backup ~/.config/awesome
