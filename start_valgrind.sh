#!/system/bin/sh

# http://valgrind.org/docs/manual

# Define the package name
PACKAGE="com.harman.lync"

# Create a directory to save the file outputs
mkdir -p /sdcard/enzo_lync_profiles

# Memcheck tool: a memory error detector
VGPARAMS='-v --error-limit=no --trace-children=yes --log-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.log.%p --tool=memcheck --leak-check=full --show-reachable=yes'

# Massif tool: a heap profiler
# VGPARAMS='-v --error-limit=no --trace-children=yes --log-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.log.%p --tool=massif --massif-out-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.massif.out.%p'

# Callgrind tool: a cache and branch-prediction profiler
# VGPARAMS='-v --error-limit=no --trace-children=yes --log-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.log.%p --tool=callgrind --callgrind-out-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.callgrind.out.%p'

# Helgrind tool: a thread error detector
# VGPARAMS='-v --error-limit=no --trace-children=yes --log-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.log.%p --tool=helgrind --helgrind-out-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.helgrind.out.%p'

# DHAT: a dynamic heap analysis tool
# VGPARAMS='-v --error-limit=no --trace-children=yes --log-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.log.%p --tool=exp-dhat --exp-dhat-out-file=/sdcard/enzo_lync_profiles/enzo_lync_profile.dhat.out.%p'

export TMPDIR=/data/data/$PACKAGE

exec /data/local/Inst/bin/valgrind $VGPARAMS $* 