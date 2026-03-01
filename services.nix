# services.nix - System services configuration
# ============================================================================
{
  config,
  pkgs,
  lib,
  ...
}: let
  # Unstable channel packages
  pkgs-unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };
    excludePackages = [pkgs.xterm];
  };
  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
  environment.gnome.excludePackages = with pkgs; [
    gnome-software
    gnome-console
  ];

  # System services
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    flatpak.enable = true;
    printing.enable = true;
    openssh.enable = true;
    envfs.enable = true;
    logmein-hamachi.enable = true;
  };
  services.printing.drivers = [pkgs-unstable.cnijfilter2];

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.lact.enable = true;
  services.lact.package = pkgs-unstable.lact;
  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
# ============================================================================

