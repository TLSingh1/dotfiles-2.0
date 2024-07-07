{ pkgs }:
{
  pkgs.vimUtils.buildVimPlugin = {
    pname = "winbar";
    version = "unstable-2024-07-07";
    src = pkgs.fetchFromGitHub {
      owner = "";
      repo = "";
      rev = "";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
  };
}
