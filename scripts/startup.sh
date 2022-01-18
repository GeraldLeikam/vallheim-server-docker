#!/bin/sh
if [[ -z "${SERVER_NAME}" ]]; then
  SCRIPT_SERVER_NAME="My Default Valheim Server. Please rename me."
else
  SCRIPT_SERVER_NAME="${SERVER_NAME}"
fi

if [[ -z "${WORLD_NAME}" ]]; then
  SCRIPT_WORlD_NAME="DefaultGeneratedWorld"
else
  SCRIPT_WORLD_NAME="${WORLD_NAME}"
fi

/usr/games/steamcmd +force_install_dir /valheim-server +login anonymous +app_update 896660 validate +exit
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/valheim-server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
export LD_LIBRARY_PATH=$templdpath

echo "Starting server PRESS CTRL-C to exit"

/valheim-server/valheim_server.x86_64 -name \"$SCRIPT_SERVER_NAME\" -port 2456 -world \"$SCRIPT_WORlD_NAME\" -savedir /valheim-server/save
