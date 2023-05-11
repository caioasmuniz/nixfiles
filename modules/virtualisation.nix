{ pkgs, ... }: {
  virtualisation = {
    libvirtd.enable = true;
    vmVariant.virtualisation = {
      memorySize = 4096;
      cores = 4;
      qemu.options = [ "-vga qxl" "-device VGA,vgamem_mb=64"];
    };
  };
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
}
