#!/gearlock/bin/bash

VERSION="3.2"

function RunCheck() {
swapconfig1="/data/.Swapper/Swappiness.jax"
swapconfig2="/data/.Swapper/ActivateBoot.jax"
swapconfig3="/data/.Swapper/SSDprompt.jax"
swapfile="/data/.Swapper/memory.swap"
SYSTEMSWAPPINESS=`cat /proc/sys/vm/swappiness`


# ------------------------- Swapper Directory Checking -------------------

if [[ -d /data/.Swapper/ ]];then
echo ""
else
mkdir /data/.Swapper/
fi

# ------------------------- Swappiness Checking -------------------
if [ -f $swapconfig1 ];
then
SWAPPINESS=`cat ${swapconfig1}`
else
echo "60" > $swapconfig1
SWAPPINESS=`cat ${swapconfig1}`
fi

# ------------------------- SSD Prompt -------------------
if [ -f $swapconfig3 ];
then
SSDPrompt=`cat ${swapconfig3}`
else
echo "True" > $swapconfig3
SSDPrompt=`cat ${swapconfig3}`
fi


# ------------------------- Swap on Boot Checking -------------------
if [ -f $swapconfig2 ];
then
SWAPONBOOT=`cat ${swapconfig2}`
else
echo "Enabled" > $swapconfig2
SWAPONBOOT=`cat ${swapconfig2}`
fi

# ------------------------- SSD Checking ---------------------
SDCHECKSTART=`cat /sys/block/sda/queue/rotational`

if [[ $SDCHECKSTART == "1" ]];then
SDTYPE="HDD"
else
SDTYPE="SSD"
fi

}



RunCheck

function ActivateSwap() {
    echo "
    "
    if [[ -f $swapfile ]];then
    nout swapon $swapfile
    geco " ${GREEN}++Activated Swap file${RC}"
    else
    geco " ${RED}++No Swap file found. Create one first${RC}"
    echo " "
    fi
    sleep 2
    MainMenu
}

function CreateSwap() {

    echo "
    "
    if [[ $SSDPrompt == "True" ]];then

    if [[ $SDTYPE == "SSD" ]];then
    geco ""
    geco "${RED}WARNING${RC} : We have detected that you have SSD. Continue if you have not installed Androidx86 on SSD"
    geco "
Use [h] Help in menu see about it. If you are sure that you're not installed this on SSD.
Or You really want to Continue using Swapper on SSD. ${YELLOW}Note : You can disable this prompt in Options.${RC} \n"
read -p " Are you sure to continue [y/N] : " ssdwarning
case $ssdwarning in

"y")
echo ""
;;

"Y")
echo ""
;;

"n")
geco "
No changes were made to your device. If you are sure about you are using HDD,You can choose to Continue"
sleep 2
MainMenu
;;

"N")
geco "
No changes were made to your device. If you are sure about you are using HDD,You can choose to Continue"
sleep 2
MainMenu
;;

*)
geco ""
geco "${RED}++Invaild Option Noob.${RC}"
sleep 2
CreateSwap
;;

esac

fi

fi

if [[ $SDTYPE == "SSD" ]];then

if [[ $SSDPrompt == "False" ]];then
geco "
++Your first disk is identified as ${YELLOW}SSD${RC}"
fi

fi

    if [[ -f $swapfile ]];then
    geco "${GREEN}Old Swap File found ${RC} ( Will be deleted )"
    else
    nout echo ""
    fi
    geco "You can only create swap files from 1MB - 4096MB (${YELLOW}x${RC} to Cancel)
"
    read -p "Enter Swap Size (MB) : " swapsize
    if [[ $swapsize == "x" ]];then
    geco "
${RED}++Aborted${RC}"
    sleep 1
    MainMenu
    fi

numchecker='^[0-9]+$'
if ! [[ $swapsize =~ $numchecker ]] ; then
   geco "
++Not a number" >&2; 
   sleep 2
   CreateSwap
fi

    if [[ -z $swapsize ]];then
    geco "${RED}++Empty Swap Size${RC}"
    sleep 2
    CreateSwap
    fi

    if [[ $swapsize == 0 ]];then
    geco "${RED}You cannot create Swap file of 0 MB, Noob${RC}"
    sleep 2
    CreateSwap
    fi

    if [[ ${swapsize} -lt 4097 ]];then
    if [[ -f $swapfile ]];then
    swapoff $swapfile
    rm $swapfile
    fi

    geco "++Creating Swap file of ${swapsize} MB
    "
