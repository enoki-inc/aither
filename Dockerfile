FROM alpine:3.16 as swaybuilder
# RUN echo "Installing tailscale"
# RUN apk add --update tailscale
RUN echo "**** install build deps ****"
RUN apk add sway

# docker compose builder
FROM ghcr.io/linuxserver/docker-compose:amd64-alpine as composebuilder

# python builder
FROM python:3.10-slim as pythonbuilder
RUN pip install --no-cache-dir dotdrop

# runtime stage
FROM alpine:3.16

# copy build output
COPY --from=swaybuilder /usr/share/wayland-sessions/* /usr/local/
COPY --from=composebuilder /usr/local/bin/docker-compose /usr/local/bin/docker-compose
COPY --from=pythonbuilder /usr/local/lib/ /usr/local/lib/

#RUN echo "**** install base wayland programs ****"
#RUN apt-get update
RUN apk add --update waybar
RUN apk add --update wayvnc
RUN apk add --update wofi
RUN apk add --update fzf
RUN apk add --update nerd-fonts
RUN echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*


RUN echo "**** install install -yitional programs ****"
RUN apk add --update fish
RUN apk add --update ranger
RUN apk add --update   ripgrep
RUN apk add --update  zathura
RUN apk add --update xwayland
RUN apk add --update --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN apk add --update starship
RUN apk add --update git
#RUN apk add --update glow
RUN apk add --update --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN apk add --update  task
RUN apk add --update  neovim

RUN echo "**** install -ying ephemeral user ****"
RUN addgroup -S dev && \
    adduser -S dev -G dev -G abuild && \
    mkdir -p /home/vnc-user/.config/wayvnc/ && \
    cd /home/vnc-user/.config/wayvnc/

#RUN echo "**** cleanup and user perms ****" && \
#  echo "abc:abc" | chpasswd && \
#  usermod -s /bin/bash dev && \
#  echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel && \
# apt add user abc wheel && \
#  rm -rf \
#    /tmp/*
RUN echo "Installing VS code"
FROM node:16.0-alpine
RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk --no-cache add --update alpine-sdk bash libstdc++ libc6-compat \
    && npm config set python python3 
RUN npm install --global code-server --unsafe-perm
#RUN git clone --recursive https://github.com/cdr/code-server.git
#RUN cd code-server
#RUN yarn global add code-server

ENV PASSWORD=changeme
#ENTRYPOINT code-server --bind-addr 0:8443

ENV XDG_RUNTIME_DIR=/tmp \
    XDG_SESSION_TYPE=wayland \
    WLR_LIBINPUT_NO_DEVICES=10 \
    WLR_HEADLESS_OUTPUTS=11 \
    WLR_BACKENDS=headless \
    SWAYSOCK=/tmp/sway-ipc.sock \
    WAYLAND_DISPLAY=wayland-1 \
    WLR_RENDERER_ALLOW_SOFTWARE=1 \
    WLR_NO_HARDWARE_CURSORS=10 \
    WLR_BACKENDS=headless

# Expose ports for VNC
EXPOSE 5900
EXPOSE 5901
EXPOSE 5902
EXPOSE 5903
EXPOSE 5904
EXPOSE 5905
EXPOSE 5906
EXPOSE 5907
EXPOSE 5908
EXPOSE 5909

# Expose install -yitional ports
EXPOSE 8080

# # install -y volume
# VOLUME /<install -y volume path here>
