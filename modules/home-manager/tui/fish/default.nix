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
      nn = "npm";
      pp = "pnpm";
      bb = "bun";
      tf = "terraform";
      zed = "env -u WAYLAND_DISPLAY zeditor";
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
      load_aws_secrets = ''
        for line in (cat ~/.secrets/okta_awscli.env | grep -v '^#')
          set item (string split -m 1 '=' $line)
          set -gx $item[1] $item[2]
        end
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
      set -gx ANTHROPIC_API_KEY (cat /run/secrets/claude)
      load_aws_secrets
    '';
    shellInit = "";
  };
}
