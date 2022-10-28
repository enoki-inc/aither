FROM alpine:latest

ENV XDG_RUNTIME_DIR=/tmp \
    WLR_BACKENDS=headless \
    WLR_LIBINPUT_NO_DEVICES=1 \
    SWAYSOCK=/tmp/sway-ipc.sock

# Install our modified sway that extends per-container border colors
COPY ./x86_64 /etc/packages/
RUN apk add --allow-untrusted \
    /etc/packages/sway-aither-1.7.1-r4.apk \
    /etc/packages/sway-aither-doc-1.7.1-r4.apk \
    /etc/packages/sway-aither-dbg-1.7.1-r4.apk \
    /etc/packages/sway-aither-wallpapers-1.7.1-r4.apk

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
    docker \
    bash \
    curl 

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
    geany

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    clipman \
    ossp-uuid
    
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    alacritty \
    grim \
    grimshot \
    slurp \
    wl-clipboard 

RUN mkdir -p /etc/sway-launcher-desktop && \
    curl -o /tmp/sway-launcher-desktop.tar.gz -L "https://github.com/Biont/sway-launcher-desktop/archive/refs/tags/v1.6.0.tar.gz" && \
    tar xf /tmp/sway-launcher-desktop.tar.gz -C /etc/sway-launcher-desktop --strip-components=1
    
ENV USER="dev"
RUN apk add -X https://dl-cdn.alpinelinux.org/alpine/v3.16/main -u alpine-keys --allow-untrusted
RUN adduser -D $USER && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
RUN echo "dev:dev" | chpasswd

COPY ./config/sway/config /etc/sway/config
COPY ./config/waybar /etc/waybar
COPY ./config/wayvnc/config /etc/wayvnc/config

EXPOSE 5900-5910

USER $USER
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
