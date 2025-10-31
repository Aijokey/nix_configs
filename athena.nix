# athena.nix - Athena OS security tools
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./Athena/default.nix
  ];

  cyber = {
    enable = true;
    roles = [
      "blue"
      "bugbounty"
      "cracker"
      "dos"
      "forensic"
      "malware"
      "mobile"
      "network"
      "osint"
      "red"
      "student"
      "web"
    ];
  };

  # FHS compatibility
  programs.nix-ld.enable = true;
  services.envfs.enable = true;

  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
      80 # HTTP
      443 # HTTPS
      4444 # Common reverse shell port
      8000 # Common web server port
      8080 # Common web server port
      9001 # Another common reverse shell port
    ];
    allowedUDPPorts = [
      53 # DNS (if running a resolver)
      69 # TFTP (if needed)
    ];
  };
}
# ============================================================================

