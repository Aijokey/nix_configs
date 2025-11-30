# configuration.nix - Main system configuration
# ============================================================================
{pkgs, ...}: {
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./hardware.nix

    # System modules
    ./system/boot.nix
    ./system/locale.nix
    ./system/network.nix

    # Services
    ./services.nix

    # User configuration
    ./users.nix

    # Applications and packages
    ./apps.nix

    # Virtualization
    ./virtualization/kvm.nix
    ./virtualization/docker.nix

    # Security & Pentesting
    ./athena.nix

    # Customization (currently disabled)
    ./customisation.nix
    ./llm.nix
  ];

  system.stateVersion = "24.11";
  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  nixpkgs.config = {
    allowUnfree = true;
    segger-jlink.acceptLicense = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
# ============================================================================

