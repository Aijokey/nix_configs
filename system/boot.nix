# system/boot.nix - Boot configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages =
      (import <nixos-unstable> {
        config = {allowUnfree = true;};
      }).pkgs.linuxPackages_zen;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 2;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
# ============================================================================

