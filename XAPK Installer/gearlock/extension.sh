#!/gearlock/bin/bash


# Change this according to Extension version
EXT_VERSION="3.0.2"

opentime=`date +"%r"`
date=`date +'%m/%d/%Y'`

        if [ -d "/data/XAPK/Temp" ] 

then
cd /data/XAPK/Temp/
rm * -r

else
geco "
"
fi



# Legacy Mode for Installing even Invalid XAPKs in a possible way. Installation Snipper from v1.6
function Legacymode() {
clear
geco "
                                                  _    _        ______  _    _    _____                      _ _             
                                                 \ \  / /  /\  (_____ \| |  / )  (_____)           _        | | |            
                                                  \ \/ /  /  \  _____) ) | / /      _   ____   ___| |_  ____| | | ____  ____ 
                                                   )  (  / /\ \|  ____/| |< <      | | |  _ \ /___)  _)/ _  | | |/ _  )/ ___)
                                                  / /\ \| |__| | |     | | \ \    _| |_| | | |___ | |_( ( | | | ( (/ /| |    
                                                 /_/  \_\______|_|     |_|  \_)  (_____)_| |_(___/ \___)_||_|_|_|\____)_|   
                                                "
gecpc "Legacy Mode ( for unsupported XAPK )" "+"

geco ""
geco "[!] Installing from file : ${filex}"

geco "
[-] Installing Apk :\c"
pm install *.apk

        if [ -d "/sdcard/Android/obb" ] 
then
nout geco "0"

else

opentime=`date +"%r"`
echo "Created obb folder on ${opentime} ${date}" >> /sdcard/XAPK-log.txt

mkdir /sdcard/Android/obb

fi


geco "${YELLOW}[-] Copying Game Files${RC}"
gclone Android /sdcard/
geco "${GREEN}[+] Copied Game Files${RC}"

geco ""
geco "${GREEN}[+] Installed ${filex} Successfully!${RC}"
rm "/data/XAPK/Temp/${filex}" -r
geco "
[-] Press any Key to Continue"
read -n 1 wasteoftime
MainMenu

}

function HTU()
{
clear
geco "
                                                  _    _        ______  _    _    _____                      _ _             
                                                 \ \  / /  /\  (_____ \| |  / )  (_____)           _        | | |            
                                                  \ \/ /  /  \  _____) ) | / /      _   ____   ___| |_  ____| | | ____  ____ 
                                                   )  (  / /\ \|  ____/| |< <      | | |  _ \ /___)  _)/ _  | | |/ _  )/ ___)
                                                  / /\ \| |__| | |     | | \ \    _| |_| | | |___ | |_( ( | | | ( (/ /| |    
                                                 /_/  \_\______|_|     |_|  \_)  (_____)_| |_(___/ \___)_||_|_|_|\____)_|   
                                                 "

gecpc "Help - How to Use" "+"
geco " 
                                                 Place your XAPK files in Gearload, Download for easy access through this.
                                                 You can easily chose Custom folder to search for extension in the Location
                                                 Selector ( developed by me ). After Choosing the location. You can select
                                                 a XAPK file from the chosen folder. You can see the App's version, Required
                                                 Permissions and choose to install or not ( Similar to APK installation GUI).
                                                 If the extension is a split XAPK. You can choose to install which config
                                                 to be installed ( e.g config.en for English pack - Must be included with 
                                                 the app ) or skip config installation.

                                                 by SupremeGamers ( https://supreme-gamers.com )
                                                 "
geco "${YELLOW}[!] Press any key to goto Main Menu${RC}"

read HTU

MainMenu

}

function About()
{
clear
geco "
                                                  _    _        ______  _    _    _____                      _ _             
                                                 \ \  / /  /\  (_____ \| |  / )  (_____)           _        | | |            
                                                  \ \/ /  /  \  _____) ) | / /      _   ____   ___| |_  ____| | | ____  ____ 
                                                   )  (  / /\ \|  ____/| |< <      | | |  _ \ /___)  _)/ _  | | |/ _  )/ ___)
                                                  / /\ \| |__| | |     | | \ \    _| |_| | | |___ | |_( ( | | | ( (/ /| |    
                                                 /_/  \_\______|_|     |_|  \_)  (_____)_| |_(___/ \___)_||_|_|_|\____)_|   
                                                 "

gecpc "About This Extension" "+"
geco " 
                                                 Thanks for using XAPK Installer. I hope you will like this update of this
                                                 extension. Easy Install XAPK file like never before (cli). More Simplified
                                                 in Newer versions. Contact me if you have any doubts/bugs/suggestions.

                                                 Created by your Jaxparrow. Took more than 5 hours to make this simple
                                                 extension ( On your view of using ). This can be used for a 10 seconds work.
                                                 But, It is needed to be coded for hours to fix bugs & implement new features.
                                                 
                                                 Show your Support by Rating with Stars.

                                                 by SupremeGamers ( https://supreme-gamers.com )"

geco "
${YELLOW}[!] Press any key to goto Main Menu${RC}"

read aboutin

MainMenu
}

function Install()
{

# XAPK Installer's own Location Selector

rm /data/XAPK/ -r

clear
geco "
                                                  _    _        ______  _    _    _____                      _ _             
                                                 \ \  / /  /\  (_____ \| |  / )  (_____)           _        | | |            
                                                  \ \/ /  /  \  _____) ) | / /      _   ____   ___| |_  ____| | | ____  ____ 
                                                   )  (  / /\ \|  ____/| |< <      | | |  _ \ /___)  _)/ _  | | |/ _  )/ ___)
                                                  / /\ \| |__| | |     | | \ \    _| |_| | | |___ | |_( ( | | | ( (/ /| |    
                                                 /_/  \_\______|_|     |_|  \_)  (_____)_| |_(___/ \___)_||_|_|_|\____)_|   "

gecpc "Location Selection" "+"

geco "
                                                                      Where to look for XAPK files

                                                                       [1] Gearload ( Default )
                                                                       [2] Downloads ( Most Common )
                                                                       [3] Custom Folder ( Folder Selector )
                                                                       [4] Go Back
"

read -p "Option >> " locationsel

case $locationsel in

1)
cd ${GRLOAD}
;;

2)
cd /sdcard/Download/
;;
3)
cd /sdcard/
FileSelector() {
clear
gecpc "$(pwd)" "="
ls -l
gecpc "$(pwd)" "="
geco "
Type and press enter to Use this options
[${YELLOW}+${RC}] - to Select Current folder
[${YELLOW}-${RC}] - to Go Back one folder
[${YELLOW}foldername${RC}] - to Enter a folder"
geco ""
read -p "Option/Folder > " foldervar
case $foldervar in

"+")
FOLDER=$(pwd)
;;

