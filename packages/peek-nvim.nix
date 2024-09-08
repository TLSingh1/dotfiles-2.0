{pkgs}:
pkgs.stdenv.mkDerivation {
  pname = "peek-nvim";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "toppair";
    repo = "peek.nvim";
    rev = "main";
    sha256 = "sha256-hGIPxHwTSXTHFJ3JiVATMjEmoFhZ87fWElj1AMPMbQU=";
  };

  buildInputs = [pkgs.deno];

  rewrite = ''
    sed -i 's/fetch(/fetchurl(/g' scripts/build.js
    sed -i 's/https:\/\/deno.land\/x\/emit@0.38.1\/mod.ts/$(fetchurl https:\/\/deno.land\/x\/emit@0.38.1\/mod.ts)/g' scripts/build.js
  '';

  buildPhase = ''
    deno task --quiet build:fast
  '';

  installPhase = ''
    mkdir -p $out/share/nvim/site/pack/packer/start/
    cp -r * $out/share/nvim/site/pack/packer/start/peek-nvim
  '';
}
