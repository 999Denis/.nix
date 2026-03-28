{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = "";

    shellAliases = {
      Rebuild = "sudo nixos-rebuild switch --flake ~/.nix#NixDesktop";
      Config = "nvim ~/.nix/System/Configuration.nix";
      Home = "nvim ~/.nix/Home/Home.nix";
      Packages = "nvim ~/.nix/Home/Modules/Packages.nix";
      Flake = "nvim ~/.nix/flake.nix";
      Clean = "sudo nix-collect-garbage -d";
      ls = "lsd";
    };
  };
}
