{ inputs, config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  boot.initrd.kernelModules = [ "hid_apple" ];
  
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
}

