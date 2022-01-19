#!/bin/sh

wget -v https://valheim.thunderstore.io/package/download/denikson/BepInExPack_Valheim/5.4.1700/ -O /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip
unzip /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip -d /tmp/BepInEx
cp -r /tmp/BepInEx/BepInExPack_Valheim/* /valheim-server/BepInEx
rm -v /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip
rm -r /tmp/BepInEx

#wget -v https://valheim.thunderstore.io/package/download/1F31A/BepInEx_Valheim_Full_Updater/1.0.2/ -O /tmp/1F31A-BepInEx_Valheim_Full_Updater-1.0.2.zip
#unzip /tmp/1F31A-BepInEx_Valheim_Full_Updater-1.0.2.zip -d /tmp/BepInEx
#cp -r /tmp/BepInEx/BepInEx_Valheim_Full_Updater/* /valheim-server/BepInExFull
#rm -v /tmp/1F31A-BepInEx_Valheim_Full_Updater-1.0.2.zip
#rm -r /tmp/BepInEx
