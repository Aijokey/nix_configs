{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./Athena/default.nix
  ];
  cyber.enable = true;
  cyber.roles = [
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
  # 1. FHS compatibility
  programs.nix-ld.enable = true;
  services.envfs.enable = true;

  networking.firewall.enable = true; # Ensure this line is present and set to true
  networking.firewall.allowedTCPPorts = [
    22 # SSH
    80 # HTTP
    443 # HTTPS
    4444 # Common reverse shell port
    8000 # Common web server port
    8080 # Common web server port
    9001 # Another common reverse shell port
    # Add any other specific ports you frequently use
  ];
  networking.firewall.allowedUDPPorts = [
    53 # DNS (if running a resolver)
    69 # TFTP (if needed)
    # Add any other specific UDP ports you use
  ];
}
