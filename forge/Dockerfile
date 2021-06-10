FROM node:16-stretch

RUN apt-get update \
    && apt-get install -y sudo less \
    && rm -rf /var/lib/apt/lists/* \
    && usermod -aG sudo node \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    #Creating a few base folders that child dockers may need
    && mkdir -p /src && chown node /src \
    && mkdir -p /cloud && chown node /cloud \
    && mkdir -p /build && chown node /build \
    && npm install -g pnpm

USER node
RUN echo 'alias p="pnpm"' >> ~/.bashrc

WORKDIR /src

COPY --chown=1000 . /src
RUN pnpm install;

#Allow image to be used standalone without any commands:
CMD ["tail", "-f", "/dev/null"]
#CMD ["sleep", "inf"]
