{
  inputs,
  config,
  pkgs,
  ...
}:

{

  networking = {
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [ "10.0.0.4" ];
      FallbackDNS = [ "1.1.1.1" ];
      DNSSEC = false;
    };
  };

  services.blueman.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {

      General = {
        Experimental = true;
        FastConnectable = true;
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };
}
