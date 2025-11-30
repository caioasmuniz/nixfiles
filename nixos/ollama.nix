{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    openFirewall = true;
    host = "0.0.0.0";
    environmentVariables = {
      GGML_CUDA_ENABLE_UNIFIED_MEMORY = "1";
    };
  };
}
