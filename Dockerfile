FROM alpine:latest

ENV XDG_RUNTIME_DIR=/tmp \
    WLR_BACKENDS=headless \
    WLR_LIBINPUT_NO_DEVICES=1 \
    SWAYSOCK=/tmp/sway-ipc.sock
    
RUN apk update \
    && apk --no-cache --update add build-base
RUN apk add \
    e2fsprogs-extra \
    xkeyboard-config \
    libdrm \
    libseat-dev \
    libxcb-dev \
    mesa-dev \
    mesa-dri-gallium \
    mesa-dri-swrast \
    xcb-util-image-dev \
    xcb-util-wm-dev \
    pixman-dev \
    eudev \
    seatd \
    ttf-dejavu \
#   sway sway-doc \
    xwayland \
    dbus \
    foot \
    bemenu \
    dmenu \
    epiphany \
    swaylock \ 
    swaylockd \
    swaybg \
    swayidle \
    elogind \
    python3 \
    py3-pip \
    py3-numpy \
    docker \
    procps \
    bash \
    curl \
    py3-lz4

RUN apk update \
    elogind

RUN apk add \
    aml-dev \
    font-jetbrains-mono-nerd \
    font-noto \
    git \
    fzf \
    mako \
    nano \
    openssl \
    sudo \
    seatd-launch \
    socat \
    waybar \
    wayvnc \
    geany \
    nautilus \
    firefox

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    pciutils-libs
     
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    clipman \
    ossp-uuid
    
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    alacritty \
    grim \
    grimshot \
    slurp \
    wl-clipboard \
    font-noto-emoji

# Install our modified sway that extends per-container border colors and custom mouse cursors
RUN mkdir -p /etc/aither-tools && \
    curl -o /tmp/aither-tools.tar.gz -L "https://github.com/enoki-inc/aither-tools/archive/refs/tags/1.1.tar.gz" && \
    tar xf /tmp/aither-tools.tar.gz -C /etc/aither-tools --strip-components=1 && \
    mv /etc/aither-tools/Bibata-Cursors/* /usr/share/icons
 
RUN apk add --allow-untrusted \
    /etc/aither-tools/packages/sway-aither-1.7.1-r4.apk \
    /etc/aither-tools/packages/sway-aither-doc-1.7.1-r4.apk \
    /etc/aither-tools/packages/sway-aither-dbg-1.7.1-r4.apk \
    /etc/aither-tools/packages/sway-aither-wallpapers-1.7.1-r4.apk
    
RUN mkdir -p /etc/sway-launcher-desktop && \
    curl -o /tmp/sway-launcher-desktop.tar.gz -L "https://github.com/Biont/sway-launcher-desktop/archive/refs/tags/v1.6.0.tar.gz" && \
    tar xf /tmp/sway-launcher-desktop.tar.gz -C /etc/sway-launcher-desktop --strip-components=1

RUN apk add alpine-sdk bash libstdc++ libc6-compat && \
    apk add nodejs npm && \
    npm config set python python3 && \
    npm install --global code-server --unsafe-perm

RUN npm install --global minimist \
                         yauzl \
                         yazl \
                         @microsoft/1ds-core-js \
                         spdlog \
                         xterm-headless \
                         @parcel/watcher \
                         @vscode/ripgrep \
                         vscode-proxy-agent \
                         vscode-regexpp \
                         keytar
                         
ENV USER="dev"
RUN apk add -X https://dl-cdn.alpinelinux.org/alpine/v3.16/main -u alpine-keys --allow-untrusted
RUN adduser -D $USER && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
RUN echo "dev:dev" | chpasswd

RUN mkdir -p /etc/noVNC && \
    git clone https://github.com/enoki-inc/enoVNC.git && \
    mv /enoVNC/* /etc/noVNC && \
    git clone https://github.com/novnc/websockify.git /etc/noVNC/utils/websockify
    
COPY ./config /etc

EXPOSE 6080-6090
EXPOSE 8080

USER $USER
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
