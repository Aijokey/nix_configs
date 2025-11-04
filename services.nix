# services.nix - System services configuration
# ============================================================================
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Desktop environment
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
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
    flatpak.enable = true;
    printing.enable = true;
    openssh.enable = true;
    envfs.enable = true;
    logmein-hamachi.enable = true;
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
# ============================================================================