"-")
cd ..
FileSelector
;;

*)

if [[ -d "$foldervar" ]];then
cd $foldervar
FileSelector
else
FileSelector
fi

;;

esac
}

FileSelector

;;


4)
MainMenu
;;

*)

geco "[-] Invalid Option"
sleep 1
Install

esac

clear
geco "
                                                  _    _        ______  _    _    _____                      _ _             
                                                 \ \  / /  /\  (_____ \| |  / )  (_____)           _        | | |            
                                                  \ \/ /  /  \  _____) ) | / /      _   ____   ___| |_  ____| | | ____  ____ 
                                                   )  (  / /\ \|  ____/| |< <      | | |  _ \ /___)  _)/ _  | | |/ _  )/ ___)
                                                  / /\ \| |__| | |     | | \ \    _| |_| | | |___ | |_( ( | | | ( (/ /| |    
                                                 /_/  \_\______|_|     |_|  \_)  (_____)_| |_(___/ \___)_||_|_|_|\____)_|   "
gecpc "$EXT_VERSION" "+"

# File Selector..

count=`ls -1 *.xapk 2>/dev/null | wc -l`
if [ $count != 0 ]
then 
geco "${GREEN}[i] ${count} xapk files found${RC}"
geco "
"
else
geco "${RED}[-] No xapk files found in Current Folder${RC}"
geco "[!] Place your xapk files in this folder and try again"
geco "
"
geco "${YELLOW}[-] Press any key to goto Main Menu${RC}"
read mainmenuentryfail
MainMenu
fi

files=( *.xapk )
shopt -s extglob
string="@(${files[0]}"
for((i=1;i<${#files[@]};i++))
do
    string+="|${files[$i]}"
done
string+=")"
select file in "${files[@]}" "Cancel"
do
    case $file in
    $string)
        ext=.xapk
        filex=${file//$ext/}
        geco "Opening ${filex} file"

        if [ -d "/data/XAPK/Temp/" ] 
then

geco "
"
else

mkdir -p /data/XAPK/Temp

fi

mkdir "/data/XAPK/Temp/${filex}/"
geco "[-] Extracting File $filex"
unzip "${file}" -d "/data/XAPK/Temp/${filex}"

geco "
"
cd "/data/XAPK/Temp/${filex}"

# Parsing Value from JSON

if [[ -f manifest.json ]];then
insmod=0
Appname=$(cat manifest.json | jq -r '.name')
Packagename=$(cat manifest.json | jq -r '.package_name' )
Permissions=$(cat manifest.json | jq -r '.permissions' )
Version_name=$(cat manifest.json | jq -r '.version_name' )
Min_sdk=$(cat manifest.json | jq -r '.min_sdk_version' )

else

if [[ -d "Android" ]];then
insmod=1
else
insmod=2
fi

fi

if [[ $insmod == 2 ]];then

geco "Unsupported File. Please Download it again."
geco "
[-] Press any Key to Continue"
read -n 1 wasteoftime
MainMenu

elif [[ $insmod == 1 ]];then
geco "
[-] This XAPK is not a properly packed XAPK. But, Can be installed in ${GREEN}Legacy Mode${RC}.

[!] Press any [Key] to Continue"
read -n 1 wasteoftime

Legacymode
fi

# Continue to Install in Normal mode if the value is 0



# New UI

clear
gecpc "XAPK Installer" "="
figlet -f small "$Appname"
geco "Version : $Version_name"
gecpc "Info" "="


## SDK  Checking - Depriciated due to bugs within the SDK Checking

# if [[ -z $SDK ]];then
#
# geco ""
# figlet -f small "Failed!"
# geco "Failed to get SDK Version. Please Try Again after sometime or reboot your device."

# geco "[-] Press any Key to Continue"

# read -n 1 wasteoftime
# MainMenu

# else

# sdkversion="$SDK"

# fi

# if [[ $sdkversion -lt $Min_sdk ]];then
# geco ""
# figlet -f small "Unsupported!"
# geco "This Application requres atleast $Min_sdk SDK version. Current : $sdkversion"

# geco "[-] Press any Key to Continue"

# read -n 1 wasteoftime
# MainMenu
# fi

geco "Required Permissions
$Permissions
"
gecpc "Prompt" "="

if [[ -d /data/data/$Packagename ]];then
	update=true
else
	update=false
fi

if [[ $update == false ]];then
geco "
[!] Do you want to install $Appname [Y/n]: \c"
	read userpromt
else
	geco "
[!] Do you want to update $Appname to $Version_name [Y/n]: \c"
	read userpromt
fi

case $userpromt in

y)
geco "[+] Installing"
;;
Y)
geco "[+] Installing"
;;

*)
geco "
[-] Aborted by User ($(whoami))
"
geco "[!] Press any key to continue"
read -n 1 something
MainMenu
;;

esac

# Continue Installing without errors.

splitcount=$(ls -1 config* 2>/dev/null | wc -l)

if [[ $splitcount -ne 0 ]];then
gecpc "Extra Configs" "="
geco "Choose Your Extra Configs Manually. e.g config.en for English
"
files=( config* )
shopt -s extglob
string="@(${files[0]}"
for((i=1;i<${#files[@]};i++))
do
    string+="|${files[$i]}"
done
string+=")"
select file in "${files[@]}" "Skip"
do
    case $file in

    $string)
    geco "
[+] Installing Base Apk with $file : \c"
    pm install -r "${Packagename}.apk" "$file"
    break;
    ;;
    
    *)
    geco "
[-] Skipping Language Configs"
    geco "[+] Installing Base Apk : \c"
    pm install -r "${Packagename}.apk"
break;
;;

    esac
done

else

geco  "
[+] Installing Apk : \c"
pm install -r "${Packagename}.apk"


fi


        if [ -d "/sdcard/Android/obb" ]
then
geco ""
else
opentime=`date +"%r"`
echo "Created obb folder on ${opentime} ${date}" >> /sdcard/XAPK-log.txt

mkdir /sdcard/Android/obb

fi

if [ -d "Android" ]
then
	if [[ $update == false ]];then

		geco "${YELLOW}[-] Copying Game Files${RC}"
		gclone Android /sdcard/
		geco "${GREEN}[+] Copied Game Files${RC}"

	else
		geco "${YELLOW}[-] Removing Current OBB${RC}"
		rm "/sdcard/Android/obb/$Packagename" -r
		geco "${YELLOW}[-] Copying Game Files${RC}"
		gclone Android /sdcard/
		geco "${GREEN}[+] Copied Game Files${RC}"
	fi
else
	geco "${YELLOW}[!] No Obb File Found${RC}"
fi

if [[ $update == false ]];then
    geco "${GREEN}
[+] Installed ${Appname} Successfully ${RC}"
else
	geco "${GREEN}
[+] Updated ${Appname} Successfully ${RC}"
fi
        rm "/data/XAPK/Temp/${filex}" -r

opentime=`date +"%r"`
if [[ $update == false ]];then
	echo "Installed ${Appname} Successfully on ${opentime} ${date}" >> /sdcard/XAPK-log.txt
else
	echo "Updated ${Appname} Successfully to $Version_name on ${opentime} ${date}" >> /sdcard/XAPK-log.txt
fi
geco "${YELLOW}
[!] Press any Key to go to Main Menu${RC}"
read coninput
MainMenu
      break;
;;
    

    "Cancel")
        
MainMenu

;;

    *)
        file=""
        geco "Please choose a number from 1 to $((${#files[@]}+1))" ;;
    esac
done
}

