{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware.nix
    ./services.nix
    ./users.nix
    ./apps.nix
    ./kvm.nix
    #./customisation.nix
    ./athena.nix
  ];
  time.timeZone = "Europe/Kyiv";
  networking.networkmanager.enable = true;
  i18n.defaultLocale = "en_GB.UTF-8";
  system.stateVersion = "24.11";
  boot.kernelPackages = (import <nixos-unstable> {config = {allowUnfree = true;};}).pkgs.linuxPackages_zen;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct"; # or "qt6ct"
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
