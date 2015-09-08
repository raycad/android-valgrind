#!/system/bin/sh

# Define the package name
PACKAGE="com.harman.lync"

# Create a directory to save the file outputs
mkdir -p /sdcard/enzo_lync_profiles

# Callgrind tool
VGPARAMS='-v --error-limit=no --trace-children=yes --log-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.log.%p --tool=callgrind --callgrind-out-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.out.%p'

# Memcheck tool
# VGPARAMS='-v --error-limit=no --trace-children=yes --log-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.log.%p --tool=memcheck --leak-check=full --show-reachable=yes'

export TMPDIR=/data/data/$PACKAGE

exec /data/local/Inst/bin/valgrind $VGPARAMS $* 