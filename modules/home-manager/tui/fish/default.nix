{
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
      oacw= "okta-aws-cli web";
    };
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
