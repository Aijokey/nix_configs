# system/network.nix - Network configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
}
# ============================================================================

