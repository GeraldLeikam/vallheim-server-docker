#!/bin/sh
/usr/games/steamcmd +login anonymous +force_install_dir /valheim-server +app_update 896660 validate +exit
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/valheim-server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

/valheim-server/valheim_server.x86_64 -name "Drezael's Test Server *** Do not join" -port 2456 -world "Test Server *** Do not join" -password "secret"

export LD_LIBRARY_PATH=$templdpath
