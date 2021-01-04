## For proper developer documentation, visit https://supreme-gamers.com/gearlock
# Check `!zygote.sh` to configure your package functions or gearlock can also guide you during the build process

#####--- Import Functions ---#####
get_base_dir # Returns execution directory path in $BD variable
# get_net_stat
# check_compat 7.0
#####--- Import Functions ---#####

filesdir="/data/.Touchpad2Tablet"
mkdir -p "$filesdir/files"
cp $BD/idc_files/* "$filesdir/files/" -R


