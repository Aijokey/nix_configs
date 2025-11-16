# virtualization/docker.nix - Docker configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  virtualisation.docker.enable = true;
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  users.users.aijokey = {
    extraGroups = [
      "podman"
    ];
  };
}
# ============================================================================

