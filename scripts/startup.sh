#!/bin/bash
DEBUG=true
DEFAULT_SERVER_NAME="Default Valheim Server"
DEFAULT_SERVER_PORT=2456
DEFAULT_WORLD_NAME="DefaultGeneratedWorld"
DEFAULT_SERVER_PASSWORD=secret
DEFAULT_SAVE_DIR=/valheim-server/save
DEFAULT_PUBLIC=1
DEFAULT_GAME_MODE=vanilla




copyVanilla ()
{
  echo "Copy vanilla server files"
  cp -r /valheim-server/vanilla-server/* /valheim-server/server
}
copyBepInEx ()
{
  echo "Copy bepinex mode files"
  cp -r /valheim-server/BepInEx/* /valheim-server/server
}
copyBepInExFull ()
{
  echo "Copy bepinexfull mode files"
  mkdir /valheim-server/server/BepInEx/plugins/1F31A-BepInEx_Valheim_Full_Updater
  cp -r /valheim-server/BepInExFull/plugins/* /valheim-server/server/BepInEx/plugins/1F31A-BepInEx_Valheim_Full_Updater
}

install_mods ()
{
  echo "Installing mods"
  IFS=', ' read -r -a mods <<< $MODS
  for mod in $MODS
  do
    echo "installing mod -> ${mod}"
    IFS='/' read -r -a modarray <<< $mod
    filename="${modarray[${#modarray[@]} - 1]}"
    wget "${mod}" -O "/tmp/${filename}"
    unzip "/tmp/${filename}"
    #cp -r "/tmp/current_mod/plugins/*" "/valheim-server/server/BepInEx/plugins"
    #rm -r "/tmp/current_mod"
  done
}

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
  echo "GAME_MODE -> ${GAME_MODE}"
  echo "AUTOUPDATE -> ${SCRIPT_AUTOUPDATE}"
  echo $ARGUMENT_STRING
fi

if [ $SCRIPT_AUTOUPDATE = "true" ];
then
  /usr/games/steamcmd +force_install_dir /valheim-server/server +login anonymous +app_update 896660 validate +exit
fi
if [ "${GAME_MODE}" = "vanilla" ];
then
  echo "Starting 'vanilla' server PRESS CTRL-C to exit"
  copyVanilla
  export templdpath=$LD_LIBRARY_PATH
  export LD_LIBRARY_PATH=/valheim-server/server/linux64:$LD_LIBRARY_PATH
  export SteamAppId=892970
  /valheim-server/server/valheim_server.x86_64 \
    -name "${SERVER_NAME}" \
    -port $SERVER_PORT \
    -world "${WORLD_NAME}" \
    -password "${SERVER_PASSWORD}" \
    -savedir $DEFAULT_SAVE_DIR \
    -public $PUBLIC
  export LD_LIBRARY_PATH=$templdpath
elif [ "${GAME_MODE}" = "bepinex" ];
then
  echo "Starting 'bepinex' server PRESS CTRL-C to exit"
  copyVanilla
  copyBepInEx
  export DOORSTOP_ENABLE=TRUE
  export DOORSTOP_INVOKE_DLL_PATH=/valheim-server/server/BepInEx/core/BepInEx.Preloader.dll
  export DOORSTOP_CORLIB_OVERRIDE_PATH=/valheim-server/server/unstripped_corlib
  export LD_LIBRARY_PATH="/valheim-server/server/doorstop_libs:$LD_LIBRARY_PATH"
  export LD_PRELOAD="libdoorstop_x64.so:$LD_PRELOAD"
  export LD_LIBRARY_PATH="/valheim-server/server/linux64:$LD_LIBRARY_PATH"
  export SteamAppId=892970
  install_mods
  /valheim-server/server/valheim_server.x86_64 \
    -name "${SERVER_NAME}" \
    -port $SERVER_PORT \
    -world "${WORLD_NAME}" \
    -password "${SERVER_PASSWORD}" \
    -savedir $DEFAULT_SAVE_DIR \
    -public $PUBLIC
fi
while true
do
  echo "I am dead. Please kill me"
  sleep 30
done
