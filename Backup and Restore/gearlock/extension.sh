#!/gearlock/bin/bash

# Defining indicators

WARNING="[!]"
SUCCESS="[+]"
CAUTION="[-]"
TASK="[*]"

function g_clone() {
(rsync -ah --info=progress2 "$@" -p) 2>&1 | \
dialog --progressbox "..................... Progress  ======  Speed.............." 7 80
}


function AppBackup() {

HEIGHT=25
	WIDTH=60
	CHOICE_HEIGHT=20
	BACKTITLE=$(gecpc "Made By Jaxparrow | GUI by Xtr" "_")
	TITLE="++++ List of Available Packages ++++"
	MENU="Select Any Package"
	
    let i=0 # define counting variable
	OPTIONS=() # define working array
	while read -r line; do # process file by file
    let i=$i+1
    OPTIONS+=($i "$line")
	done < <( pm list packages -3 | sed -e 's/package://g' )
	ReadPackagename=$(dialog --clear --cancel-label "Exit" \
	                --backtitle "$BACKTITLE" \
	                --title "$TITLE" \
	                --menu "$MENU" \
	                $HEIGHT $WIDTH $CHOICE_HEIGHT \
	                "${OPTIONS[@]}" \
	                2>&1 >/dev/tty)
if [ $? -eq 0 ]; then # Exit with OK
    ReadPackage=$(pm list packages -3 | sed -e 's/package://g' | sed "${ReadPackagename}!d")
	Prefix="package:"
	Packagepathget=$(pm path "$ReadPackage")
	Package="${Packagepathget//$Prefix/}"

            
            HEIGHT=20
            WIDTH=60
            CHOICE_HEIGHT=20
            BACKTITLE=$(gecpc "Made By Jaxparrow | GUI by Xtr" "_")
            TITLE="$CAUTION Selected $ReadPackage"
            MENU="Backup What?
        [ Note : It will only Backup Data/OBB if it exists ]

        $CAUTION Note : Files means that are stored in Android folder for the Package . Data means the app's saved data.
        Will restore everything back to normal. e.g Score, Account, Level, Points etc.,."
            
            OPTIONS=(
        1 "Apk Only"
        2 "Apk + Data ( Recommended )"
        3 "Apk + OBB [ No Data Restore ]"
        4 "Apk + OBB,AppData [ No Data Restore ]"
        5 "Everything (Apk,Data,Files,AppData) - Slow"
        6 "Cancel"
        )
            backupmethod=$(dialog --clear --cancel-label "Exit" \
                            --backtitle "$BACKTITLE" \
                            --title "$TITLE" \
                            --menu "$MENU" \
                            $HEIGHT $WIDTH $CHOICE_HEIGHT \
                            "${OPTIONS[@]}" \
                            2>&1 >/dev/tty)

        case $backupmethod in
        1)
            nout mkdir -p "/sdcard/GBackup/Apk/"
            g_clone "$Package" "/sdcard/GBackup/Apk/${ReadPackage}.apk" 

            dialog --msgbox "$CAUTION Will be saved to Apk Folder in GBackup" 5 50
            ;;
        2)

            dialog --msgbox "$CAUTION Can be restored only using this extension" 5 50

            rm /data/GBackup/* -rf

            nout mkdir -p "/data/GBackup/"

            g_clone "$Package" "/data/GBackup/${ReadPackage}.apk" 

            echo "$ReadPackage" > "/data/GBackup/Info.jax"
            mkdir -p "/data/GBackup/data/"
            mkdir -p "/data/GBackup/data/$ReadPackage/"
            g_clone "/data/data/${ReadPackage}/" "/data/GBackup/data/$ReadPackage/" 

            backupmethod="1"

            mkdir -p "/sdcard/GBackup/PersonalBkp"
            cd "/data/GBackup/"
            (   
                echo "Creating Archive
            Please wait....."
                tar -pczf "/sdcard/GBackup/PersonalBkp/${ReadPackage}_GBackup.tar.gz" *
            ) | dialog --progressbox "Backup in progress" 7 50

            ;;

        3)
            mkdir -p "/sdcard/GBackup/Original/$ReadPackage"
            g_clone "$Package" "/sdcard/GBackup/Original/$ReadPackage/${ReadPackage}.apk"

            if [[ -d "/sdcard/Android/obb/$ReadPackage" ]]; then
                mkdir -p "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
                g_clone "/sdcard/Android/obb/$ReadPackage" "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
            else
                dialog --msgbox "$WARNING No Obb File found
                        $WARNING Aborting" 6 45
                rm "/sdcard/GBackup/Original/$ReadPackage/" -r
                MainMenu
            fi

        ;;

        4)
            mkdir -p "/sdcard/GBackup/Original/$ReadPackage"
            g_clone "$Package" "/sdcard/GBackup/Original/$ReadPackage/${ReadPackage}.apk"

            if [[ -d "/sdcard/Android/data/$ReadPackage" ]];then
                mkdir -p "/sdcard/GBackup/Original/$ReadPackage/Android/data/"
                g_clone "/sdcard/Android/data/$ReadPackage" "/sdcard/GBackup/Original/$ReadPackage/Android/data/"
            else
                dialog --msgbox "$CAUTION No Data Found${RC}" 6 45
                backupmethod="1"
            fi

            if [[ -d "/sdcard/Android/obb/$ReadPackage" ]];then
                mkdir -p "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
                g_clone "/sdcard/Android/obb/$ReadPackage" "/sdcard/GBackup/Original/$ReadPackage/Android/obb/"
            fi

            ;;


        5)
            dialog --msgbox "$CAUTION Can be restored only using this extension
            $TASK Taking a Full Backup. This may take a while" 6 50

            rm /data/GBackup/* -rf

            nout mkdir -p "/data/GBackup/"

            g_clone "$Package" "/data/GBackup/${ReadPackage}.apk"


            if [[ -d "/sdcard/Android/data/$ReadPackage" ]];then
                mkdir -p "/data/GBackup/Android/data/"
                g_clone "/sdcard/Android/data/$ReadPackage" "/data/GBackup/Android/data/" 
            fi

            if [[ -d "/sdcard/Android/obb/$ReadPackage" ]];then
                mkdir -p "/data/GBackup/Android/obb/"
                g_clone "/sdcard/Android/obb/$ReadPackage" "/data/GBackup/Android/obb/" 
            fi

            echo "$ReadPackage" > "/data/GBackup/Info.jax"
            mkdir -p "/data/GBackup/data/"
            mkdir -p "/data/GBackup/data/$ReadPackage/"
            g_clone "/data/data/${ReadPackage}/" "/data/GBackup/data/$ReadPackage/" 

            backupmethod="1"

            mkdir -p "/sdcard/GBackup/PersonalBkp"
            cd "/data/GBackup/"
                        (   
                echo "Creating Arhive
            Please wait....."
                tar -pczf "/sdcard/GBackup/PersonalBkp/${ReadPackage}_GBackup.tar.gz" *
            ) | dialog --progressbox "Backup in progress" 7 50

        ;;

        6)
            dialog --msgbox "$WARNING Cancelled" 5 40
            MainMenu
            ;;

        *)
            dialog --msgbox "$CAUTION Using 2nd Option
            $CAUTION Can be restored only using this extension" 7 45

            rm /data/GBackup/* -rf

            nout mkdir -p "/data/GBackup/"

            g_clone "$Package" "/data/GBackup/${ReadPackage}.apk" 

            echo "$ReadPackage" > "/data/GBackup/Info.jax"
            mkdir -p "/data/GBackup/data/"
            mkdir -p "/data/GBackup/data/$ReadPackage/"
            g_clone "/data/data/${ReadPackage}/" "/data/GBackup/data/$ReadPackage/" 

            backupmethod="1"

            mkdir -p "/sdcard/GBackup/PersonalBkp"
            cd "/data/GBackup/"
                        (   
                echo "Creating Archive
            Please wait....."
                tar -pczf "/sdcard/GBackup/PersonalBkp/${ReadPackage}_GBackup.tar.gz" *
            ) | dialog --progressbox "Backup in progress" 7 50
            ;;

        esac

        if [[ $backupmethod != "1" ]];then


    HEIGHT=20
	WIDTH=60
	CHOICE_HEIGHT=20
	BACKTITLE=$(gecpc "Made By Jaxparrow | GUI by Xtr" "_")
	TITLE="++++ Backup and restore ++++"
	MENU="Do you want to Make this as an xapk file? or compress to take an personal backup
        $CAUTION Note : XAPK Files Can be installed using XAPK Installer or you can Share with your friends or upload online."

	OPTIONS=( 1 "Personal Backup ( Recommended )"
        2 "XAPK File ( for Sharing )"
        3 "Only Files ( Can be found in Main Storage )"
    )
	backupcompress=$(dialog --clear --cancel-label "Exit" \
	                --backtitle "$BACKTITLE" \
	                --title "$TITLE" \
	                --menu "$MENU" \
	                $HEIGHT $WIDTH $CHOICE_HEIGHT \
	                "${OPTIONS[@]}" \
	                2>&1 >/dev/tty)
    

        case $backupcompress in

            1)
                mkdir -p /sdcard/GBackup/PersonalBkp
                cd "/sdcard/GBackup/Original/$ReadPackage"
                dialog --msgbox "$TASK Creating Zip Archive in GBackup/PersonalBkp" 7 45
                7z a "/sdcard/GBackup/PersonalBkp/$ReadPackage.zip" "*"
                ;;

            2)
                mkdir -p /sdcard/GBackup/XAPK
                cd "/sdcard/GBackup/Original/$ReadPackage"
                dialog --msgbox "$TASK Please Wait Creating XAPK File for Sharing in GBackup/XAPK" 7 45
                7z a "/sdcard/GBackup/XAPK/${ReadPackage}_GBackup.xapk" "*"
            ;;

            3)
                dialog --msgbox "$CAUTION Your Files are not compressed. You can copy it or install it manually after sometime
                $CAUTION Your Files can be found in your Main Storage by GBackup/Original/$ReadPackage/" 8 50

            ;;

            *)
                dialog --msgbox "$CAUTION Your Files are not compressed. You can copy it or install it manually after sometime
                $CAUTION Your Files can be found in your Main Storage by GBackup/Original/$ReadPackage/" 8 50
            ;;

            esac

        fi
        dialog --msgbox "$SUCCESS Completed Backing up $ReadPackage" 6 45
        MainMenu
    else
            MainMenu
    fi

}

function AppRestore() {

if [[ -d /sdcard/GBackup/PersonalBkp ]]; then

    cd /sdcard/GBackup/PersonalBkp/

    if [ ! "$(ls -A /sdcard/GBackup/PersonalBkp/)" ]
        then
            dialog --msgbox "$WARNING Empty Directory" 6 45
            MainMenu
    fi

    shopt -s nullglob
    zip=(/sdcard/GBackup/PersonalBkp/*.zip)
    tar=(/sdcard/GBackup/PersonalBkp/*.tar.gz)

    if ((${#zip[@]} && ${#tar[@]}))
        
        then
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
    
    HEIGHT=30
	WIDTH=60
	CHOICE_HEIGHT=28
	BACKTITLE=$(gecpc "Made By Jaxparrow | GUI by Xtr" "_")
	TITLE="++++ Backups ++++"
	MENU="Please Put your files in GBackup/PersonalBkp of Main Storage"
	
    let i=0 # define counting variable
	OPTIONS=() # define working array
	while read -r line; do # process file by file
    let i=$i+1
    OPTIONS+=($i "$line")
	done < <( echo "${files[@]}" )
	file=$(dialog --clear --cancel-label "Exit" \
	                --backtitle "$BACKTITLE" \
	                --title "$TITLE" \
	                --menu "$MENU" \
	                $HEIGHT $WIDTH $CHOICE_HEIGHT \
	                "${OPTIONS[@]}" \
	                2>&1 >/dev/tty)
    
    
    if [ $? -eq 0 ]; then 
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
                    
                                (   
                echo "Extracting Archive
            Please wait....."
                tar -xpf "$file" -C "/data/GRestore"
            ) | dialog --progressbox "Backup in progress" 7 45

                fi
            dialog --msgbox "$TASK Restoring Backup.. Please Wait" 7 45
            cd "/data/GRestore/"
                    

            PkgnameR=$(cat Info.jax)

            if [[ -d /data/data/$PkgnameR ]];then
                dialog --msgbox "$CAUTION App already installed
            Please uninstall and Restore this backup" 7 45
            MainMenu
            fi

            nout pm install *.apk

                    if [[ -d "data" ]];then



            cd data
            g_clone * /data/data/ -r
            cd ..


            # Snippet by AXON
            ug="$(grep "$PkgnameR" /data/system/packages.list | awk '{print $2}')"
            chown -hR ${ug}:${ug} /data/data/$PkgnameR


            dialog --msgbox "$SUCCESS Your Previous Data was Restored.
            E.g Score, Level, Account, Progress etc.,. are now restored" 6 65
            DATAa="True"
            else
            dialog --msgbox "$CAUTION No Data found. This is created using 3rd Option.
            E.g Score, Level, Account, Progress etc.,." 6 65
            DATAa="False"
            fi


            if [ -d "Android" ]
            then
                dialog --msgbox "$TASK Copying App/Game Files" 5 40
                g_clone "Android" "/sdcard/"
                dialog --msgbox "$SUCCESS Copied App/Game Files" 5 40
            fi

            dialog --msgbox "$SUCCESS Restored $PkgnameR Successfully" 6 45


            MainMenu

                break;
            ;;
                
            *)
                 AppRestore
        esac
    else
        MainMenu
    fi
    

    else
        dialog --msgbox "$CAUTION Directory Not Found" 5 40
        MainMenu

fi

}

function pausebreak(){
        geco "$CAUTION Press any [${GREEN}key${RC}] to continue"
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
                                     Uses unzip to extract archive and g_clone to copy.

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

nout rm /data/GBackup/* -r
nout rm /data/GRestore/* -r


	HEIGHT=13
	WIDTH=45
	CHOICE_HEIGHT=23
	BACKTITLE=$(gecpc "Made By Jaxparrow | GUI by Xtr" "_")
	TITLE="Backup and Restore"
	MENU="Choose an option"
	
	OPTIONS=(
1 "Backup app"
2 "Restore app"
3 "Help"
4 "About"
)
	mainmenu=$(dialog --clear --cancel-label "Exit" \
	                --backtitle "$BACKTITLE" \
	                --title "$TITLE" \
	                --menu "$MENU" \
	                $HEIGHT $WIDTH $CHOICE_HEIGHT \
	                "${OPTIONS[@]}" \
	                2>&1 >/dev/tty)

if [ $? -eq 0 ]; then # Exit with OK
    case $mainmenu in
        1)
        AppBackup
        ;;

        2)
        AppRestore
        ;;

        3)
        HelpMenu
        ;;


        4)
        AboutMenu
        ;;

        *)exit;;

    esac
else
    exit
fi

}

MainMenu
