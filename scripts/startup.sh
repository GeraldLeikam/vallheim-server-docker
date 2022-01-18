#!/bin/sh
DEBUG=true
SCRIPT_SERVER_NAME="${SERVER_NAME:-'Default Valheim Server'}"
SCRIPT_WORlD_NAME="${WORLD_NAME:-'DefaultValheimWorld'}"

if [ $DEBUG==true ]; then
  echo $SCRIPT_SERVER_NAME
  echo $SCRIPT_WORlD_NAME
fi

/usr/games/steamcmd +force_install_dir /valheim-server/server +login anonymous +app_update 896660 validate +exit
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/valheim-server/server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
export LD_LIBRARY_PATH=$templdpath

echo "Starting server PRESS CTRL-C to exit"

/valheim-server/server/valheim_server.x86_64 -name "${SCRIPT_SERVER_NAME}" -port 2456 -world "${SCRIPT_WORlD_NAME}" -savedir "/valheim-server/save"

while true
do
  sleep 1
done
