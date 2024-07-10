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
    colorschemes.onedark = {
      enable = false;
    };
    colorschemes.cyberdream = {
      enable = true;
      settings = {
        transparent = true;
        italic_comments = true;
        theme.highlights = {
          ActiveWindow.bg = "#16181A";
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      neorg
      neorg-telescope
      winbar-nvim
      colorful-winsep
      # incline
      nvim-web-devicons
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

      -- require("winbar").setup({
      --   icons = true,
      --   diagnostics = true,
      --   buf_modified = true,
      --   buf_modified_symbol = "M",
      --   dim_inactive = {
      --     enabled = false,
      --     highlight = "WinbarNC",
      --     icons = true,
      --     name = true,
      --   }
      -- })

      require("colorful-winsep").setup({
        -- highlight for Window separator
        hi = {
          bg = "#161616",
          fg = "#161616",
        },
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
        -- #70: https://github.com/nvim-zh/colorful-winsep.nvim/discussions/70
        only_line_seq = true,
        -- Smooth moving switch
        smooth = true,
        exponential_smoothing = true,
        anchor = {
          left = { height = 1, x = -1, y = -1 },
          right = { height = 1, x = -1, y = 0 },
          up = { width = 0, x = -1, y = 0 },
          bottom = { width = 0, x = 1, y = 0 },
       },
       light_pollution = function(lines) end,
      })

      local devicons = require("nvim-web-devicons")

      devicons.setup {
        color_icons = true;
        default = true;
        strict = true;
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
          }
        };
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
          }
        };
      } 


      -- require("incline").setup {
      --   render = function(props)
      --     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      --     if filename == "" then
      --       filename = "[No Name]"
      --     end
      --     local ft_icon, ft_color = devicons.get_icon_color(filename)

      --     local function get_git_diff()
      --       local icons = { removed = "", changed = "", added = "" }
      --       local signs = vim.b[props.buf].gitsigns_status_dict
      --       local labels = {}
      --       if signs == nil then
      --         return labels
      --       end
      --       for name, icon in pairs(icons) do
      --         if tonumber(signs[name]) and signs[name] > 0 then
      --           table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
      --         end
      --       end
      --       if #labels > 0 then
      --         table.insert(labels, { "┊ " })
      --       end
      --       return labels
      --     end

      --     local function get_diagnostic_label()
      --       local icons = { error = "", warn = "", info = "", hint = "" }
      --       local label = {}

      --       for severity, icon in pairs(icons) do
      --         local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
      --         if n > 0 then
      --           table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
      --         end
      --       end
      --       if #label > 0 then
      --         table.insert(labels, { "┊ " })
      --       end
      --       return label
      --     end

      --     return {
      --       { get_diagnostic_label() },
      --       { get_git_diff() },
      --       { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
      --       { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
      --       { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
      --     }
      --   end,
      -- }

      local lualine = require("lualine")

      local colors = {
        bg       = "#202328",
        fg       = "#bbc2cf",
        yellow   = "#ECBE7B",
        cyan     = "#008080",
        darkblue = "#081633",
        green    = "#98be65",
        orange   = "#FF8800",
        violet   = "#a9a1e1",
        magenta  = "#c678dd",
        blue     = "#51afef",
        red      = "#ec5f67",
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        function()
          return "▊"
        end,
        color = { fg = colors.blue },
        padding = { left = 0, right = 1 },
      }

      ins_left {
        function()
          return ""
        end,
        color = function()
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      }

      ins_left {
        "filesize",
        cond = conditions.buffer_not_empty,
      }

      ins_left {
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = "bold" },
      }

      ins_left { "location" }

      ins_left { "progress", color = { fg = colors.fg, gui = "bold" } }

      ins_left {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
      }

      ins_left {
        function()
          return "%="
        end,
      }

      ins_left {
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " LSP:",
        color = { fg = "#ffffff", gui = "bold" },
      }

      ins_right {
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      }

      ins_right {
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green, gui = "bold" },
      }

      ins_right {
        "branch",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
      }

      ins_right {
        "diff",
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
        modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      }

      ins_right {
        function()
          return "▊"
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      }

      lualine.setup(config)

    '';
  };
}
