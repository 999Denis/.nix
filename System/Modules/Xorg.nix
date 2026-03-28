{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  
  services.xserver.displayManager.lightdm.enable = false;

  services.xserver.xkb = {
    layout = "it";
    variant = "us";
  };
}
