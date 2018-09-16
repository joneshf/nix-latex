let

  buildInputs = [
    texlive
  ];

  fontconfig-file = nixpkgs.makeFontsConf {
    fontDirectories = [
      nixpkgs.lmodern
    ];
  };

  nixpkgs = import nixpkgs-tarball {};

  nixpkgs-revision = "120b013e0c082d58a5712cde0a7371ae8b25a601";

  nixpkgs-sha256 = "sha256:0hk4y2vkgm1qadpsm4b0q1vxq889jhxzjx3ragybrlwwg54mzp4f";

  nixpkgs-tarball = builtins.fetchTarball {
    sha256 = nixpkgs-sha256;
    url = "https://github.com/NixOS/nixpkgs/archive/${nixpkgs-revision}.tar.gz";
  };

  texlive = nixpkgs.texlive.combine {
    inherit (nixpkgs.texlive)
      fontspec
      scheme-basic
      xetex
    ;
  };

in

  nixpkgs.stdenv.mkDerivation {

    inherit buildInputs;

    buildPhase = ''
      xelatex -file-line-error foo.tex
    '';

    checkPhase = ''
      test -f foo.pdf
    '';

    doCheck = true;

    installPhase = ''
      mkdir -p $out
      cp foo.pdf $out
    '';

    name = "foo.pdf";

    src = ./.;

    FONTCONFIG_FILE = fontconfig-file;
  }
