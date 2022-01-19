#!/bin/sh
DEBUG=false
DEFAULT_SERVER_NAME="Default Valheim Server"
DEFAULT_SERVER_PORT=2456
DEFAULT_WORLD_NAME="DefaultGeneratedWorld"
DEFAULT_SERVER_PASSWORD=secret
DEFAULT_SAVE_DIR=/valheim-server/save
DEFAULT_PUBLIC=1
DEFAULT_GAME_MODE=vanilla
if [ -n "${SERVER_NAME}" ]; then SERVER_NAME="${SERVER_NAME}"; else SERVER_NAME=${DEFAULT_SERVER_NAME}; fi
if [ -n "${SERVER_PORT}" ]; then SERVER_PORT=${SERVER_PORT}; else SERVER_PORT=${DEFAULT_SERVER_PORT} ; fi
if [ -n "${WORLD_NAME}" ]; then WORLD_NAME="${WORLD_NAME}"; else WORLD_NAME="${DEFAULT_WORLD_NAME}"; fi
if [ -n "${SERVER_PASSWORD}" ]; then SERVER_PASSWORD="${SERVER_PASSWORD}"; else SERVER_PASSWORD="${DEFAULT_SERVER_PASSWORD}"; fi
if [ -n "${GAME_MODE}" ]; then GAME_MODE="${GAME_MODE}"; else GAME_MODE=${DEFAULT_GAME_MODE}; fi

if [ -n "${PUBLIC}" ];
then
  if [ "$(echo $PUBLIC | tr A-Z a-z)" = "true" ];
  then
    PUBLIC=1
  elif [ "$(echo $PUBLIC | tr A-Z a-z)" = "false" ];
  then
    PUBLIC=0
  else
    PUBLIC=${DEFAULT_PUBLIC}
  fi
else
  PUBLIC=${DEFAULT_PUBLIC}
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
  echo "SERVER_NAME -> ${SERVER_NAME}"
  echo "SERVER_PORT -> ${SERVER_PORT}"
  echo "WORLD_NAME -> ${WORLD_NAME}"
  echo "SERVER_PASSWORD -> ${SERVER_PASSWORD}"
  echo "SAVE_DIR -> ${DEFAULT_SAVE_DIR}"
  echo "PUBLIC -> ${PUBLIC}"
  echo "AUTOUPDATE -> ${SCRIPT_AUTOUPDATE}"
  echo $ARGUMENT_STRING
fi

if [ $SCRIPT_AUTOUPDATE = "true" ];
then
  /usr/games/steamcmd +force_install_dir /valheim-server/server +login anonymous +app_update 896660 validate +exit
fi
if [ "${GAME_MODE}" = "vanilla" ];
then
  cp -rv /valheim-server/server-vanilla/* /valheim-server/server
  export templdpath=$LD_LIBRARY_PATH
  export LD_LIBRARY_PATH=/valheim-server/server/linux64:$LD_LIBRARY_PATH
  export SteamAppId=892970

  echo "Starting 'vanilla' server PRESS CTRL-C to exit"

  /valheim-server/server/valheim_server.x86_64 \
    -name "${SERVER_NAME}" \
    -port $SERVER_PORT \
    -world "${WORLD_NAME}" \
    -password "${SERVER_PASSWORD}" \
    -savedir $DEFAULT_SAVE_DIR \
    -public $PUBLIC
  export LD_LIBRARY_PATH=$templdpath
fi
while true
do
  echo "I am dead. Please kill me"
  sleep 30
done
