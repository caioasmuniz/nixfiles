{ ... }:
{
  services = {
    ollama = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      acceleration = "cuda";
    };
    open-webui = {
      enable = true;
      host = "0.0.0.0";
      openFirewall = true;
    };
  };
}
