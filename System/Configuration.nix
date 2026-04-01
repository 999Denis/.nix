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
    ./Modules/Satoshi
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

  # Support for shared system libraries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      util-linux
      libatomic_ops
      fontconfig
      freetype
      stdenv.cc.cc
      glib
      nspr
      nss
      dbus
      atk
      at-spi2-atk
      cups
      libX11
      libXcomposite
      libXdamage
      libXext
      libXfixes
      libXrandr
      mesa
      libgbm
      expat
      libxcb
      libxkbcommon
      cairo
      pango
      systemd
      alsa-lib
      at-spi2-core
      vulkan-loader
      vulkan-validation-layers
      nvidia-vaapi-driver
      libGL
      curl
      openssl
      libwebsockets
      cacert
    ];
  };

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

  nix.settings.trusted-users = [ "denis" ];
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  networking.hostName = "NixDesktop";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
