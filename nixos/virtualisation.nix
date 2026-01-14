{ pkgs, user, ... }:
{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];

    };
    vmVariant.virtualisation = {
      memorySize = 4096;
      cores = 4;
      qemu.options = [
        "-vga qxl"
        "-device VGA,vgamem_mb=64"
      ];
    };
  };
  users.groups.libvirtd.members = [ user ];
  programs.virt-manager.enable = true;
}
