#!/bin/sh
DEBUG=true
SCRIPT_SERVER_NAME="${SERVER_NAME:-'Default Valheim Server'}"
SCRIPT_WORlD_NAME="${WORLD_NAME:-'DefaultValheimWorld'}"

if [ -n "${PUBLIC}" ];
then
  if [ "$(echo $PUBLIC | tr A-Z a-z)" = "true" ];
  then
    SCRIPT_PUBLIC=1
  elif [ "$(echo $PUBLIC | tr A-Z a-z)" = "false" ];
  then
    SCRIPT_PUBLIC=0
  else
    SCRIPT_PUBLIC=1
  fi
else
  SCRIPT_PUBLIC=1
fi

if [ -n "${AUTOUPDATE}" ];
then
  if [ "$(echo $AUTOUPDATE | tr A-Z a-z)" = "true" ];
  then
    SCRIPT_AUTOUPDATE="true"
  elif [ "$(echo $AUTOUPDATE | tr A-Z a-z)" = "false" ];
  then
    SCRIPT_AUTOUPDATE="false"
  else
    SCRIPT_AUTOUPDATE="false"
  fi
else
  SCRIPT_AUTOUPDATE="false"
fi

if [ $DEBUG = "true" ];
then
  echo $SCRIPT_SERVER_NAME
  echo $SCRIPT_WORlD_NAME
  echo $SCRIPT_PUBLIC
  echo $SCRIPT_AUTOUPDATE
fi

if [ $SCRIPT_AUTOUPDATE = "true" ];
then
  /usr/games/steamcmd +force_install_dir /valheim-server/server +login anonymous +app_update 896660 validate +exit
fi

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/valheim-server/server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

ARGUMENTS_STRING="-name ${SCRIPT_SERVER_NAME}"
echo ARGUMENTS_STRING

/valheim-server/server/valheim_server.x86_64 -name "${SCRIPT_SERVER_NAME}" -port 2456 -world "${SCRIPT_WORlD_NAME}" -password "secret" -savedir /valheim-server/save -public $SCRIPT_PUBLIC
export LD_LIBRARY_PATH=$templdpath

while true
do
  sleep 1
done
