# virtualization/docker.nix - Docker configuration
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  virtualisation.docker.enable = true;
}
# ============================================================================

