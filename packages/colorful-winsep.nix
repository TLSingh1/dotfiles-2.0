# packages/colorful-winsep.nix
{ lib, vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "colorful-winsep-nvim";
  version = "unstable-2024-07-06";
  src = fetchFromGitHub {
    owner = "nvim-zh";
    repo = "colorful-winsep.nvim";
    rev = "93a063e";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
  meta = with lib; {
    description = "A colorful window separator for Neovim";
    homepage = "https://github.com/nvim-zh/colorful-winsep.nvim";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
