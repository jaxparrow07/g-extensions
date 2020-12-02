#!/gearlock/bin/bash

# Defining indicators

WARNING="[${RED}!${RC}]"
SUCCESS="[${GREEN}+${RC}]"
CAUTION="[${YELLOW}-${RC}]"
TASK="[${BLUE}*${RC}]"

function AppBackup() {
clear
figlet Backup
geco "
++++ List of Available Packages +++++

Select Any Package

"
Pkgs=$(pm list packages)
echo "$Pkgs" > /data/.Tempackage.jax
LIST1=$(pm list packages -3 | sed -e 's/package://g')
echo "$LIST1" > /data/.Templist.jax
echo "Cancel" >> /data/.Templist.jax
nl -s ")" /data/.Templist.jax
geco " "
read -p "Your Option >> " ReadPackagename
ReadPackage=$(sed "${ReadPackagename}!d" /data/.Templist.jax)
MAXLINES=$(wc -l /data/.Templist.jax | awk '{ print $1 }')

if [[ "$ReadPackagename" -gt "$MAXLINES" ]];then

geco "
$WARNING Invalid Option"
pausebreak
AppBackup
else

if [[ "$ReadPackage" == "Cancel" ]];then
geco "
$WARNING Aborted"
pausebreak
MainMenu
fi

fi

geco "
$CAUTION Selected $ReadPackage"
Prefix="package:"
Packagepathget=$(pm path "$ReadPackage")
Package="${Packagepathget//$Prefix/}"
geco "

Backup What?
[ Note : It will only Backup Data/OBB if it exists ]

$CAUTION Note : Files means that are stored in Android folder for the Package . Data means the app's saved data.
Will restore everything back to normal. ${YELLOW}e.g Score, Account, Level, Points etc.,.${RC}

1) Apk Only
2) Apk + Data ( Recommended )
3) Apk + OBB [ No Data Restore ]
4) Apk + OBB,AppData [ No Data Restore ]
5) Everything (Apk,Data,Files,AppData) - Slow
6) Cancel
"
read -p "Your Option >> " backupmethod

case $backupmethod in

1)
nout mkdir -p "/sdcard/GBackup/Apk/"
gclone "$Package" "/sdcard/GBackup/Apk/${ReadPackage}.apk"
geco "$CAUTION Will be saved to Apk Folder in GBackup"
;;

2)

geco "
$CAUTION Can be restored only using this extension"

