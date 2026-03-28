{ pkgs, ... }:

let
  satoshi-fonts = pkgs.stdenv.mkDerivation {
    pname = "satoshi-fonts";
    version = "1.0";
    src = ./fonts;

    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      mkdir -p $out/share/fonts/opentype

      find . -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;
      find . -name "*.otf" -exec cp {} $out/share/fonts/opentype/ \;
    '';

  };
in
{
  fonts.packages = [ satoshi-fonts ];
}
