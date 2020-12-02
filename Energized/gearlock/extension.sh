clear
if [ ! -d /sdcard/EnergizedProtection ]; then
    mkdir -p /sdcard/EnergizedProtection;
fi

if [ -f /data/EGb.jax ]; then
geco ""

else
cp /etc/hosts /data/EGb.jax

fi


# Check if Other Adblocker is installed Ex. Adaway
if [ -d /data/data/org.adaway/ ]; then
    geco "${RED}[-] Other adblocker is detected!${RC}"
    sleep 1
    geco "${GREEN}[+] Make sure to disable them, to avoid any issue using Energized!${RC}"
    sleep 1
elif [ -d /data/data/ru.dixl0f0s.unifiedhostsmanager ]; then
    geco "${RED}[-] Other adblocker is detected!${RC}"
    sleep 1
    geco "${YELLOW}[+] Make sure to disable them, to avoid any issue using Energized!${RC}"
    sleep 1
fi
# Check if the Whitelist is there, else creates
if [ ! -f /sdcard/EnergizedProtection/blacklist ]; then
   geco "[+] Creating Blacklist.\n";
   touch /sdcard/EnergizedProtection/blacklist
fi
# Check if the Blacklist is there, else creates 
if [ ! -f /sdcard/EnergizedProtection/whitelist ]; then
   geco "[+] Creating Whitelist.";
   touch /sdcard/EnergizedProtection/whitelist
fi
# Aliases, Grep, Wget Variables
HOST=/etc/hosts
TREADME=/sdcard/EnergizedProtection/readme
FILTER=/sdcard/EnergizedProtection/filter
WHITELIST=/sdcard/EnergizedProtection/whitelist
BLACKLIST=/sdcard/EnergizedProtection/blacklist
TEMP=/cache/energizedtemp
PTEMP=/cache/energizedporntemp
STEMP=/cache/energizedsocialtemp
COUNT=1
# Check if Root was granted or not
id="$(id)"; id="${id#*=}"; id="${id%%\(*}"; id="${id%% *}"
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
    root="${RED}DENIED${RC}";
else
    root="${GREEN}GRANTED${RC}";
fi;
# Other Variables
update="${YELLOW}`busybox date -r /etc/hosts`${RC}"
busybox="${GREEN}`busybox | head -1 | cut -f 2 -d ' '`${RC}"
size="${GREEN}`ls -lah /etc/hosts | awk '{print $5}'`${RC}"
# Check if System's Adblocker is enabled or not
   [ -f /etc/hosts ];
if busybox grep -q adblocker /etc/hosts; then
	adblocker="${GREEN}ENABLED${RC}"
else
	adblocker="${ORANGE}DISABLED${RC}"
fi
# Check if Energized is applied or not
	[ -f /etc/hosts ];
if busybox grep -q adroitadorkhan.github.io /etc/hosts; then
	eonoff="${GREEN}ENABLED${RC}"
else
	eonoff="${ORANGE}DISABLED${RC}"
fi
# If Energized is enabled, which pack it is
	[ -f etc/hosts ];
if busybox grep -q "Energized Ad" /etc/hosts; then
	echeck="${GREEN}Ad Protection${RC}"	
elif busybox grep -q "Energized Malware" /etc/hosts; then
	echeck="${GREEN}Malware Protection${RC}"
elif busybox grep -q "Energized Porn" /etc/hosts; then
	echeck="${GREEN}Porn Protection${RC}"
elif busybox grep -q "Energized Blu" /etc/hosts; then
	echeck="${GREEN}Blu Protection${RC}"
elif busybox grep -q "Energized go" /etc/hosts; then
	echeck="${GREEN}Blu go Protection${RC}"
elif busybox grep -q "EnergizedLite" /etc/hosts; then
	echeck="${GREEN}Lite Protection${RC}"
elif busybox grep -q "EnergizedPornLite" /etc/hosts; then
	echeck="${GREEN}Porn Lite Protection${RC}"
elif busybox grep -q "Energized Ultimate" /etc/hosts; then
	echeck="${GREEN}Ultimate Protection${RC}"
elif busybox grep -q "Energized Unified" /etc/hosts; then
	echeck="${GREEN}Unified Protection${RC}"
else
	echeck="${RED}No Pack Detected!${RC}"
fi

while true
do
	INPUT=$(eval "geco \$$COUNT")
	if [ ! "$INPUT" ]; then
		if [ "$1" ]; then
			rm -f $TREADME
			exit 0
		fi