rm /data/GBackup/* -rf

nout mkdir -p "/data/GBackup/"

gclone "$Package" "/data/GBackup/${ReadPackage}.apk" -p

echo "$ReadPackage" > "/data/GBackup/Info.jax"
mkdir -p "/data/GBackup/data/"
mkdir -p "/data/GBackup/data/$ReadPackage/"
gclone "/data/data/${ReadPackage}/" "/data/GBackup/data/$ReadPackage/" -p

backupmethod="1"

mkdir -p "/sdcard/GBackup/PersonalBkp"
cd "/data/GBackup/"
tar -pczf "/sdcard/GBackup/PersonalBkp/${ReadPackage}_GBackup.tar.gz" *

;;

3)
mkdir -p "/sdcard/GBackup/Original/$ReadPackage"
gclone "$Package" "/sdcard/GBackup/Original/$ReadPackage/${ReadPackage}.apk"

if [[ -d "/sdcard/Android/obb/$ReadPackage" ]];then
mkdir -p "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
gclone "/sdcard/Android/obb/$ReadPackage" "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
else
    geco "$WARNING No Obb File found"
    rm "/sdcard/GBackup/Original/$ReadPackage/" -r
    geco "$WARNING Aborting"
    pausebreak
    MainMenu
fi

;;

4)
mkdir -p "/sdcard/GBackup/Original/$ReadPackage"
gclone "$Package" "/sdcard/GBackup/Original/$ReadPackage/${ReadPackage}.apk"
if [[ -d "/sdcard/Android/data/$ReadPackage" ]];then
mkdir -p "/sdcard/GBackup/Original/$ReadPackage/Android/data/"
gclone "/sdcard/Android/data/$ReadPackage" "/sdcard/GBackup/Original/$ReadPackage/Android/data/"
else
geco "
$CAUTION No Data Found${RC}"
backupmethod="1"
fi

if [[ -d "/sdcard/Android/obb/$ReadPackage" ]];then
mkdir -p "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
gclone "/sdcard/Android/obb/$ReadPackage" "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
fi

;;


5)
geco "
$CAUTION Can be restored only using this extension"
geco "
$TASK Taking a Full Backup. This may take a while
"
rm /data/GBackup/* -rf

nout mkdir -p "/data/GBackup/"

gclone "$Package" "/data/GBackup/${ReadPackage}.apk"


if [[ -d "/sdcard/Android/data/$ReadPackage" ]];then
mkdir -p "/data/GBackup/Android/data/"
gclone "/sdcard/Android/data/$ReadPackage" "/data/GBackup/Android/data/" -p
fi

if [[ -d "/sdcard/Android/obb/$ReadPackage" ]];then
mkdir -p "/data/GBackup/Android/obb/"
gclone "/sdcard/Android/obb/$ReadPackage" "/data/GBackup/Android/obb/" -p
fi

echo "$ReadPackage" > "/data/GBackup/Info.jax"
mkdir -p "/data/GBackup/data/"
mkdir -p "/data/GBackup/data/$ReadPackage/"
gclone "/data/data/${ReadPackage}/" "/data/GBackup/data/$ReadPackage/" -p

backupmethod="1"

mkdir -p "/sdcard/GBackup/PersonalBkp"
cd "/data/GBackup/"
tar -pczf "/sdcard/GBackup/PersonalBkp/${ReadPackage}_GBackup.tar.gz" *

;;

6)
geco "$WARNING Cancelled
"
pausebreak
MainMenu
;;

*)
geco "$CAUTION Using 2nd Option"
geco "
$CAUTION Can be restored only using this extension"

rm /data/GBackup/* -rf

nout mkdir -p "/data/GBackup/"

gclone "$Package" "/data/GBackup/${ReadPackage}.apk" -p

echo "$ReadPackage" > "/data/GBackup/Info.jax"
mkdir -p "/data/GBackup/data/"
mkdir -p "/data/GBackup/data/$ReadPackage/"
gclone "/data/data/${ReadPackage}/" "/data/GBackup/data/$ReadPackage/" -p

backupmethod="1"

mkdir -p "/sdcard/GBackup/PersonalBkp"
cd "/data/GBackup/"
tar -pczf "/sdcard/GBackup/PersonalBkp/${ReadPackage}_GBackup.tar.gz" *
;;

esac

if [[ $backupmethod != "1" ]];then
geco "
Do you want to Make this as an xapk file? or compress to take an personal backup

$CAUTION Note : XAPK Files Can be installed using XAPK Installer or you can Share with your friends or upload online.

1) Personal Backup ( ${GREEN}Recommended${RC} )
2) XAPK File - ( for Sharing )
3) Only Files ( Can be found in Main Storage )
"
read -p "Your Option >> " backupcompress

case $backupcompress in

1)
mkdir -p /sdcard/GBackup/PersonalBkp
cd "/sdcard/GBackup/Original/$ReadPackage"
geco "$TASK Please Wait Creating Zip Archive in GBackup/PersonalBkp"
7z a "/sdcard/GBackup/PersonalBkp/$ReadPackage.zip" "*" 
geco ""
;;

2)
mkdir -p /sdcard/GBackup/XAPK
cd "/sdcard/GBackup/Original/$ReadPackage"
geco "$TASK Please Wait Creating XAPK File for Sharing in GBackup/XAPK"
7z a "/sdcard/GBackup/XAPK/${ReadPackage}_GBackup.xapk" "*"
;;

3)
geco "
$CAUTION Your Files are not compressed. You can copy it or install it manually after sometime"
geco "$CAUTION Your Files can be found in your Main Storage by GBackup/Original/$ReadPackage/"
;;

*)
geco "
$CAUTION Your Files are not compressed. You can copy it or install it manually after sometime"
geco "$CAUTION Your Files can be found in your Main Storage by GBackup/Original/$ReadPackage/"
;;

esac

fi
geco "
$SUCCESS Completed Backing up $ReadPackage"
pausebreak
MainMenu

}

function AppRestore() {

    geco "Please Put your files in ${YELLOW}GBackup/PersonalBkp${RC} of Main Storage"

    if [[ -d /sdcard/GBackup/PersonalBkp ]];then
cd /sdcard/GBackup/PersonalBkp/
geco " "

geco " ++++ Backups ++++ 
"

if [ ! "$(ls -A /sdcard/GBackup/PersonalBkp/)" ]
then
    geco "$WARNING Empty Directory"
    pausebreak
    MainMenu
fi

shopt -s nullglob
zip=(/sdcard/GBackup/PersonalBkp/*.zip)
tar=(/sdcard/GBackup/PersonalBkp/*.tar.gz)

if ((${#zip[@]} && ${#tar[@]}));then
	files=( *.tar.gz *.zip )
elif ((${#zip[@]}));then
	files=( *.zip )
elif ((${#tar[@]}));then
	files=( *.tar.gz )
fi

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
    
        if [[ "$file" == *".zip"* ]]; then
        ext=".zip"
        else
        ext=".tar.gz"
        fi
        filex=${file//$ext/}
        nout rm /data/GRestore/ -rf
        mkdir -p "/data/GRestore/"
        if [[ "$file" == *".zip"* ]]; then
        unzip "${file}" -d "/data/GRestore/"
        else
        tar -xpf "$file" -C "/data/GRestore"

	fi
geco "$TASK Restoring Backup.. Please Wait"
geco "$CAUTION Do not switch to GUI while restoring"
cd "/data/GRestore/"
        

PkgnameR=$(cat Info.jax)

if [[ -d /data/data/$PkgnameR ]];then
	geco "$CAUTION App already installed
Please uninstall and Restore this backup"
pausebreak
MainMenu
fi

nout pm install *.apk

        if [[ -d "data" ]];then


geco "$TASK Copying files"


cd data
gclone * /data/data/ -r
cd ..


# Snippet by AXON
ug="$(grep "$PkgnameR" /data/system/packages.list | awk '{print $2}')"
chown -hR ${ug}:${ug} /data/data/$PkgnameR


geco "
$SUCCESS Your Previous Data was Restored.
E.g Score, Level, Account, Progress etc.,. are now restored "
DATAa="True"
else
geco "
$CAUTION No Data found. This is created using 3rd Option.
E.g Score, Level, Account, Progress etc.,."
DATAa="False"
fi


        if [ -d "Android" ]
then
geco "$TASK Copying App/Game Files"
gclone "Android" "/sdcard/"
geco "
$SUCCESS Copied App/Game Files"
fi

geco "$SUCCESS Restored $PkgnameR Successfully"


pausebreak
MainMenu

      break;
;;
    

    "Cancel")
        
MainMenu

;;

    *)
        file=""
        geco "$CAUTION Please choose a number from 1 to $((${#files[@]}+1))" ;;
    esac
done

    else
    geco "$CAUTION Directory Not Found
    "
    pausebreak
    MainMenu

fi

}

function pausebreak(){
    geco "
$CAUTION Press any [${GREEN}key${RC}] to continue"
    read -n 1 pausebreakvar
}

function AboutMenu() {
    clear
geco '
                                      ____             __                  ___        ____            __                
                                     / __ )____ ______/ /____  ______     ( _ )      / __ \___  _____/ /_____  ________ 
                                    / __  / __  / ___/ //_/ / / / __ \   / __ \/|   / /_/ / _ \/ ___/ __/ __ \/ ___/ _ \
                                   / /_/ / /_/ / /__/ ,< / /_/ / /_/ /  / /_/  <   / _, _/  __(__  ) /_/ /_/ / /  /  __/
                                  /_____/\__,_/\___/_/|_|\__,_/ .___/   \____/\/  /_/ |_|\___/____/\__/\____/_/   \___/
                                                             /_/'                                                        

geco "
                                                                        By ${YELLOW}Jaxparrow${RC}                                                      


                                     Backup and Restore extension is created by Jaxparrow to Easily Backup/Restore
                                     And Extract .apk packages from the original ( Installed ) app easily. 
                                     
                                     More advanced options available for users to use. (eg. Create XAPK, Create Personal.zip)
                                     You can only restore the ${YELLOW}Personal Backup${RC} that you have created.
                                     
                                     You can also install the ${GREEN}XAPK${RC} files with XAPK INSTALLER ( extension )
                                     and also using other Third Party XAPK Installers. You can choose to only keep the 
                                     RAW Files ( without Compressing ) if you want to manually install it later on or
                                     take a local backup. 
                                     
                                     EXTENSION MAKING TIME : 15+ hours. *Only making time
                                     
                                     I hardworked on this extension. This extension has more complex
                                     Text Processing I've ever made. This Extension Invloves in more text Processing
                                     for Package Selection, Package Backup. Rate this extension if you liked it. 
                                     
"
pausebreak
MainMenu
}

function HelpMenu() {
    clear
geco '
                                      ____             __                  ___        ____            __                
                                     / __ )____ ______/ /____  ______     ( _ )      / __ \___  _____/ /_____  ________ 
                                    / __  / __  / ___/ //_/ / / / __ \   / __ \/|   / /_/ / _ \/ ___/ __/ __ \/ ___/ _ \
                                   / /_/ / /_/ / /__/ ,< / /_/ / /_/ /  / /_/  <   / _, _/  __(__  ) /_/ /_/ / /  /  __/
                                  /_____/\__,_/\___/_/|_|\__,_/ .___/   \____/\/  /_/ |_|\___/____/\__/\____/_/   \___/
                                                             /_/'                                                        

geco "
                                                                        By ${YELLOW}Jaxparrow${RC}                                                      
                                     
                                     ${YELLOW}Advanced Backup & Restore :-${RC}
                                     You can create .xapk .zip or take a personal backup when creating a Backup.
                                     You can also choose what to backup (e.g. Apk only, Apk+data or Apk+data+obb ).
                                     Uses unzip to extract archive and gclone to copy.

                                     ${YELLOW}Compression & Creation :-${RC}
                                     Uses ${GREEN}7z${RC} to Highly compress Archive at lesser time. More faster
                                     and Stable. Less file size. Max support. zip format archive.

                                     FAQ:
					1. What is the difference in the Backup Methods ?
					(ANS) 2nd and 4th options contains data which also takes backup of your
					Progress, levels, coins etc.,.

					2. What is the use of the creating xapk or Personal zip ?
					(ANS) It'll be useful to share with your friends or if you wish to
					reinstall (without progress) on your own.

					3. Can I install the tar.gz file on my own.
					(ANS) No, It can be only installed using This Extension.


"
pausebreak
MainMenu
}

function MainMenu() {
clear
nout rm /data/GBackup/* -r
nout rm /data/GRestore/* -r

geco '
                                      ____             __                  ___        ____            __                
                                     / __ )____ ______/ /____  ______     ( _ )      / __ \___  _____/ /_____  ________ 
                                    / __  / __  / ___/ //_/ / / / __ \   / __ \/|   / /_/ / _ \/ ___/ __/ __ \/ ___/ _ \
                                   / /_/ / /_/ / /__/ ,< / /_/ / /_/ /  / /_/  <   / _, _/  __(__  ) /_/ /_/ / /  /  __/
                                  /_____/\__,_/\___/_/|_|\__,_/ .___/   \____/\/  /_/ |_|\___/____/\__/\____/_/   \___/
                                                             /_/'                                                        
geco "
                                                                        By ${YELLOW}Jaxparrow${RC}                                                      

                                                                   [1] Backup App
                                                                   [2] Restore App
                                                                   [h] Help
                                                                   [a] About
                                                                   [x] Exit" 
geco ""
read -n 1 -p "Enter Option >> " mainmenu
geco "
"

case $mainmenu in
1)
AppBackup
;;

2)
AppRestore
;;

"h")
HelpMenu
;;


"a")
AboutMenu
;;

"x")
exit
;;

*)
geco "$WARNING Invalid Option${RC}"
pausebreak
MainMenu
;;

esac

}

MainMenu
