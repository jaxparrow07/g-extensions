geco "[!] Removing New Fonts"
rm /system/fonts/*
rm '/system/etc/fonts.xml'

geco "[-] Restoring Old Fonts"
mv '/system/etc/fonts.xml.bak' '/system/etc/fonts.xml'
chmod 655 /system/etc/fonts.xml


cp /data/.fonts.bak/* /system/fonts/
chmod 655 /system/fonts/*


rm '/data/.fonts.bak/' -rf

geco "[+] Done
"
