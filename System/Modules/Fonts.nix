{
  inputs,
  config,
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    # Usiamo le virgolette per gestire il punto nel nome dell'attributo
    maple-mono.NF-CN
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # Il tuo font Satoshi dalla flake locale
    inputs.satoshi.packages.${pkgs.system}.default
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Satoshi" ];
      monospace = [ "Maple Mono NF CN" ];
    };
  };
}
