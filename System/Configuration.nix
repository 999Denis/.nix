{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.evie-greeter.nixosModules.evie-greeter
    inputs.home-manager.nixosModules.default
    inputs.nix-flatpak.nixosModules.nix-flatpak

    ./Drives.nix
    ./Modules/Audio.nix
    ./Modules/Boot.nix
    ./Modules/Brightness.nix
    ./Modules/Connectivity.nix
    ./Modules/Flatpak.nix
    ./Modules/Fonts.nix
    ./Modules/Locale.nix
    ./Modules/Mouse-Tweaks.nix
    ./Modules/Nvidia.nix
    ./Modules/Polkit.nix
    ./Modules/Greeter.nix
    ./Modules/Portal.nix
    ./Modules/Print.nix
    ./Modules/Touchpad.nix
    ./Modules/Steam.nix
    ./Modules/User.nix
    ./Modules/Xorg.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "denis" = import ../Home/Home.nix;
    };
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  networking.hostName = "NixDesktop";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
