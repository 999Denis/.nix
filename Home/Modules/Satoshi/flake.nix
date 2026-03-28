{
  description = "Il mio archivio personale di font per NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux"; # Cambia in "aarch64-linux" se sei su ARM
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "satoshi";
        version = "1.0";
        src = ./share/fonts; # Punta alla cartella dove hai i .ttf/.otf

        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          mkdir -p $out/share/fonts/opentype
          find . -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;
          find . -name "*.otf" -exec cp {} $out/share/fonts/opentype/ \;
        '';
      };
    };
}
