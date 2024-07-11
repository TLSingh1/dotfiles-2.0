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

