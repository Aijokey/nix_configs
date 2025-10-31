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

  services.open-webui = {
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
  };

  # Add oterm to the systemPackages
  environment.systemPackages = with pkgs; [
    oterm
    alpaca
  ];
}
