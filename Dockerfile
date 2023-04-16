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
    xwayland \
    dbus \
    dbus-x11 \
    foot \
    dmenu \
    swaylock \
    swaybg \
    swayidle \
    python3 \
    python3-pip \
    python3-numpy \
    docker.io \
    procps \
    bash \
    curl \
    cargo \
    cmake \
    wget \
    libfreetype6-dev \
    libfontconfig1-dev \
    xorg-dev \
    pkg-config \
    fontconfig \
    unzip \
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
    nautilus \
    clipman \
    libossp-uuid16 \
    grim \
    grimshot \
    slurp \
    wl-clipboard \
    vim \
    golang \
    libcairo2-dev \
    libgtk-3-dev \
    libglib2.0-dev \
    libgtk-layer-shell-dev \
    meson \
    libgtkmm-3.0-dev \
    nomacs \
    gh

#Install pip packages
RUN pip install shell-gpt \
                awscli

# Install JetBrainsMono Fonts
RUN curl -LJO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip && \
    unzip JetBrainsMono.zip -d /etc/fonts && \
    mv /etc/fonts/*.ttf /usr/local/share/fonts/ && \
    fc-cache -f -v && \
    rm -rf JetBrainsMono.zip

# Install our custom mouse cursors
RUN mkdir -p /etc/aither-tools && \
    curl -o /tmp/aither-tools.tar.gz -L "https://github.com/enoki-inc/aither-tools/archive/refs/tags/1.1.tar.gz" && \
    tar xf /tmp/aither-tools.tar.gz -C /etc/aither-tools --strip-components=1 && \
    mv /etc/aither-tools/Bibata-Cursors/* /usr/share/icons && \
    rm -rf /tmp/aither-tools.tar.gz
    
# Install alacritty
RUN git clone https://github.com/alacritty/alacritty.git
RUN cd alacritty && \
    cargo build --release && \
    cp target/release/alacritty /usr/local/bin/ && \
    rm -rf /alacritty

# Install firefox
RUN apt-get install -y software-properties-common && apt-get update && add-apt-repository ppa:mozillateam/ppa -y && echo '\n\
Package: *\n\
Pin: release o=LP-PPA-mozillateam\n\
Pin-Priority: 1001\n\
\n\
Package: firefox\n\
Pin: version 1:1snap1-0ubuntu2\n\
Pin-Priority: -1\n\
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
RUN echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
RUN  apt install -y firefox firefox-geckodriver

# Install VSCode
RUN curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o vscode.deb && \
    dpkg -i vscode.deb && \
    rm -rf vscode.deb

# Install nwg-launcher
RUN git clone https://github.com/nwg-piotr/nwg-launchers.git && \
    cd nwg-launchers && \
    meson builddir -Dbuildtype=release && \
    ninja -C builddir && \
    ninja -C builddir install && \
    rm -rf /nwg-launchers

# Install nwg-dock
RUN git clone https://github.com/nwg-piotr/nwg-dock.git && \
    cd nwg-dock && \
    make get && \
    make build && \
    make install && \
    rm -rf /nwg-dock
    
# Create a user and give it passwordless sudo privileges
ENV USER="dev"
    
RUN adduser --disabled-password --gecos "" $USER && \
    adduser $USER sudo && \
    echo "dev:dev" | chpasswd

RUN mkdir -p /etc/noVNC && \
    git clone https://github.com/enoki-inc/enoVNC.git && \
    mv /enoVNC/* /etc/noVNC && \
    git clone https://github.com/novnc/websockify.git /etc/noVNC/utils/websockify
    
COPY ./config /etc
RUN mv -f /etc/code-url-handler.desktop /usr/share/applications/code-url-handler.desktop && \
    mv -f /etc/code.desktop /usr/share/applications/code.desktop
    
EXPOSE 6080-6090

USER $USER
RUN code --install-extension github.copilot

ENTRYPOINT ["/bin/sh", "-c", "set -o errexit; case \"$1\" in sh|bash) set -- \"$@\" ;; *) set -- sway ;; esac; exec \"$@\"", "--"]
