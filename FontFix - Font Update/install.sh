get_base_dir

geco "
[-] : Fix Missing/Blank fonts for every Games/Apps like Free Fire

[!] Your Fonts will be restored once uninstalled

[-] Fonts from Pie Build - Emoji Update
"



# Init
mkdir -p "/data/.FFTemp/"
cp "$BD/fonts.7z" "/data/.FFTemp/"
cd "/data/.FFTemp"

7z x fonts.7z
rm fonts.7z

# fonts.xml
mv "/system/etc/fonts.xml" "/system/etc/fonts.xml.bak"
cp "fonts.xml" "/system/etc/"
chmod 655 /system/etc/fonts.xml

# fonts
mkdir -p /data/.fonts.bak/
mv /system/fonts/* /data/.fonts.bak/
cp fonts/* /system/fonts/
chmod 655 /system/fonts/*

rm "/data/.FFTemp/" -r
