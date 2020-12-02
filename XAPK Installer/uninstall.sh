geco "[-] Removing XAPK Directory" && rm -rf /data/XAPK/

geco "\n[!] Do you want to remove jq which is installed along with this. You can choose to use it later on.\n"

read -p "[/]Remove [y/N]: " prompt

if [ $prompt == "y" ] || [ $prompt == "Y" ];then
	rm /system/bin/jq
else
	geco "[+] jq is not removed. You can use it for parsing JSON."
fi
