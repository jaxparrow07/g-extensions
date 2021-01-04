filesdir="/data/.Touchpad2Tablet"

if [[ -f "$filesdir/conf.jax" ]];then
	Available=True
else
	Available=False
fi

if [[ $Available == True ]];then
	dialog --title "Disabling" --clear --msgbox "Disabling Touch Mode. Reboot to apply changes." 7 45
	# Disabling Commands
	cd /system/usr/idc/

	rm AlpsPS_2_ALPS_DualPoint_TouchPad.idc AlpsPS_2_ALPS_GlidePoint.idc ETPS_2_Elantech_Touchpad.idc SynPS_2_Synaptics_TouchPad.idc

	cp $filesdir/backup/* . -R

	rm $filesdir -r

fi