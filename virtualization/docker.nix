# virtualization/docker.nix - Docker configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
    };
  };

  users.users.aijokey = {
    extraGroups = [
      "podman"
    ];
  };
}
# ============================================================================

