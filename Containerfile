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

# Ham Radio software
RUN zypper -n in \
    7plus \
    HamFax \
    QtRadio \
    acfax \
    aldo \
    aprsd \
    as296-tty \
    atpdec \
    ax25-apps \
    ax25-tools \
    ax25spyd \
    axssh \
    axw3 \
    comedilib \
    conlogv \
    cqrlog \
    cwdaemon \
    cwstudio \
    demorse \
    digi_ned \
    direwolf \
    dream \
    dxc \
    flaa \
    flamp \
    flarq \
    flcluster \
    fldigi \
    fldigi-lang \
    fllog \
    flmsg \
    flnet \
    flrig \
    flwkey \
    flwrap \
    fpc \
    funcube-udev \
    ghpsdr3-alex \
    glfer \
    gmfsk \
    gnuradio \
    gpsman \
    gqrx \
    gr-funcube \
    gr-osmosdr \
    ham-fax \
    hamlib \
    ibp \
    js8call \
    jtdx \
    kamplus \
    klog \
    kptc \
    kvasd-installer \
    libasync1_6 \
    libax25 \
    libcodec2-1_1 \
    libcodec2-1_1-32bit \
    libcw6 \
    libecholib1_3 \
    libflxmlrpc1 \
    libgnuradio-3_10_2 \
    libgnuradio-funcube3_10_0 \
    libgnuradio-osmosdr0_2_0 \
    libhamlib++4 \
    libhamlib4 \
    libperseus-sdr-udev \
    libperseus-sdr0 \
    librtlsdr0 \
    libshp2 \
    libsoft66-1 \
    libspatialite7 \
    libuhd4_4_0 \
    libxforms2 \
    libzia-4_34 \
    linkt \
    lua-Hamliblua \
    minimuf \
    mod_spatialite \
    multimon \
    perl-Hamlib \
    perseus-sdr-tools \
    python-comedi \
    python-gr-osmosdr \
    python3-Hamlib \
    python3-gr-funcube \
    python3-uhd \
    python311-yattag \
    python39-yattag \
    qgrid \
    qrq \
    qsstv \
    qtel \
    rspfd \
    rtl-sdr \
    rtl-sdr-udev \
    shapelib \
    soft66 \
    soft66-udev \
    soundmodem \
    soundmodemconfig \
    splat \
    svxlink-server \
    tcl-Hamlib \
    tkconv \
    tlf \
    tnt \
    tnt-lang \
    tqsl \
    tucnak \
    uhd-firmware \
    uhd-udev \
    uhd-utils \
    unixcw \
    vlfrx-tools \
    wsjt \
    wsjtx \
    wspr \
    wxapt \
    xastir \
    xdemorse \
    xdx \
    xfhell \
    xforms \
    xlog \
    xoscope \
    xsmc-calc \
    xwxapt \
    yagiuda \
    yfklog \
    z8530drv-utils

# Cleanup
RUN zypper -n clean && \
    rm -rf /tmp/*
