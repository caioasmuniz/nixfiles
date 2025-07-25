{ pkgs, config, ... }:
{
  boot.extraModulePackages = with config.boot.kernelPackages; [ ddcci-driver ];
  boot.kernelModules = [ "ddcci-backlight" ];
  services.udev.extraRules =
    let
      bash = "${pkgs.bash}/bin/bash";
      ddcciDev = "AUX USBC1/DDI TC1/PHY TC1";
      ddcciNode = "/sys/bus/i2c/devices/i2c-10/new_device";
    in
    ''
      SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'printf ddcci\ 0x37 > ${ddcciNode}'"
    '';

}
