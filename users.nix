# users.nix - User configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  users.users.aijokey = {
    isNormalUser = true;
    description = "Aijokey";
    home = "/home/aijokey"; # Explicitly set home
    createHome = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "docker"
      "libvirtd"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}
# ============================================================================

