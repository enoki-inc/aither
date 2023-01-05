FROM ubuntu:latest

ENV XDG_RUNTIME_DIR=/tmp \
    WLR_BACKENDS=headless \
    WLR_LIBINPUT_NO_DEVICES=1 \
    SWAYSOCK=/tmp/sway-ipc.sock

# Update package lists and install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    e2fsprogs \
    x11-xkb-utils \
    libdrm-dev \
    libseat-dev \
    libxcb1-dev \
    mesa-common-dev \
    libpixman-1-dev \
    udev \
    seatd \
    fonts-dejavu \
    sway \
#    sway-desktop-documentation \
    xwayland \
    dbus \
    dbus-x11 \
    foot \
#    bemenu \
    dmenu \
    epiphany \
    swaylock \
    swaybg \
    swayidle \
#    elogind-dbg \
    python3 \
    python3-pip \
    python3-numpy \
    docker.io \
    procps \
    bash \
    curl \
    cargo

# Install elogind
#RUN apt-get update && apt-get install -y \
#    elogind

# Install additional packages
RUN apt-get install -y \
#    aml-dev \
    fonts-jetbrains-mono \
    fonts-noto \
    git \
    fzf \
    mako-notifier \
    nano \
    openssl \
    sudo \
    seatd \
    socat \
    waybar \
    wayvnc \
    geany \
    nautilus \
    firefox

# Install clipman, ossp-uuid, and glow from edge repositories
RUN apt-get install -y \
    clipman \
    libossp-uuid16
#    glow

# Install alacritty, grim, grimshot, slurp, wl-clipboard, and font-noto-emoji from community repositories
RUN apt-get install -y \
#    alacritty \
    grim \
    grimshot \
    slurp \
    wl-clipboard \
    fonts-noto-color-emoji

# Install our modified sway that extends per-container border colors and custom mouse cursors
RUN mkdir -p /etc/aither-tools && \
    curl -o /tmp/aither-tools.tar.gz -L "https://github.com/enoki-inc/aither-tools/archive/refs/tags/1.1.tar.gz" && \
    tar xf /tmp/aither-tools.tar.gz -C /etc/aither-tools --strip-components=1 && \
    mv /etc/aither-tools/Bibata-Cursors/* /usr/share/icons
     
RUN mkdir -p /etc/sway-launcher-desktop && \
    curl -o /tmp/sway-launcher-desktop.tar.gz -L "https://github.com/Biont/sway-launcher-desktop/archive/refs/tags/v1.6.0.tar.gz" && \
    tar xf /tmp/sway-launcher-desktop.tar.gz -C /etc/sway-launcher-desktop --strip-components=1

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    nodejs \
    npm

# Install code-server
RUN npm config set python python3
#RUN npm install --global code-server --unsafe-perm

# Install other npm packages
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
                         
# Create a user and give it passwordless sudo privileges
ENV USER="dev"
RUN adduser --disabled-password --gecos "" $USER && \
    adduser $USER sudo && \
    echo "dev:dev" | chpasswd

RUN mkdir -p /etc/noVNC && \
    git clone https://github.com/novnc/noVNC.git && \
    mv /noVNC/* /etc/noVNC && \
    git clone https://github.com/novnc/websockify.git /etc/noVNC/utils/websockify
    
COPY ./config /etc

EXPOSE 6080-6090
EXPOSE 8080

USER $USER
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