# Starts Screen gecos
geco "
[+] ENERGIZED: $eonoff - $echeck
[+] ADBLOCK STATUS: $adblocker"	
figlet Energized
geco " For Gearlock by ${BLUE}Jaxparrow${RC}"
geco "-------------------------------------------"	
        geco "${YELLOW}[+] Select an Pack below:${RC}"
		geco "---------------~-----------------"
		geco "[1] Energized Spark"
		geco "[2] Energized Blu Go"
		geco "[3] Energized Blu"
		geco "[4] Energized Basic"
		geco "[5] Energized Porn"
		geco "[6] EnergizedU ltimate"
		geco "[7] Energized Unified"

geco "
"		
		geco "${ORANGE}[+] Extensions:${RC}"
		geco "---------------~-----------------"
		geco "[p] Add Porn Blocking to current host. [Old]"
		geco "[s] Add Social Blocking to current host. [Old]"
geco "
"		
		geco "${GREEN}[+] Other Options:${RC}"
		geco "---------------~-----------------"
		geco "[i] Info"
		geco "[c] Clear Hosts File ( Disable )"
		geco "[b] Apply Blacklist"
		geco "[w] Apply Whitelist"
		geco "[o] Revert Changes ( Restore )."
 		geco "[q] Quit."
geco "
"
		geco -n "[+] Your Input > "
		read -r INPUT
		if [ "$INPUT" != "m" ]; then
			INPUT="$(geco "$INPUT" | sed 's/m//g')"
		fi
		DIR=""
	fi
	case "$INPUT" in
		1) DIR="master/EnergizedAd/energized/hosts"
		geco "${GREEN}[+] Applying Energized Ad${RC}"
		;;
		2) DIR="master/EnergizedMalware/energized/hosts"
		geco "${GREEN}[+] Applying Energized Malware${RC}"
		;;
		3) DIR="master/EnergizedPorn/energized/hosts"
		geco "${GREEN}[+] Applying Energized Porn${RC}"
		;;
		4) DIR="master/EnergizedBlu/energized/blu"
		geco "${GREEN}[+] Applying Energized Blu${RC}"
		;;
		5) DIR="master/EnergizedBlugo/energized/blu_go"
		geco "${GREEN}[+] Applying Energized Blu go${RC}"
		;;
		6) DIR="master/EnergizedLite/energized/hosts"
		geco "${GREEN}[+] Applying Energized Lite${RC}"
		;;
		7) DIR="master/EnergizedPornLite/energized/hosts"
		geco "${GREEN}[+] Applying Energized Porn Lite${RC}"
		;;
		8) DIR="master/EnergizedUltimate/energized/hosts"
		geco "${GREEN}[+] Applying Energized Ultimate${RC}"
		;;
		9) DIR="master/EnergizedUnified/energized/hosts"
		geco "${GREEN}[+] Applying Energized Unified${RC}"
		;;
		w)  if [ ! -f $WHITELIST ]; then
				geco ""
				geco "[-] No Whitelist detected"
				sleep 1
				geco "[+] Copy your whilelist to /sdcard/EnergizedProtection"
				sleep 2
		    else
				if [ -f "$HOST" ]; then
					geco "${GREEN}[+] Whitelist Found!${RC}"
					geco "[+] Applying Whitelist"
					sleep 1
					grep -Fvxf $WHITELIST $HOST > $TEMP
					mv $TEMP $HOST
					sleep 1
					grep -Fvf $WHITELIST $HOST > $TEMP
					mv $TEMP $HOST
					sleep 1
					grep -Fvf $WHITELIST $HOST > $TEMP
					mv $TEMP $HOST
					sleep 1
					geco "${ORANGE}[-] Returning to the main screen.${RC}\n"
					sleep 1
				else
					geco ""
					geco "[-] No hosts file detected"
					sleep 1
					geco "[+] Apply a hosts file first"
					sleep 1
				fi
		    fi
		;;
		d)  if [ ! -f $WHITELIST ]; then
				geco ""
				geco "[-] No Whitelist detected"
				sleep 1
				geco "[+] Copy your whilelist to /sdcard/EnergizedProtection"
				sleep 2
		    else
				if [ -f "$HOST" ]; then
					geco "${GREEN}[+] Whitelist Found!${RC}"
					geco "[+] Applying Whitelist"
					sleep 2
					grep -Fvf $WHITELIST $HOST > $TEMP
					mv $TEMP $HOST
					geco "${ORANGE}[-] Returning to the main screen.${RC}\n"
					sleep 3 
				else
					geco ""
					geco "[-] No hosts file detected"
					sleep 1
					geco "[+] Apply a hosts file first"
					sleep 2
				fi
		    fi
		;;
		r)  if [ ! -f $WHITELIST ]; then
				geco ""
				geco "${YELLOW}[-] No Whitelist detected.${RC}"
				geco "[+] Copy your whilelist to /sdcard/EnergizedProtection"
		    else
				if [ -f "$HOST" ]; then
					geco "${GREEN}[+] Whitelist Found!${RC}"
					geco "[+] Applying Whitelist (regex)"
					sleep 2
					grep -vxf $WHITELIST $HOST > $TEMP
					mv $TEMP $HOST
					geco "${ORANGE}[-] Returning to the main screen.${RC}\n"
					sleep 3 
				else
					geco "${RED}[-] No hosts file detected${RC}"
					sleep 1
					geco "[+] Apply a hosts file first"
					sleep 2
				fi
		    fi
		;;
		b)	if [ ! -f $BLACKLIST ]; then
				geco ""
				geco "${YELLOW}[-] No Blacklist detected.${RC}"
				geco "[+] Copy your blacklist to /sdcard/EnergizedProtection"
			else
				if [ -f "$HOST" ]; then
					if [ -s $BLACKLIST ]; then
						geco ""
						geco "[+] Applying Blacklist..."
						sleep 2
						NEWFILTERS="$(cat $BLACKLIST)"
						printf '%s\n' "$NEWFILTERS" | while IFS= read -r linenew
						do
						  if [ ! "$(grep -Fx "$linenew" $HOST)" ]; then
							sed -i -e "\$a0.0.0.0 $linenew" $HOST
							geco "${ORANGE}[-] Returning to the main screen.${RC}\n"
						sleep 3 
						  fi
						done
					else
						geco "${RED}[-] Blacklist file is empty!${RC}"
						sleep 2
						geco "\n[-] NO NEW FILTER ADDED!\n"
						geco "${ORANGE}[-] Returning to the main screen${RC}\n"
						sleep 3 
					fi
				else
					geco "${YELLOW}[-] No hosts file detected${RC}"
					sleep 1
					geco "[+] Apply a hosts file first"
					sleep 2
				fi
		    fi
			;;
		q) break

		;;
		i)
