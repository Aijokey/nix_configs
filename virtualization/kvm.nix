# virtualization/kvm.nix - KVM/QEMU virtualization
# ============================================================================
{
  config,
  pkgs,
  ...
}: {
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
# ============================================================================

