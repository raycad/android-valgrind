#!/usr/bin/env bash

# Push local Valgrind installtion to the phone (if it exists, just overwrite it)
#if [[ $(adb shell ls -ld /data/local/Inst/bin/valgrind) = *"No such file or directory"* ]];
#then
  adb root
  adb remount
  adb shell "[ ! -d /data/local/Inst ] && mkdir /data/local/Inst"
  adb push Inst /
  adb shell "ls -l /data/local/Inst"

  # Ensure Valgrind on the phone is running
  adb shell "/data/local/Inst/bin/valgrind --version"

  # Add Valgrind executable to PATH (this might fail and indeed it fails..)
  adb shell "export PATH=$PATH:/data/local/Inst/bin/"
#fi