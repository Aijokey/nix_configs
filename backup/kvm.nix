{
  config,
  pkgs,
  ...
}: {
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = ["aijokey"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
