#!/bin/bash
set -e

unset PACKAGE
unset ACTIVITY
unset LOG
TOOL="memcheck"

show_help() {
    echo "Usage: ./start_valgrind.sh [options] package_name"
    echo "  package_name: the package name of the app (e.g. com.example)"
    echo "  options:"
    echo "    -a    The activity to run (e.g. MainActivity)."
    echo "    -h    Display this help message."
    echo "    -l    Where to store the Valgrind log"
    echo "          (default = /sdcard/profiles/package_name.tool.%p)"
    echo "    -t    Valgrind tool to use (default = memcheck)."
}

while getopts "ha:l:t:" opt; do
	case ${opt} in
	a )
		ACTIVITY="$OPTARG"
		;;
	h )
        show_help
		exit 0
		;;
	l )
		LOG="$OPTARG"
		;;
	t )
		TOOL="$OPTARG"
		;;
	\? )
		echo "Invalid Option: -$OPTARG" 1>&2
		exit 1
		;;
	esac
done
shift $((OPTIND -1))

PACKAGE=$1

if [ "x$PACKAGE" = "x" ]; then
    show_help
    exit 1
fi

if [ -z $LOG ]; then
    LOG="/sdcard/profiles/$PACKAGE.$TOOL.%p"
fi

wrapper_temp=".valgrind_wrapper.$PACKAGE.sh"
sed -e "s:%PACKAGE%:$PACKAGE:" -e "s:%LOG%:$LOG:" -e "s:%TOOL%:$TOOL:" valgrind_wrapper.template.sh > "$wrapper_temp"

adb root

wrapper_file="/data/local/tmp/valgrind_wrapper.sh"
adb shell "mkdir -p $wrapper_file"
adb push "$wrapper_temp" "$wrapper_file"
rm $wrapper_temp

adb shell "chmod 0777 $wrapper_file"
adb shell "setprop wrap.$PACKAGE 'logwrapper $wrapper_file'"

echo "wrap.$PACKAGE: $(adb shell getprop wrap.$PACKAGE)"

adb shell am force-stop $PACKAGE

if [ -z $ACTIVITY ]; then
    adb shell "monkey -p $PACKAGE -c android.intent.category.LAUNCHER 1" >/dev/null
else
    adb shell "am start -a android.intent.action.MAIN -n $PACKAGE/.$ACTIVITY" >/dev/null
fi

adb shell "setprop wrap.$PACKAGE ''"
adb shell "rm -f $wrapper_file"

echo ""
echo "Valgrind is now profiling $PACKAGE"
echo "You may disconnect your device"
echo ""
echo "Use Ctrl + C to stop"

trap handle_interrupt INT

adb logcat -c
sleep 3

adb logcat &
logcat_pid=$!

handle_interrupt() {
    kill $logcat_pid 2>/dev/null || true

    echo ""
    if adb get-state 1>/dev/null 2>&1; then
        adb shell "am force-stop $PACKAGE"
        echo ""
        echo "Valgrind has stopped"
        echo "The log has been saved to $LOG"
        exit 0
    else
        echo "No device connected, reconnect to terminate the app"
    fi
}

read -r -d '' _

