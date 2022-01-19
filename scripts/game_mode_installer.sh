#!/bin/sh

wget -v https://valheim.thunderstore.io/package/download/denikson/BepInExPack_Valheim/5.4.1700/ -O /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip
unzip /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip -d /tmp/BepInEx
cp -rv /tmp/BepInEx/BepInExPack_Valheim/* /valheim-server/BepInEx
rm -v /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip
rm -rv /tmp/BepInEx

wget -v https://valheim.thunderstore.io/package/download/1F31A/BepInEx_Valheim_Full/1.0.5/ -O /tmp/1F31A-BepInEx_Valheim_Full-1.0.5.zip
unzip /tmp/1F31A-BepInEx_Valheim_Full-1.0.5.zip -d /tmp/BepInEx
cp -rv /tmp/BepInEx/BepInEx_Valheim_Full/* /valheim-server/BepInExFull
rm -v /tmp/1F31A-BepInEx_Valheim_Full-1.0.5.zip
rm -rv /tmp/BepInEx
