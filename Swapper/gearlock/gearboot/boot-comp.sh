swapconfig1="/data/.Swapper/Swappiness.jax"
swapconfig2="/data/.Swapper/ActivateBoot.jax"
swapfile="/data/.Swapper/memory.swap"

# ------------------------- Swappiness Checking -------------------
if [ -f $swapconfig1 ];
then
SWAPPINESS=`cat ${swapconfig1}`
else
echo "60" > $swapconfig1
SWAPPINESS=`cat ${swapconfig1}`
fi

# ------------------------- Swap on Boot Checking -------------------
if [ -f $swapconfig2 ];
then
SWAPONBOOT=`cat ${swapconfig2}`
else
echo "Enabled" > $swapconfig2
SWAPONBOOT=`cat ${swapconfig2}`
fi


nout sysctl vm.swappiness=${SWAPPINESS}

if [[ $SWAPONBOOT == "Enabled" ]];then

if [[ -f $swapfile ]];then
swapon $swapfile
fi

else
exit
fi
