FROM archlinux:latest

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
#    sway \
#    sway-doc \
    xorg-xwayland \
    dbus \
    foot \
    bemenu \
    dmenu \
    epiphany \
    swaylock \
    swaybg \
    swayidle \
#    elogind \
    python \
    python-pip \
    python-numpy \
    docker \
    procps-ng \
    bash \
    curl

#RUN pacman -Syu --noconfirm elogind

RUN pacman -S --noconfirm \
    ttf-jetbrains-mono-nerd \
    noto-fonts \
    git \
    fzf \
    mako \
    nano \
    openssl \
    sudo \
    waybar \
#    wayvnc \
    geany \
    nautilus \
    firefox \
    alacritty

# Install our modified sway that extends per-container border colors and custom mouse cursors
RUN mkdir -p /etc/aither-tools && \
    curl -o /tmp/aither-tools.tar.gz -L "https://github.com/enoki-inc/aither-tools/archive/refs/tags/1.1.tar.gz" && \
    tar xf /tmp/aither-tools.tar.gz -C /etc/aither-tools --strip-components=1 && \
    mv /etc/aither-tools/Bibata-Cursors/* /usr/share/icons
  
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

RUN git clone https://aur.archlinux.org/yay.git /tmp/yay && \
    cd /tmp/yay && \
    makepkg -si --noconfirm && \
    cd / && \
    rm -rf /tmp/yay
    
RUN yay -Sy --noconfirm \
    swayfx \
    wayvnc-git

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
