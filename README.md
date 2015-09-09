Instructions for automatically detect memory management, threading bugs and profile your Android applications in detail.

1. Connect to the Android device

	$ adb connect [device_ip]

2. Go to the Android profiler stuff's folder

	$ cd [android-valgrind]	

3. Install Android valgrind to the device

	$ ./install_android_valgrind.sh

4. Copy and start the specific package with valgrind in the device

	$ ./bootstrap_valgrind.sh

	NOTE: 
	- You need to change the "PACKAGE" to your package name in both 2 script files: bootstrap_valgrind.sh and start_valgrind.sh
	- Change the output file path name from the script start_valgrind.sh

	The log files of the example will be created at /sdcard/enzo_lync_profiles on the Android device.

5. See outputs

Install KCachegrind on Ubuntu to view the file outputs

	$ sudo apt-get install kcachegrind
	
	$ kcachegrind

Then select the outputs to view the information.

6. Make sure Valgrind is running on the device

	$ adb shell "top | grep valgrind"
