get_base_dir

nout mkdir -p /data/XAPK/Temp
geco "[-] Making Directory for XAPK"
geco "[-] Installing jq for JSON Parsing"
rsync "$BD/jq" /system/bin && chmod 755 /system/bin/jq
