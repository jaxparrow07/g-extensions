geco "Preparing to Uninstall Swapper"
geco " "

FILE3=/data/.Swapper/memory.swap
if [ -f "$FILE3" ];then
swapoff $FILE3
rm /data/.Swapper/ -r

else
geco "${YELLOW}- No Running Swaps found${RC}"
geco "${YELLOW}- No Swap files found${RC}"
geco "${YELLOW}- Swapper directory not found${RC}"
fi

geco " "
geco "${GREEN}Swap files and Directory Removed Successfully${RC}"
