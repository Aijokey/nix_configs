# packages/apps.nix - Application packages
# ============================================================================
{pkgs, ...}: let
  # Unstable channel packages
  pkgs-unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  # ============================================================================
  # PROGRAMS & SERVICES
  # ============================================================================
  programs = {
    firefox.enable = true;
    java.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };
    gamemode.enable = true;
    gamescope.enable = true;
    nix-ld.enable = true;
    gnome-terminal.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };

    # Dynamic linker libraries for compatibility
    nix-ld.libraries = with pkgs; [
      # Core system libraries
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
      pipewire

      # X11 libraries (for JavaFX and GUI apps)
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

      # GTK2 and rendering
      gtk2
      pango
      cairo
      fontconfig
      freetype
      atk
      gdk-pixbuf
    ];
  };

  # ============================================================================
  # SYSTEM PACKAGES
  # ============================================================================

  environment.systemPackages = with pkgs;
    [
      # ------------------------------------------------------------------------
      # DESKTOP ENVIRONMENT & UI
      # ------------------------------------------------------------------------
      alacarte
      gnome-tweaks

      # ------------------------------------------------------------------------
      # DEVELOPMENT TOOLS
      # ------------------------------------------------------------------------

      # IDEs & Editors
      neovim
      android-studio
      nixd
      alejandra
      #codelite

      # Build tools
      bison
      flex
      meson
      cmake
      ninja
      gnumake
      pkg-config
      direnv

      # Compilers & toolchains
      gcc
      libgcc
      clang
      mono

      # Java versions
      jdk
      jdk17
      jdk8

      # Android tools
      android-tools
      pmbootstrap

      # Version control
      git

      # Libraries & frameworks
      glib
      glibc
      gtk4
      ncurses
      openssl
      libelf
      elfutils
      perl
      libunwind
      libpeas
      python3Packages.pygobject3
      gobject-introspection

      # Utilities
      bc
      undollar
      lsof
      unzip
      rPackages.pkgconfig

      # ------------------------------------------------------------------------
      # GAMING
      # ------------------------------------------------------------------------

      # Game launchers & platforms
      lutris
      heroic

      # Emulators
      dolphin-emu
      cemu
      mari0

      # Game engines
      godot
      blockbench

      # Gaming utilities
      mangohud
      protonup-qt
      protontricks
      gamescope

      # Wine
      wine
      wine64
      wineWowPackages.stable
      wineWowPackages.staging
      wineWowPackages.waylandFull
      (wine.override {wineBuild = "wine64";})
      winetricks

      # ------------------------------------------------------------------------
      # GRAPHICS & 3D
      # ------------------------------------------------------------------------
      imagemagick
      tclPackages.tclmagick
      libwebp
      realesrgan-ncnn-vulkan
      upscayl

      # ------------------------------------------------------------------------
      # MULTIMEDIA
      # ------------------------------------------------------------------------
      vlc
      opusfile

      # ------------------------------------------------------------------------
      # NETWORKING
      # ------------------------------------------------------------------------
      networkmanager-openvpn
      #networkmanager-openvpn-gnome
      haguichi
      logmein-hamachi
      tcp_wrappers

      # ------------------------------------------------------------------------
      # PRODUCTIVITY
      # ------------------------------------------------------------------------
      libreoffice-qt6-fresh
      proton-pass
      telegram-desktop

      # ------------------------------------------------------------------------
      # FILE MANAGEMENT & ARCHIVES
      # ------------------------------------------------------------------------
      wget
      nautilus-python
      peazip
      rar
      zip
      p7zip
      innoextract
      unarc
      qbittorrent
      nh

      # ------------------------------------------------------------------------
      # SYSTEM UTILITIES
      # ------------------------------------------------------------------------
      podman
      appimage-run
      clamtk
      polkit
      cpu-x
      lshw
      vulkan-tools
      pipx
      python313
      python313Packages.pip
      bitwarden-desktop
      keyguard

      # ------------------------------------------------------------------------
      # QT/KDE LIBRARIES
      # ------------------------------------------------------------------------
      qt5.qtbase
      kdePackages.full
      qt5.qtx11extras
      qt5.qtimageformats
      qt6.qtdeclarative
      qt6.qtimageformats
      libsForQt5.qt5.qtquickcontrols2
      kdePackages.kirigami
      kdePackages.kirigami-addons
      kdePackages.qqc2-desktop-style
      kdePackages.ark
      kdePackages.systemsettings
      kdePackages.kiconthemes
      kdePackages.konsole
    ]
    ++ (with pkgs-unstable; [
      # ------------------------------------------------------------------------
      # UNSTABLE PACKAGES
      # ------------------------------------------------------------------------
      nixfmt-classic
      nix-init
      nil
      gnome-builder
      python3Packages.pygobject3
      gtksourceview5
      pipewire
      alpaca
      adw-gtk3

      # KDE Packages
      kdePackages.kde-cli-tools
      kdePackages.filelight
      krita
      papirus-icon-theme
      (symlinkJoin {
        name = "kdevelop-complete";
        paths = [
          kdePackages.kdevelop
          kdePackages.kate
        ];
      })
      qt6.qtdoc
      # Applications
      blender
      superfile
      (prismlauncher.override {jdks = [pkgs.jre8];})
    ]);
}
