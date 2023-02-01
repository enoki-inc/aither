FROM archlinux/base:latest

ENV XDG_RUNTIME_DIR=/tmp \
    WLR_BACKENDS=headless \
    WLR_LIBINPUT_NO_DEVICES=1 \
    SWAYSOCK=/tmp/sway-ipc.sock

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm --needed base-devel

RUN pacman -S --noconfirm \
    e2fsprogs \
    xkeyboard-config \
    libdrm \
    libxcb \
    mesa \
    pixman \
    udev \
    ttf-dejavu \
    sway sway-doc \
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
    python \
    python-pip \
    numpy \
    docker \
    procps-ng \
    bash \
    curl

RUN pacman -Syu --noconfirm elogind

RUN pacman -S --noconfirm \
    font-jetbrains-mono-nerd \
    noto-fonts \
    git \
    fzf \
    mako \
    nano \
    openssl \
    sudo \
    waybar \
    wayvnc \
    geany \
    nautilus \
    firefox

# Install our modified sway that extends per-container border colors and custom mouse cursors
RUN mkdir -p /etc/aither-tools && \
    curl -o /tmp/aither-tools.tar.gz -L "https://github.com/enoki-inc/aither-tools/archive/refs/tags/1.1.tar.gz" && \
    tar xf /tmp/aither-tools.tar.gz -C /etc/aither-tools --strip-components=1 && \
    mv /etc/aither-tools/Bibata-Cursors/* /usr/share/icons

RUN pacman -U --noconfirm \
    /etc/aither-tools/packages/sway-aither-1.7.1-r4.apk \
    /etc/aither-tools/packages/sway-aither-doc-1.7.1-r4.apk \
    /etc/aither-tools/packages/sway-aither-dbg-1.7.1-r4.apk \
    /etc/aither-tools/packages/sway-aither-wallpapers-1.7.1-r4.apk
    
RUN mkdir -p /etc/sway-launcher-desktop && \
    curl -o /tmp/sway-launcher-desktop.tar.gz -L "https://github.com/Biont/sway-launcher-desktop/archive/refs/tags/v1.6.0.tar.gz" && \
    tar xf /tmp/sway-launcher-desktop.tar.gz -C /etc/sway-launcher-desktop --strip-components=1
                         
ENV USER="dev"
RUN pacman -Syu
RUN useradd -m $USER && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER
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
