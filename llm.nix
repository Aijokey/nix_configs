# packages/apps.nix - Application packages
# ============================================================================
{pkgs, ...}: let
  # Unstable channel packages
  pkgs-unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  # To edit use your text editor application, for example Nano
  services.ollama = {
    package = pkgs-unstable.ollama; # If you want to use the unstable channel package for example
    enable = true;
    acceleration = "cuda";
    #};
  };

  # The Ollama environment variables, as mentioned in the comments section
  systemd.services.ollama.serviceConfig = {
    Environment = ["OLLAMA_HOST=0.0.0.0:11434"];
  };

  # Add oterm to the systemPackages
  environment.systemPackages = with pkgs; [
    oterm
    pkgs-unstable.alpaca
  ];
}