function MainMenu()

{
clear
geco "
                                                  _    _        ______  _    _    _____                      _ _             
                                                 \ \  / /  /\  (_____ \| |  / )  (_____)           _        | | |            
                                                  \ \/ /  /  \  _____) ) | / /      _   ____   ___| |_  ____| | | ____  ____ 
                                                   )  (  / /\ \|  ____/| |< <      | | |  _ \ /___)  _)/ _  | | |/ _  )/ ___)
                                                  / /\ \| |__| | |     | | \ \    _| |_| | | |___ | |_( ( | | | ( (/ /| |    
                                                 /_/  \_\______|_|     |_|  \_)  (_____)_| |_(___/ \___)_||_|_|_|\____)_|    
                                                                              $EXT_VERSION
                                                                              
                                                                           by SupremeGamers
                                                                     
                                                                          [1] Install XAPK File
                                                                          [2] View Log
                                                                          [3] Clear Log                                 
                                                                          [4] Help
                                                                          [5] About
                                                                          [6] Exit"


read -n 1 -p "Option >> " mmi

case $mmi in

    1)
Install

;;

    2)

clear
geco "
                                                  _    _        ______  _    _    _____                      _ _             
                                                 \ \  / /  /\  (_____ \| |  / )  (_____)           _        | | |            
                                                  \ \/ /  /  \  _____) ) | / /      _   ____   ___| |_  ____| | | ____  ____ 
                                                   )  (  / /\ \|  ____/| |< <      | | |  _ \ /___)  _)/ _  | | |/ _  )/ ___)
                                                  / /\ \| |__| | |     | | \ \    _| |_| | | |___ | |_( ( | | | ( (/ /| |    
                                                 /_/  \_\______|_|     |_|  \_)  (_____)_| |_(___/ \___)_||_|_|_|\____)_|    "
gecpc "Log File" "="
if [[ -f /sdcard/XAPK-log.txt ]];then
	gecca /sdcard/XAPK-log.txt
else
	geco "No Log found"
fi
geco "
[-] Press any Key to to continue"
read -n 1 something
MainMenu
    ;;

    3)
clear
figlet Clearing
geco "Your XAPK-Installer Log file"
rm /sdcard/XAPK-log.txt
touch /sdcard/XAPK-log.txt
geco "
"
geco "Done"
sleep 2
MainMenu

;;

    4)
HTU

;;
    5)
About

;;
    6)
exit

;;

    *)
geco "
No such option"
sleep 2
MainMenu

;;
esac
}

MainMenu