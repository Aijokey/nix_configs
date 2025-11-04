# hardware.nix - Hardware-specific configuration
# ============================================================================
{
  config,
  pkgs,
  lib,
  ...
}: let
  # Unstable channel packages
  pkgs-unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in {
  # Kernel parameters
  boot.kernelParams = [
    "module_blacklist=nouveau"
    "nvidia-drm.modeset=1"
    "amdgpu.backlight=0"
  ];

  boot.initrd.kernelModules = ["nvidia"];

  # NVIDIA configuration
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    dynamicBoost.enable = lib.mkForce true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia-container-toolkit.enable = true;

  # ASUS laptop services
  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [pkgs.pciutils];

  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # Graphics switching
  services.switcherooControl.enable = true;

  # Swap configuration
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];

  # Additional filesystem mount
  fileSystems."/mnt/D" = {
    device = "/dev/disk/by-uuid/29fc8a57-9ff9-47c6-b43c-793c79e9dfea";
    fsType = "ext4";
    options = [
      "rw"
      "users"
      "exec"
      "nofail"
      "x-systemd.automount"
      "x-gvfs-show"
    ];
  };
}
# ============================================================================