fallocate -l ${swapsize}M $swapfile
    geco "
++ Created Swap file"
    chmod 600 ${swapfile}
    mkswap ${swapfile}
    swapon ${swapfile}
    geco "
++ Done Setting Up Swap File"
    sleep 3
    MainMenu
    else
    echo ""
    geco "${RED}++ Invalid Swap Size - Larger than 4096MB ${RC}"
    sleep 1
    CreateSwap
    fi


}

function RemoveSwap() {

    geco "
    "
    if [[ -f $swapfile ]];then
    geco "Do you want to Remove the Current Swap file"
    geco "[1] Yes"
    geco "[2] No
    "
    read -p "Option > " removeconfirm
    case $removeconfirm in

    1)
    geco "Removing Swap file"
    swapoff $swapfile
    rm $swapfile
    sleep 2
    MainMenu
    ;;

    2)
    geco "Your Swap file is not removed"
    geco " "
    sleep 2
    MainMenu
    ;;

    *)
    RemoveSwap
    ;;

    esac

    else
    geco "You don't have Swap file"
    geco "You Noob. You need to create one to remove one"
    sleep 2
    geco ""
    MainMenu
    fi

}

function About() {
    clear
    geco "

             ${YELLOW}
              _______.____    __    ____  ___      .______   .______    _______ .______      
             /       |\   \  /  \  /   / /   \     |   _  \  |   _  \  |   ____||   _  \     
            |   (----  \   \/    \/   / /  ^  \    |  |_)  | |  |_)  | |  |__   |  |_)  |    
             \   \      \            / /  /_\  \   |   ___/  |   ___/  |   __|  |      /     
         .----)   |      \    /\    / /  _____  \  |  |      |  |      |  |____ |  |\  \----.
         |_______/        \__/  \__/ /__/     \__\ | _|      | _|      |_______|| _| \_____|${RC}
                                                 $VERSION
                                                                                    
          Hi Guys, I am Jaxparrow and this is Swapper 2.0 Remastered. I created this whole script
          from Scratch to make it more awesome than before. I know you'll like this design. Give
          your support to this by Rating on how much you like this. If you have any bugs/errors,
          Let me know in the Discussion. I will fix it as soon as possible. This whole script is
          coded by Me. Thanks to AXON for Gearlock & Gearlock Utils. This extension took me more 
          than 5 hours to make and bug fix by on my own. 

    "
read -n 1 something
MainMenu

}

function Exit() {
    geco "

++ Thanks for using Swapper."
    sleep 1
    exit
}

function ClearRAM() {
clear
geco "

             ${YELLOW}
              _______.____    __    ____  ___      .______   .______    _______ .______      
             /       |\   \  /  \  /   / /   \     |   _  \  |   _  \  |   ____||   _  \     
            |   (----  \   \/    \/   / /  ^  \    |  |_)  | |  |_)  | |  |__   |  |_)  |    
             \   \      \            / /  /_\  \   |   ___/  |   ___/  |   __|  |      /     
         .----)   |      \    /\    / /  _____  \  |  |      |  |      |  |____ |  |\  \----.
         |_______/        \__/  \__/ /__/     \__\ | _|      | _|      |_______|| _| \_____|${RC}
                                                 $VERSION
 
 
                              [1] Clear Page Cache Only      | ${GREEN}SAFE${RC}
                              [2] Clear Dentries and Inodes  | ${YELLOW}NORMAL${RC}
                              [3] Clear All [ 1+2 Combined ] | ${RED}NOT SAFE${RC}
                              
                              [b] Go Back"

read -p "Option > " clearentry

case $clearentry in

1)
geco ""
sync; echo 1 > /proc/sys/vm/drop_caches
geco "
++Cleared"
sleep 2
ClearRAM
;;

2)
geco ""
sync; echo 2 > /proc/sys/vm/drop_caches
geco "
++Cleared"
sleep 2
ClearRAM
;;

3)
geco ""
sync; echo 3 > /proc/sys/vm/drop_caches
geco "
++Cleared"
sleep 2
ClearRAM
;;

b)
SOptions
;;

*)
geco "
${RED}++Invalid Option${RC}"
sleep 2
ClearRAM
;;

esac

}

