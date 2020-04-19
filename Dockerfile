FROM jess/pulseaudio

USER root

RUN apt-get update && \
    apt-get install mplayer curl -y

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash

# Install Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install nodejs yarn -y && \
    rm -rf /var/lib/apt/lists/*

USER pulseaudio

COPY --chown=pulseaudio ./yarn.lock /app/
COPY --chown=pulseaudio ./package.json /app/
COPY --chown=pulseaudio ./tsconfig.json /app/
COPY --chown=pulseaudio ./src /app/src/

WORKDIR /app

RUN yarn install --prod

ENTRYPOINT ["yarn", "start"]
