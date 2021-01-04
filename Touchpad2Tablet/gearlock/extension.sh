#!/gearlock/bin/bash

filesdir="/data/.Touchpad2Tablet"

nout mkdir "$filesdir/backup"

if [[ -f "$filesdir/conf.jax" ]];then
	Available=True
else
	Available=False
fi

helpmsg="With this extension, You can use your touchpad as touchscreen ( Abosolute Touch ).
Like a Drawing Tablet. Useful when you get to know how to use it properly.

NOTE : Enable 'Show Touches' in developer settings to see pointer dot.

Enable to Use the touchpad as touchscreen tablet. A Reboot is Required to apply changes.

This deals with the system files. Do not modify the extension/extension's files. If you do so, We
are not responsible for the damage caused.
"

aboutmsg="Touch2Tablet - By SupremeGamers

This extension is programmed by Jaxparrow and xtr helped me to make this extension.
Files provided as presets by xtr.

This extension is opensource and you can modify and distribute as your script.

GITHUB USERNAME: jaxparrow07
"

function ShowAbout() {
	dialog --title "About" --clear --msgbox "$aboutmsg" 20 70
	MainMenu
}

function Showhelp() {
	dialog --title "Help" --clear --msgbox "$helpmsg" 20 70
	MainMenu
}

function Disable() {

	if [[ $Available == True ]];then
		dialog --title "Disabling" --clear --msgbox "Disabling Touch Mode. Reboot to apply changes." 7 45
		# Disabling Commands
		cd /system/usr/idc/

		rm AlpsPS_2_ALPS_DualPoint_TouchPad.idc AlpsPS_2_ALPS_GlidePoint.idc ETPS_2_Elantech_Touchpad.idc SynPS_2_Synaptics_TouchPad.idc

		cp $filesdir/backup/* . -R

		rm "$filesdir/conf.jax"

		if [[ -f "$filesdir/conf.jax" ]];then
			Available=True
		else
			Available=False
		fi

	else

		dialog --title "Warning" --clear --msgbox "Not yet enabled. Use 'Turn On' to Enable" 7 45
		MainMenu

	fi
}

function Enable() {

	if [[ $Available == False ]];then
		dialog --title "Enabling" --clear --msgbox "Enabling Touch Mode. Reboot to apply changes" 7 45
		# Enabling Commands
		cd /system/usr/idc/

		mv AlpsPS_2_ALPS_DualPoint_TouchPad.idc AlpsPS_2_ALPS_GlidePoint.idc ETPS_2_Elantech_Touchpad.idc SynPS_2_Synaptics_TouchPad.idc $filesdir/backup/
		cp $filesdir/files/* . -R

		echo "Enabled" > "$filesdir/conf.jax"

		if [[ -f "$filesdir/conf.jax" ]];then
			Available=True
		else
			Available=False
		fi

	else

		dialog --title "Warning" --clear --msgbox "Already Enabled. Use 'Turn Off' to Disable" 7 45
		MainMenu

	fi
}

function MainMenu() {

	HEIGHT=13
	WIDTH=45
	CHOICE_HEIGHT=10
	BACKTITLE=$(gecpc "By SupremeGamers" "+")
	TITLE="Touchpad2Tablet"
	MENU="Available Options"

	OPTIONS=(1 "Turn On Touch Mode"
	         2 "Turn Off Touch Mode"
	         3 "Help"
	         4 "About")

	CHOICE=$(dialog --clear --cancel-label "Exit" \
	                --backtitle "$BACKTITLE" \
	                --title "$TITLE" \
	                --menu "$MENU" \
	                $HEIGHT $WIDTH $CHOICE_HEIGHT \
	                "${OPTIONS[@]}" \
	                2>&1 >/dev/tty)

    case $CHOICE in
    	1)Enable;;
		2)Disable;;
		3)Showhelp;;
		4)ShowAbout;;
		*);;
	esac
}

MainMenu