function SOptions() {
    RunCheck
    clear
    geco "

             ${YELLOW}
              _______.____    __    ____  ___      .______   .______    _______ .______      
             /       |\   \  /  \  /   / /   \     |   _  \  |   _  \  |   ____||   _  \     
            |   (----  \   \/    \/   / /  ^  \    |  |_)  | |  |_)  | |  |__   |  |_)  |    
             \   \      \            / /  /_\  \   |   ___/  |   ___/  |   __|  |      /     
         .----)   |      \    /\    / /  _____  \  |  |      |  |      |  |____ |  |\  \----.
         |_______/        \__/  \__/ /__/     \__\ | _|      | _|      |_______|| _| \_____|${RC}
                                                 $VERSION
 "
if [[ $SWAPONBOOT == "Enabled" ]];then
geco "                             [1] Toggle Swap on Boot | ${GREEN}ENABLED${RC} "
else
geco "                             [1] Toggle Swap on Boot | ${RED}DISABLED${RC} "
fi
if [[ $SYSTEMSWAPPINESS == $SWAPPINESS ]];then
geco "                             [2] Change Swappiness   | Current : $SWAPPINESS"
else
geco "                             [2] Change Swappiness   | System : $SYSTEMSWAPPINESS - Next Boot : ${SWAPPINESS}"
fi
if [[ $SSDPrompt == "True" ]];
then
geco "                             [3] SSD Prompt          | ${GREEN}ENABLED${RC} ( Recommended )"
else
geco "                             [3] SSD Prompt          | ${RED}DISABLED${RC} ( Not Recommended )"
fi
geco "                             [4] Clear RAM Cache"
geco "                             [5] Clear Swap Space ( Executed on all Boot )"
geco ""
geco "                             [b] Go Back"

read -n 1 -p "Option > " Optionsentry

case $Optionsentry in

1)
geco " "
if [[ $SWAPONBOOT == "Enabled" ]];then
echo "Disabled" > $swapconfig2
geco "++ Disabling Swap On Boot.

You need to manually Activate if you want.
"
sleep 2
SOptions

else
echo "Enabled" > $swapconfig2
geco "++ Enabling Swap On Boot.

Your Swap files will be activated upton booting
"
sleep 2
SOptions
fi
;;
2)
geco ""
geco "
Enter Swap Value from 0-100

0   = Unused
100 = Used Often
"
read -p "Value (0-100)> " swapvalue

numchecker='^[0-9]+$'
if ! [[ $swapvalue =~ $numchecker ]] ; then
   geco "
++Not a number" >&2;
   sleep 2
   SOptions
   fi

if [[ $swapvalue -lt 101 ]];then
geco "
Your Swappiness is set to ${GREEN} ${swapvalue} ${RC}"
echo "${swapvalue}" > $swapconfig1
nout sysctl vm.swappiness=${swapvalue}
sleep 2
SOptions
else
geco "
You need to Enter a value Less than 100"
sleep 2
SOptions
fi
;;

3)
if [[ $SSDPrompt == "True" ]];then
geco "
Disabling SSD Prompt. You will no longer see SSD Warning. Use this if that annoying you even if you are using
an HDD. Because it detects every Disk on the PC/Laptop."
echo "False" > $swapconfig3
else
geco "
Enabling SSD Prompt. You will see SSD Warning if this detects any SSD on your system. Disable this if you are using it
on a HDD. Because it detects every Disk on the PC/Laptop."
echo "True" > $swapconfig3
fi

geco "
++Press any [Key] to goto Options"
read -n 1 thisisnot
SOptions
;;

4)
ClearRAM
;;

5)
geco ""
if [[ -f $swapfile ]];then
swapoff $swapfile
swapon $swapfile
else
geco "++ Swapfile not found."
fi
sleep 2
SOptions
;;


b)
MainMenu
;;

*)
geco "
${RED}++Invalid Option${RC}"
sleep 2
SOptions
;;

esac

}

