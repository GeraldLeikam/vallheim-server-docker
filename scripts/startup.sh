#!/bin/sh
DEBUG=true
DEFAULT_SERVER_NAME="Default Valheim Server"
DEFAULT_SERVER_PORT=2456
DEFAULT_WORLD_NAME="DefaultGeneratedWorld"
DEFAULT_SERVER_PASSWORD=secret
DEFAULT_SAVE_DIR=/valheim-server/save
DEFAULT_PUBLIC=1
ARGUMENT_STRING=""
if [ -n "${SERVER_NAME}" ]; then ARGUMENT_STRING="${ARGUMENT_STRING}-name \"${SERVER_NAME}\" "; else ARGUMENT_STRING="${ARGUMENT_STRING}-name \"${DEFAULT_SERVER_NAME}\" "; fi
if [ -n "${SERVER_PORT}" ]; then ARGUMENT_STRING="${ARGUMENT_STRING}-port ${SERVER_PORT} "; else ARGUMENT_STRING="${ARGUMENT_STRING}-port ${DEFAULT_SERVER_PORT} "; fi
if [ -n "${WORLD_NAME}" ]; then ARGUMENT_STRING="${ARGUMENT_STRING}-world \"${WORLD_NAME}\" "; else ARGUMENT_STRING="${ARGUMENT_STRING}-world \"${DEFAULT_WORLD_NAME}\" "; fi
#if [ -n "${SERVER_PASSWORD}" ]; then ARGUMENT_STRING="${ARGUMENT_STRING}-password ${SERVER_PASSWORD} "; else ARGUMENT_STRING="${ARGUMENT_STRING}-password \"secret\" "; fi
ARGUMENT_STRING="${ARGUMENT_STRING}-savedir ${DEFAULT_SAVE_DIR} "

if [ -n "${PUBLIC}" ];
then
  if [ "$(echo $PUBLIC | tr A-Z a-z)" = "true" ];
  then
    ARGUMENT_STRING="${ARGUMENT_STRING}-public 1 "
  elif [ "$(echo $PUBLIC | tr A-Z a-z)" = "false" ];
  then
    ARGUMENT_STRING="${ARGUMENT_STRING}-public 0 "
  else
    ARGUMENT_STRING="${ARGUMENT_STRING}-public ${DEFAULT_PUBLIC} "
  fi
else
  ARGUMENT_STRING="${ARGUMENT_STRING}-public ${DEFAULT_PUBLIC} "
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

ARGUMENT_STRING="${ARGUMENT_STRING}-password mysecret "

if [ $DEBUG = "true" ];
then
  echo "AUTOUPDATE -> ${SCRIPT_AUTOUPDATE}"
  echo $ARGUMENT_STRING
fi

if [ $SCRIPT_AUTOUPDATE = "true" ];
then
  /usr/games/steamcmd +force_install_dir /valheim-server/server +login anonymous +app_update 896660 validate +exit
fi

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/valheim-server/server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

/valheim-server/server/valheim_server.x86_64 "${ARGUMENT_STRING}"
export LD_LIBRARY_PATH=$templdpath

while true
do
  echo "I am dead. Please kill me"
  sleep 30
done
