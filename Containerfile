FROM opensuse/tumbleweed

# Zypper Initialization
RUN zypper --gpg-auto-import-keys ar -cfp 90 https://ftp.fau.de/packman/suse/openSUSE_Tumbleweed/ packman && \
    zypper --gpg-auto-import-keys ar -f http://download.opensuse.org/repositories/hamradio/openSUSE_Tumbleweed/ hamradio && \
    zypper --gpg-auto-import-keys ref && \
    zypper -n dup --from packman --allow-vendor-change && \
    zypper -n in \
        desktop-file-utils \
        git \
        opi \
        wget

# Distrobox Integration
WORKDIR /tmp
RUN wget https://download.copr.fedorainfracloud.org/results/eyecantcu/distrobox-utils/opensuse-tumbleweed-x86_64/05991983-xdg-utils-distrobox/xdg-utils-distrobox-1.1.3-13.suse.tw.noarch.rpm && \
    rpm -i ./xdg-utils-distrobox-1.1.3-13.suse.tw.noarch.rpm
RUN git clone https://github.com/89luca89/distrobox.git --single-branch && \
    cp distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/flatpak && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/firefox && \
    wget https://github.com/1player/host-spawn/releases/download/$(cat distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O distrobox/host-spawn && \
    cp distrobox/host-spawn /usr/bin/host-spawn && \
    chmod +x /usr/bin/host-spawn && \
    rm -drf distrobox
WORKDIR /

# Install needed packages
RUN zypper -n in  \
    libvulkan_radeon \
    intel-media-driver \
    pipewire \
    pipewire-pulseaudio \
    pipewire-alsa \
    pipewire-aptx

# Cleanup
RUN zypper -n clean && \
    rm -rf /tmp/*
