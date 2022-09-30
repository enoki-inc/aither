FROM alpine:3.16

# install main packages
RUN apk add eudev \
        openrc \
        dbus \
        wlroots \
        seatd \
        ttf-dejavu \
        sway \
        sway-doc \
        sudo

# install Intel & Nvidia drivers
RUN apk add mesa-dri-gallium \
        libva-intel-driver

# install optional dependencies
# RUN apk add \
#         xwayland \
#         foot \
#         bemenu \
#         swaylock swaylockd \
#         swaybg \
#         swayidle

# add new user
RUN adduser -D sway \
        && echo "sway ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sway \
        && chmod 0440 /etc/sudoers.d/sway

# add user to the input,audio and video groups
RUN adduser sway input \
        && adduser sway video \
        && adduser sway seat

RUN mkdir -p /run/openrc && touch /run/openrc/softlevel

# enable seatd and dbus daemon in boot-time
RUN rc-update add seatd && rc-update add dbus

USER sway
WORKDIR /home/sway

RUN mkdir -p /home/sway/tempdir && chmod 0700 /home/sway/tempdir

COPY start.sh .
RUN sudo chmod +x start.sh

ENTRYPOINT ./start.sh
