{ pkgs, ...}:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.rose-pine = {
      enable = false;
    };
    # i like this one
    colorschemes.oxocarbon = {
      enable = false;
    };
    # i like this one
    colorschemes.onedark = {
      enable = true;
    };
    colorschemes.one = {
      enable = false;
    };
    colorschemes.nord = {
      enable = false;
    };
    colorschemes.nightfox = {
      enable = false;
    };
    colorschemes.modus = {
      enable = false;
    };
    colorschemes.melange = {
      enable = false;
    };
    colorschemes.kanagawa = {
      enable = false;
      settings.transparent = false;
    };
    colorschemes.gruvbox = {
      enable = false;
    };
    colorschemes.dracula = {
      enable = false;
    };
    colorschemes.catppuccin = {
      enable = false;
    };
    colorschemes.ayu = {
      enable = false;
    };
    colorschemes.tokyonight = {
      enable = false;
    };
    colorschemes.cyberdream = {
      enable = false;
      settings = {
        transparent = true;
        italic_comments = true;
        theme.highlights = {
          ActiveWindow.bg = "#16181A";
        };
      };
    };
    extraPlugins = with pkgs; [
      vimPlugins.neorg
      vimPlugins.neorg-telescope
      winbar
    ];
    extraLuaPackages = luaPkgs: with luaPkgs; [
      lua-utils-nvim
      nvim-nio
      pathlib-nvim
    ];
    extraConfigLuaPost = ''
      local luasnip = require("luasnip")

      luasnip.filetype_extend("javascript", {"html"})
      luasnip.filetype_extend("javascriptreact", {"html"})
      luasnip.filetype_extend("typescriptreact", {"html"})

      -- ls.snippets.javascript = ls.snippets.html
      require("luasnip/loaders/from_vscode").load({include = {"html"}})
      require("luasnip/loaders/from_vscode").lazy_load()

	    local signs = {
	    	{ name = "DiagnosticSignError", text = "" },
	    	{ name = "DiagnosticSignWarn", text = "" },
	    	{ name = "DiagnosticSignHint", text = "" },
	    	{ name = "DiagnosticSignInfo", text = "" },
	    }

	    for _, sign in ipairs(signs) do
	    	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	    end

	    local config = {
	    	virtual_text = true,
	    	virtual_lines = {
	    		only_current_line = true,
	    		highlight_whole_line = false,
	    	},
	    	signs = {
	    		active = signs,
	    	},
	    	update_in_insert = false,
	    	underline = true,
	    	severity_sort = true,
	    	float = {
	    		focusable = false,
	    		style = "minimal",
	    		border = "rounded",
	    		source = "always",
	    		header = "",
	    		prefix = "",
	    	},
	    }

	    vim.diagnostic.config(config)

	    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	    	border = "rounded",
	    	width = 60,
	    })

	    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	    	border = "rounded",
	    	width = 60,
	    })
      
      vim.diagnostic.open_float = (function(orig)
      	return function(opts)
      		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
      		local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
      		local max_severity = vim.diagnostic.severity.HINT
      		for _, d in ipairs(diagnostics) do
      			if d.severity < max_severity then
      				max_severity = d.severity
      			end
      		end
      		local border_color = ({
      			[vim.diagnostic.severity.HINT] = "DiagnosticInfo",
      			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      			[vim.diagnostic.severity.WARN] = "WarningMsg",
      			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
      		})[max_severity]
      		opts.border = {
      			{ "╭", border_color },
      			{ "─", border_color },
      			{ "╮", border_color },
      			{ "│", border_color },
      			{ "╯", border_color },
      			{ "─", border_color },
      			{ "╰", border_color },
      			{ "│", border_color },
      		}
      		orig(opts)
      	end
      end)(vim.diagnostic.open_float)

      require("neorg").setup {
	      load = {
	      	["core.defaults"] = {},
	      	["core.itero"] = {},
	      	["core.export.markdown"] = {},
	      	["core.keybinds"] = {
	      		config = {
	      			hook = function(keybinds)
	      				keybinds.unmap("norg", "n", "<LocalLeader>li")
	      				keybinds.remap_key("norg", "n", "<LocalLeader>lt", "<LocalLeader>nL")
	      			end,
	      		},
	      	},
	      	["core.concealer"] = {
	      		config = {
	      			icon_preset = "varied",
	      			icons = {
	      				code_block = {
	      					conceal = true,
	      					content_only = true,
	      					highlight = "CursorLine",
	      				},
	      			},
	      		},
	      	},
	      	["core.dirman"] = {
	      		config = {
	      			workspaces = {
                brain = "~/Brain",
                fleeting = "~/Brain/100 Fleeting Notes",
                literature = "~/Brain/200 Literature Notes",
                professional = "~/Brain/300 Professional",
                personal = "~/Brain/400 Personal",
                princeton = "~/Brain/500 Princeton",
                science = "~/Brain/600 Science",
                software = "~/Brain/700 Software Eng",
                technology = "~/Brain/800 Technology",
	      			},
	      			index = "index.norg",
	      		},
	      	},
	      	["core.esupports.metagen"] = {
	      		config = {
	      			type = "auto",
	      		},
	      	},
	      	["core.completion"] = {
	      		config = {
	      			engine = "nvim-cmp",
	      			name = "[Neorg]",
	      		},
	      	},
	      },
      }


      local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup { scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      require("winbar").setup({
        -- your configuration comes here, for example:
        icons = true,
        diagnostics = true,
        buf_modified = true,
        buf_modified_symbol = "M",
        -- or use an icon
        -- buf_modified_symbol = "●"
        dim_inactive = {
            enabled = false,
            highlight = "WinbarNC",
            icons = true, -- whether to dim the icons
            name = true, -- whether to dim the name
        }
      })

    '';
  };
}
