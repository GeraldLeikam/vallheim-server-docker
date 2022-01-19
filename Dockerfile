FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg --add-architecture i386
RUN apt update && apt upgrade -y
RUN apt install -y -q wget unzip gcc-10-base:i386 libc6:i386 libcrypt1:i386 libgcc-s1:i386 libidn2-0:i386 libstdc++6:i386 \
libunistring2:i386 glibc-doc:i386 steam:i386 musl libc6 libc-bin libsdl2-2.0-0:i386 libsdl2-2.0-0 libsdl2-dev \
libsdl2-image-2.0-0 libsdl2-mixer-2.0-0 libsdl2-net-2.0-0 libsdl2-ttf-2.0-0
COPY ./apps/steamcmd/ /tmp/steamcmd
RUN cp -r /tmp/steamcmd/* / && rm -r /tmp/steamcmd
RUN /usr/games/steamcmd +force_install_dir /valheim-server/vanilla-server +login anonymous +app_update 896660 validate +exit
RUN mkdir -v /valheim-server/save /valheim-server/server /valheim-server/BepInEx

RUN wget -v https://valheim.thunderstore.io/package/download/denikson/BepInExPack_Valheim/5.4.1700/ -O /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip \
&& unzip /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip -d /tmp/BepInEx && cp -r /tmp/BepInEx/BepInExPack_Valheim/* /valheim-server/BepInEx \
&& rm /tmp/denikson-BepInExPack_Valheim-5.4.1700.zip && rm -r /tmp/BepInEx \

COPY ./scripts/startup.sh /run/startup.sh
RUN chmod +x /run/startup.sh
CMD /run/startup.sh