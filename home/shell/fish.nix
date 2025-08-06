{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      ripgrep
    ];
    sessionVariables = {
      EDITOR = "micro";
    };
  };
  programs = {
    eza = {
      enable = true;
      icons = "auto";
      git = true;
      extraOptions = [
        "--color=always"
        "--group-directories-first"
        "--header"
      ];
    };
    bat = {
      enable = true;
      config = {
        theme = "base16";
      };
      extraPackages = with pkgs.bat-extras; [
        prettybat
        batman
      ];
    };
    btop = {
      enable = true;
      settings = {
        proc_gradient = false;
        theme_background = false;
        color_theme = "TTY";
        truecolor = true;
        update_ms = 1000;
      };
    };
    micro = {
      enable = true;
      settings = {
        autosu = true;
        clipboard = "external";
        mkparents = true;
        saveundo = true;
        colorscheme = "simple";
      };
    };
    direnv.enable = true;
    fzf.enable = true;
    fd.enable = true;
    broot.enable = true;
    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "fifc";
          src = pkgs.fishPlugins.fifc.src;
        }
      ];
      interactiveShellInit = ''
        set fish_greeting 
        ${lib.getExe pkgs.fastfetch}'';
      shellAliases = {
        update = "nh os switch ~/Documents/nixfiles";
        update-flake = "nh os switch --update ~/Documents/nixfiles";
        update-remote = "nh os switch github:caioasmuniz/nixfiles";
        ls = "eza";
        cat = "bat";
      };
    };
  };
}
