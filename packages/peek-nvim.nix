{
  pkgs,
  lib,
  inputs,
  ...
}:
pkgs.vimUtils.buildVimPlugin {
  pname = "peek-nvim";
  version = "0.1.0"; # Update this as needed
  src = inputs.peek-nvim;

  nativeBuildInputs = [pkgs.deno pkgs.makeWrapper];

  # Prevent Deno from accessing the network during build
  DENO_NO_UPDATE_CHECK = "1";
  DENO_DIR = "./.deno_dir";

  preBuildPhases = ["denoCachePhase"];

  denoCachePhase = ''
    export HOME=$TMPDIR
    mkdir -p $DENO_DIR
    deno cache --no-check scripts/build.js
  '';

  buildPhase = ''
    runHook preBuild
    deno run --allow-read --allow-write scripts/build.js
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/public
    cp -r public/* $out/public/
    cp -r lua $out/
    cp -r plugin $out/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Markdown preview plugin for Neovim";
    homepage = "https://github.com/toppair/peek.nvim";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
