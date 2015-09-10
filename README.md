Instructions for automatically detect memory management, threading bugs and profile Android applications on the ROOTED device in detail.

1. Connect to the Android device

	$ adb connect [device_ip]

2. Go to the Android Valgrind's folder

	$ cd [android-valgrind]	

3. Install Android Valgrind to the device

	$ ./install_android_valgrind.sh

4. Copy and start the specific package with Valgrind in the device

	$ ./bootstrap_valgrind.sh

	NOTES: 

	- You need to change the "PACKAGE" to your package name in both 2 script files: bootstrap_valgrind.sh and start_valgrind.sh

	- Change the output file path name from the script start_valgrind.sh

	- Change to use Callgrind or Memcheck tools from the script start_valgrind.sh

	- Change a tool from the script start_valgrind.sh

		# Memcheck tool: a memory error detector

		# Massif tool: a heap profiler

		# Callgrind tool: a cache and branch-prediction profiler

		# Helgrind tool: a thread error detector

		# DHAT: a dynamic heap analysis tool

	The log files of the example will be created at /sdcard/enzo_lync_profiles on the Android device.

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

	All applications will run very slowly when valgrind service is running so you need to restart device to refresh the device. Or you can stop the Valgrind and reset property by using the following command:

	$ adb shell "setprop wrap.[PACKAGE] ''"

	E.g:
	
	$ adb shell "setprop wrap.com.harman.lync ''"

	$ adb shell "kill -9 [valgrind_pid]"
