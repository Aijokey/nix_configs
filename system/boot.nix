# system/boot.nix - Boot configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: let
  # Unstable channel packages
  pkgs-unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  boot = {
    kernelPackages = pkgs-unstable.linuxPackages_latest;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 2;
      };
      efi.canTouchEfiVariables = true;
    };
  };
  boot.kernel.sysctl = {"fs.file-max" = 50000;};
}
# ============================================================================

