#!/bin/sh
if [[ -z "${SERVER_NAME}" ]]; then
  SERVER_NAME="My Default Valheim Server. Please rename me."
else
  SERVER_NAME="${SERVER_NAME}"
fi

if [[ -z "${WORLD_NAME}" ]]; then
  WOLRD_NAME="DefaultGeneratedWorld"
else
  WORLD_NAME="${SERVER_NAME}"
fi

/usr/games/steamcmd +login anonymous +force_install_dir /valheim-server +app_update 896660 validate +exit
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/valheim-server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

/valheim-server/valheim_server.x86_64 -name $SERVER_NAME -port 2456 -world $WOLRD_NAME

export LD_LIBRARY_PATH=$templdpath
