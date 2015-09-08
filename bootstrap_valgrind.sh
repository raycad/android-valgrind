#!/usr/bin/env bash

# Define the package name
PACKAGE="com.harman.lync"

adb push start_valgrind.sh /data/local/
adb shell chmod 777 /data/local/start_valgrind.sh 

adb root
adb shell setprop wrap.$PACKAGE "logwrapper /data/local/start_valgrind.sh"

echo "wrap.$PACKAGE: $(adb shell getprop wrap.$PACKAGE)"

adb shell am force-stop $PACKAGE
adb shell am start -a android.intent.action.MAIN -n $PACKAGE/.MainActivity

adb logcat -c
adb logcat

exit 0 