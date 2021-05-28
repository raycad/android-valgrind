Instructions for automatically detect memory management, threading bugs and profile Android applications on the ROOTED device in detail.

1. Connect to the Android device

	$ adb connect [device_ip]

2. Go to the Android Valgrind's folder

	$ cd [android-valgrind]	

3. Install Android Valgrind to the device

	$ ./install_android_valgrind.sh

4. Copy and start the specific package with Valgrind on the device

	$ ./start_valgrind.sh [app package name]

	NOTES: 

	- Change the activity to run at launch with `-a [ActivityName]`

	- Change the log output path on the Android device with `-l [path]`. They are saved to /sdcard/profiles by default.

    - Change the Valgrind tool with `-t [toolname]`, where toolname is one of:

		`memcheck`: a memory error detector

		`massif`: a heap profiler

		`callgrind`: a cache and branch-prediction profiler

		`helgrind`: a thread error detector

		`dhat`: a dynamic heap analysis tool

5. See outputs

	- Install massif-visualizer to view massif logs on Ubuntu

		$ sudo add-apt-repository ppa:kubuntu-ppa/backports 

		$ sudo apt-get update

		$ sudo apt-get install massif-visualizer

		$ massif-visualizer

	- Install KCachegrind to view Cachegrind logs on Ubuntu

		$ sudo apt-get install kcachegrind

		$ kcachegrind

	If you have problems in viewing logs using those valgrind viewers you can open the log files using any text editor to trace the information.

6. Make sure Valgrind is running on the device

	$ adb shell "top | grep valgrind"

    Valgrind will be terminated when `./start_valgrind.sh` is stopped, but it can otherwise be removed from the app by removing the wrap property and killing the Valgrind process:

	$ adb shell "setprop wrap.[PACKAGE] ''"

	E.g:
	
	$ adb shell "setprop wrap.com.harman.lync ''"

	$ adb shell "kill -9 [valgrind_pid]"
