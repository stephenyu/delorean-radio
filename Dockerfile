FROM jess/pulseaudio

USER root

RUN apt-get update && apt-get install mplayer -y

USER pulseaudio
