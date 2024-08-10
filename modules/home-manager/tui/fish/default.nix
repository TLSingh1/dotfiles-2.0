{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nv = "nvim";
      ls = "eza -l";
      tree = "eza -T";
      history = "history | nvim -";
      cbonsai = "cbonsai -vlis 10000";
      swim = "asciiquarium -t -s";
      oac = "okta-aws-cli";
      oacw = "okta-aws-cli web";
      # k = "kubectl";
      ol = "ollama";
      cnv = "cd neovim && nv .";
    };
    functions = {
      yy = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
    plugins = [
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752f";
          hash = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
    ];
    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source
      zoxide init --cmd cd fish | source
      macchina
      set -x MANPAGER 'nvim +Man!'
    '';
    shellInit = "";
  };
}
# set -x BROWSER 'firefox-nightly'
# set -x XDG_BROWSER 'firefox-nightly'
# set -x MANGAL_READER_BROWSER 'firefox-nightly'
# set -x MANGAL_READER_READ_IN_BROWSER 'firefox-nightly'

