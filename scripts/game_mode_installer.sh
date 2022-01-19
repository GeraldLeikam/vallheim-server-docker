#!/bin/sh

wget -v https://valheim.thunderstore.io/package/download/denikson/BepInExPack_Valheim/5.4.1700/ -O /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip
unzip /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip -d /tmp/BepInEx
cp -rv /tmp/BepInEx/BepInExPack_Valheim/* /valheim-server/BepInEx
rm -v /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip
rm -rv /tmp/BepInEx
