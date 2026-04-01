{
  inputs,
  config,
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    maple-mono.NF-CN
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    material-symbols

  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Satoshi" ];
      monospace = [ "Maple Mono NF CN" ];
    };
  };
}
