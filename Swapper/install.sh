swapfile="/data/.Swapper/memory.swap"
swapperdir="/data/.Swapper/"
if [[ -f $swapfile ]];then
swapoff $swapfile
rm $swapperdir -r
fi

if [[ -f "${GHOME}/extensions/swapconfig1" ]];then
rm ${GHOME}/extensions/swapconfig1
fi
