#!/system/bin/sh

PACKAGE="%PACKAGE%"
LOG="%LOG%"
TOOL="%TOOL%"

echo "----- Running $PACKAGE with Valgrind"

# Create a directory to save the file outputs
mkdir -p $LOG

echo "----- Saving log to $LOG"

# http://valgrind.org/docs/manual
VGPARAMS="-v --error-limit=no --trace-children=yes --log-file=$LOG --tool=$TOOL --leak-check=full --show-reachable=yes"

export TMPDIR="/data/data/$PACKAGE"
exec /data/local/Inst/bin/valgrind $VGPARAMS $* 

