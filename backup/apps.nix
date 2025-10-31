{
  config,
  pkgs,
  lib,
  packages,
  ...
}: {
  config,
  pkgs,
  lib,
  packages,
  ...
}: {
  config,
  pkgs,
  lib,
  packages,
  ...
}: {
  config,
  pkgs,
  lib,
  packages,
  ...
}: let
  # Import the Eden package from the local file
  eden = pkgs.callPackage ./apps/eden.nix {};
  xmcl = pkgs.callPackage ./apps/xmcl.nix {};
  vanilla = pkgs.callPackage ./apps/vanilla.nix {};
  slicer = pkgs.callPackage ./apps/slicer.nix {};
  #codelite = pkgs.callPackage ./apps/codelite.nix { };
in {
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  programs.firefox.enable = true;
  programs.java.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamemode.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    (import <nixos-unstable> {
      config = {allowUnfree = true;};
    }).kdePackages.dolphin
    (import <nixos-unstable> {
      config = {allowUnfree = true;};
    }).kdePackages.qtstyleplugin-kvantum
    (import <nixos-unstable> {
      config = {allowUnfree = true;};
    }).kdePackages.qt6ct
    podman
    qt5.qtbase
    qt5.qtx11extras
    bison
    flex
    ncurses
    pmbootstrap
    kitty
    neovim
    (import <nixos-unstable> {config = {allowUnfree = true;};}).superfile
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.qqc2-desktop-style
    libsForQt5.qt5.qtquickcontrols2
    qt6.qtdeclarative
    jdk
    jdk17
    jdk8
    proton-pass
    blockbench
    #codelite
    (import <nixos-unstable> {config = {allowUnfree = true;};}).blender
    (import <nixos-unstable> {
      config = {allowUnfree = true;};
    }).kdePackages.kdeconnect-kde
    (import <nixos-unstable> {
      config = {allowUnfree = true;};
    }).kdePackages.kdevelop
    ((import <nixos-unstable> {
      config = {allowUnfree = true;};
    }).prismlauncher.override {jdks = [pkgs.jre8];})
    libwebp
    qt5.qtimageformats # Adds WebP, TIFF, etc. support to Qt5
    qt6.qtimageformats
    vanilla
    imagemagick
    tclPackages.tclmagick
    wget
    realesrgan-ncnn-vulkan
    upscayl
    #eden
    gearlever
    appimage-run
    dolphin-emu
    mono
    clamtk
    networkmanager-openvpn
    cemu
    #networkmanager-openvpn-gnome
    innoextract
    unarc
    git
    gnome-tweaks
    mangohud
    protonup-qt
    telegram-desktop
    rar
    zip
    p7zip
    libreoffice-qt6-fresh
    kdePackages.ark
    qbittorrent
    kdePackages.kate
    lutris
    wineWowPackages.stable
    wine
    (wine.override {wineBuild = "wine64";})
    wine64
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
    nautilus-python
    polkit
    protontricks
    meson
    cmake
    glib
    glibc
    ninja
    pkg-config
    python312Packages.pygobject3
    mari0
    godot
    heroic
    libgcc
    gcc
    clang
    android-tools
    android-studio
    gtk4
    bc
    flex
    bison
    openssl
    libelf
    elfutils
    ncurses
    perl
    undollar
    gnumake
    alacarte
    opusfile
    tcp_wrappers
    cpu-x
    libunwind
    haguichi
    logmein-hamachi
    vlc
    lshw
    peazip
    lsof
    vulkan-tools
    gamescope
    pipx
    python313
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  virtualisation.docker = {enable = true;};

  users.users.aijokey.extraGroups = ["docker"];

  programs.gamescope.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
    stdenv.cc.cc
    openssl
    curl
    zlib
    zstd
    bzip2
    xz
    libxml2
    acl
    attr
    libssh
    libsodium
    util-linux
    systemd
    # X11 and graphics libraries for JavaFX:
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXcomposite
    xorg.libXtst
    xorg.libXfixes
    xorg.libXinerama
    xorg.libXrender
    xorg.libXxf86vm
    xorg.libxcb
    # Core GTK2 and rendering backends
    gtk2 # GTK 2.0 toolkit :contentReference[oaicite:7]{index=7}
    pango # Text layout (requires FreeType, X11) :contentReference[oaicite:8]{index=8}
    cairo # 2D vector graphics :contentReference[oaicite:9]{index=9}
    fontconfig # Font discovery
    freetype # FreeType font rasterizer
    atk # Accessibility toolkit :contentReference[oaicite:10]{index=10}
    gdk-pixbuf
  ];
}
