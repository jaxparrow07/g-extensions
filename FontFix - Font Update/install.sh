get_base_dir

geco "
[!] THIS WILL UPDATE YOUR FONT FILES

[-] : Fix Missing/Blank fonts for Games/Apps. ( Tested with Free Fire ).

[!] Your Fonts will be restored once uninstalled

[-] Fonts from Pie Build - Emoji Update
"



# Init
mkdir -p "/data/.FFTemp/"
cp "$BD/fonts.7z" "/data/.FFTemp/"
cd "/data/.FFTemp"

check_compat 6.0

if [[ $COMPAT == "no";then

garc x fonts.7z

else


7z x fonts.7z

fi

rm fonts.7z

# fonts.xml
mv /system/etc/fonts.xml /system/etc/fonts.xml.bak
cp fonts.xml /system/etc/

# fonts
cd fonts/
mkdir -p /data/.fonts.bak/
cp /system/fonts/* /data/.fonts.bak/
rm /system/fonts/*
cp * /system/fonts/
chmod 644 /system/fonts/*

rm "/data/.FFTemp/" -r
