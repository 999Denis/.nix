{
  inputs,
  config,
  pkgs,
  ...
}:

{

  imports = [
    inputs.zen-browser.homeManagerModules.default
    inputs.evie.homeManagerModules.evie
    inputs.eviefetch.homeManagerModules.eviefetch

    ./Modules/Packages.nix
    ./Modules/Services.nix
    ./Modules/Shell.nix
    ./Modules/Variables.nix
    ./Modules/Hyprland.nix
    ./Modules/Sway.nix
    ./Modules/ZSH.nix
    ./Modules/Neovim.nix
    ./Modules/Foot.nix
    ./Modules/GTK.nix
  ];

  home.username = "denis";

  home.homeDirectory = "/home/denis";

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.05";
}
