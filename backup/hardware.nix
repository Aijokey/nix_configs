{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = [
    "module_blacklist=nouveau"
    "nvidia-drm.modeset=1"
    "amdgpu.backlight=0"
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = ["nvidia"];
  #boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

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
  services.supergfxd.enable = true;

  systemd.services.supergfxd.path = [pkgs.pciutils];

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];

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