function Help() {
    clear
    geco "

             ${YELLOW}
              _______.____    __    ____  ___      .______   .______    _______ .______      
             /       |\   \  /  \  /   / /   \     |   _  \  |   _  \  |   ____||   _  \     
            |   (----  \   \/    \/   / /  ^  \    |  |_)  | |  |_)  | |  |__   |  |_)  |    
             \   \      \            / /  /_\  \   |   ___/  |   ___/  |   __|  |      /     
         .----)   |      \    /\    / /  _____  \  |  |      |  |      |  |____ |  |\  \----.
         |_______/        \__/  \__/ /__/     \__\ | _|      | _|      |_______|| _| \_____|${RC}
                                                 $VERSION
                                                                                    
          You can Create, Remove and Change Swappiness with this extension. You can create a
          swap file from 1MB to 4096MB. Limited in 2.0 . Also Comes with low chance of errors.
          Most of this script contains to avoid errors when creating or handling swap files.

          If you don't know what is Swap. ${YELLOW}Swap${RC} file is mostly like RAM. When the
          RAM has not enough memory to process. It will move the ${GREEN}Inactive${RC} process
          to the Swap. So, Some of the RAM will be freed up and the swap file will be used.

          Note :
          1) Don't Use this if you are using an ${GREEN}SSD${RC}
             If you use, It will decrease the lifespan of your SSD due to heavy read/write.

          2) ${YELLOW}Swap${RC} files are not faster like RAM. Even if you use it on fastest SSD. 
          It will be 100x slower than a DDR3 RAM. So don't expect too much from this.

          ++ Press any Key to Goto Main Menu 

    "
read -n 1 somethinginthis
MainMenu

}

function Stats() {
    clear
    geco "
             ${YELLOW}
              _______.____    __    ____  ___      .______   .______    _______ .______      
             /       |\   \  /  \  /   / /   \     |   _  \  |   _  \  |   ____||   _  \     
            |   (----  \   \/    \/   / /  ^  \    |  |_)  | |  |_)  | |  |__   |  |_)  |    
             \   \      \            / /  /_\  \   |   ___/  |   ___/  |   __|  |      /     
         .----)   |      \    /\    / /  _____  \  |  |      |  |      |  |____ |  |\  \----.
         |_______/        \__/  \__/ /__/     \__\ | _|      | _|      |_______|| _| \_____|${RC}"
geco "
"
         geco "                 DiskType     : ${YELLOW}$SDTYPE${RC}"
         geco "                 Swap on Boot : $SWAPONBOOT"
         geco "                 Swappiness   : $SYSTEMSWAPPINESS"
         if [[ -f $swapfile ]];then
         geco "                 Swap File    : Available"
         else
         geco "                 Swap File    : Not Available"
         fi
         if [[ $SDTYPE == SSD ]];then
         geco "                 SSD Warning  : Risk"
         fi
         if [[ $SSDPrompt == True ]];then
         geco "                 SSD Propmt   : Enabled"
         else
         geco "                 SSD Propmt   : Disabled"
         fi
         geco "
         "

geco "++ Press any [${GREEN}Key${RC}] to goto Main Menu"
read -n 1 thiswasteLastMemClear
MainMenu

}

function CheckSwapu() {
    geco "
"
    free -m
    geco " "
    geco "++Press any [Key] to goto Main Menu"
    read -n 1 somethinginthis
MainMenu

}


function MainMenu() {
    clear
    geco "

             ${YELLOW}
              _______.____    __    ____  ___      .______   .______    _______ .______      
             /       |\   \  /  \  /   / /   \     |   _  \  |   _  \  |   ____||   _  \     
            |   (----  \   \/    \/   / /  ^  \    |  |_)  | |  |_)  | |  |__   |  |_)  |    
             \   \      \            / /  /_\  \   |   ___/  |   ___/  |   __|  |      /     
         .----)   |      \    /\    / /  _____  \  |  |      |  |      |  |____ |  |\  \----.
         |_______/        \__/  \__/ /__/     \__\ | _|      | _|      |_______|| _| \_____|${RC}
                                                 $VERSION
                                                                                    

                                    ${RED}Swapper by Jaxparrow${RC}
    
                                         [1] Create Swap RAM
                                         [2] Remove Swap RAM
                                         [3] Options
                                         [4] About
    
                    [a]Activate Swap  [s]Stats  [u]Usage     [h]Help     [x]Exit

    "
read -n 1 -p " Choice > " menuoption
case $menuoption in

1)
CreateSwap
;;

2)
RemoveSwap
;;

3)
SOptions
;;

4)
About
;;

"a")
ActivateSwap
;;

"h")
Help
;;

"x")
Exit
;;

"u")
CheckSwapu
;;

"s")
Stats
;;

*)
geco "
${RED}++ Invalid Option${RC}"
sleep 2
MainMenu
;;

esac

}

MainMenu
