#!/bin/bash

### Script to setup Carthage for a project target ###

# Any subsequent(*) commands which fail will cause the shell script to exit immediately
set -e

# Colors Constants
red_color='\033[0;31m'
green_color='\033[0;32m'
yellow_color='\033[0;33m'
blue_color='\033[0;34m'
no_color='\033[0m'

# Font Constants
bold_text=$(tput bold)
normal_text=$(tput sgr0)

# Assume scripts are placed in /Scripts/Carthage dir
base_dir=$(dirname "$0")
cd "$base_dir"
cd ..
cd ..

# Project Update
touch Cartfile
ruby "Scripts/Carthage/carthageSetup.rb"

# .gitignore Update
printf >&2 "${blue_color}Updating .gitignore...${no_color}\n"
if ! grep -q -F "Carthage/" ".gitignore"; then
    printf "\n/Carthage/\n" >> ".gitignore"
elif ! grep -q -F "/Carthage/" ".gitignore"; then
    sed -i '' 's/Carthage\//\/Carthage\//g' ".gitignore"
fi

# Success
printf >&2 "\n${bold_text}PROJECT SETUP SUCCESS${normal_text}\n\n"
