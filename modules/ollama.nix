{ pkgs, ... }:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      openFirewall = true;
      host = "0.0.0.0";
      acceleration = "cuda";
    };
  };
}
