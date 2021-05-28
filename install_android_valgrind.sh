#!/bin/bash
set -e

# Push local Valgrind installtion to the phone (if it exists, just overwrite it)
adb root
adb remount
adb shell "[ ! -d /data/local/Inst ] && mkdir /data/local/Inst"
adb push Inst /data/local/

# Ensure Valgrind on the phone is running
adb shell "/data/local/Inst/bin/valgrind --version"

# Add Valgrind executable to PATH (this might fail and indeed it fails..)
adb shell "export PATH=$PATH:/data/local/Inst/bin/"

echo "Valgind successfully installed"