clear
figlet Energized
geco " Modified by Jaxparrow"
geco "-----------------------------"
geco "
This is a Magisk Module. I took my time to convert this to a Gearlock Extension. Now, This works without
Magisk. This is an Open-Source project on GitHub. I really liked this script. So, I made this for you guys.
I added some tweaks and extra options. Report if you have any bugs.

[1] Info About Packs
[2] Goto Main Menu"
read -n 1 something

case $something in

1)
am start -a android.intent.action.VIEW -d "https://github.com/EnergizedProtection/block"
;;
2)
geco ""
;;
esac
clear

		;;
		c) rm -rf /etc/hosts
		geco "[+] Clearing Hosts File..."
		sleep 3
		cat >> /etc/hosts <<EOF

127.0.0.1 localhost
0.0.0.0   0.0.0.0

EOF
        geco "[+] Done Clearing Hosts!"
        sleep 1
        ;;
        p)  wget -O $PTEMP https://raw.githubusercontent.com/EnergizedProtection/EnergizedHosts/master/EnergizedPornLite/energized/hosts
			geco "[+] Applying Porn Hosts to current hosts."
            mv $HOST $TEMP
			cat $TEMP $PTEMP > $HOST
			awk '!a[$0]++' $HOST > $PTEMP && mv -f $PTEMP $HOST
			rm -f $TEMP $PTEMP
			geco "[+] Done applying!"
		;;
		s)  wget -O $STEMP https://raw.githubusercontent.com/Sinfonietta/hostfiles/master/social-hosts
			geco "[+] Applying Social Hosts to current hosts."
            mv $HOST $TEMP
			cat $TEMP $STEMP > $HOST
			awk '!a[$0]++' $HOST > $STEMP && mv -f $STEMP $HOST
			rm -f $TEMP $STEMP
			geco "[+] Done applying!"
;;
          o)
geco "[+] Deleting Previous Hostfile"
rm /etc/hosts
geco "[+] Restoring Backup"
cp /data/EGb.jax /etc/hosts
geco "[+] Done applying!"
clear

		;;
		*)  geco ""
			geco "Invalid input. Don't use any spaces between letters."
		;;
	esac
	if [ $DIR ]; then
		geco ""
		wget -O $HOST https://raw.githubusercontent.com/EnergizedProtection/EnergizedHosts/$DIR
		geco "${GREEN}[+] Done Applying!${RC}"
		sleep 3
		grep "Updated" $TREADME > $FILTER
		sleep 3
		geco "${ORANGE}[+] Returning to main screen in 3 seconds...${RC}\n"
	fi
	DIR=""
	COUNT=$((COUNT+1))
done
rm -f $TREADME
geco "[+] Done!"
geco "${GREEN}-~- Stay Energized Buddy! -~-${RC}"
