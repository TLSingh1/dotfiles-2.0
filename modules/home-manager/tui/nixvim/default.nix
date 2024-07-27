{ pkgs, ...}:
{
  imports = [
    ./autocommands.nix
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
    colorschemes.tokyonight = {
      enable = true;
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
    extraPlugins = with pkgs.vimPlugins; [
      neorg
      neorg-telescope
      winbar-nvim
      colorful-winsep
      # incline
      nvim-web-devicons
      markdown-nvim
      typescript-tools
      tailwind-tools
      yazi-nvim
      # tailwindcss-colorizer-cmp
      # tw-values
    ];
    extraPackages = with pkgs; [
      imagemagick
    ];
    extraLuaPackages = luaPkgs: with luaPkgs; [
      lua-utils-nvim
      nvim-nio
      pathlib-nvim
      magick
    ];
    extraFiles = {
      "lua/config/init.lua" = builtins.readFile ./lua/config/init.lua;
    };
    extraConfigLua = ''
      ${builtins.readFile ./lua/init.lua}
    '';

    # extraConfigLuaPost = builtins.readFile ./lua/init.lua;
    # extraConfigLuaPost = ''
    #   local luasnip = require("luasnip")
    #
    #   luasnip.filetype_extend("javascript", {"html"})
    #   luasnip.filetype_extend("javascriptreact", {"html"})
    #   luasnip.filetype_extend("typescriptreact", {"html"})
    #
    #   -- ls.snippets.javascript = ls.snippets.html
    #   require("luasnip/loaders/from_vscode").load({include = {"html"}})
    #   require("luasnip/loaders/from_vscode").lazy_load()
    #
	   #  local signs = {
	   #  	{ name = "DiagnosticSignError", text = "" },
	   #  	{ name = "DiagnosticSignWarn", text = "" },
	   #  	{ name = "DiagnosticSignHint", text = "" },
	   #  	{ name = "DiagnosticSignInfo", text = "" },
	   #  }
    #
	   #  for _, sign in ipairs(signs) do
	   #  	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	   #  end
    #
	   #  local config = {
	   #  	virtual_text = true,
	   #  	virtual_lines = {
	   #  		only_current_line = true,
	   #  		highlight_whole_line = false,
	   #  	},
	   #  	signs = {
	   #  		active = signs,
	   #  	},
	   #  	update_in_insert = false,
	   #  	underline = true,
	   #  	severity_sort = true,
	   #  	float = {
	   #  		focusable = false,
	   #  		style = "minimal",
	   #  		border = "rounded",
	   #  		source = "always",
	   #  		header = "",
	   #  		prefix = "",
	   #  	},
	   #  }
    #
	   #  vim.diagnostic.config(config)
    #
	   #  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	   #  	border = "rounded",
	   #  	width = 60,
	   #  })
    #
	   #  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	   #  	border = "rounded",
	   #  	width = 60,
	   #  })
    #   
    #   vim.diagnostic.open_float = (function(orig)
    #   	return function(opts)
    #   		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    #   		local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
    #   		local max_severity = vim.diagnostic.severity.HINT
    #   		for _, d in ipairs(diagnostics) do
    #   			if d.severity < max_severity then
    #   				max_severity = d.severity
    #   			end
    #   		end
    #   		local border_color = ({
    #   			[vim.diagnostic.severity.HINT] = "DiagnosticInfo",
    #   			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    #   			[vim.diagnostic.severity.WARN] = "WarningMsg",
    #   			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
    #   		})[max_severity]
    #   		opts.border = {
    #   			{ "╭", border_color },
    #   			{ "─", border_color },
    #   			{ "╮", border_color },
    #   			{ "│", border_color },
    #   			{ "╯", border_color },
    #   			{ "─", border_color },
    #   			{ "╰", border_color },
    #   			{ "│", border_color },
    #   		}
    #   		orig(opts)
    #   	end
    #   end)(vim.diagnostic.open_float)
    #
    #   require("neorg").setup {
	   #    load = {
	   #    	["core.defaults"] = {},
	   #    	["core.itero"] = {},
	   #    	["core.export.markdown"] = {},
	   #    	["core.latex.renderer"] = {
    #         config = {
    #           conceal = true,
    #           render_on_enter = false,
    #         },
    #       },
	   #    	["core.keybinds"] = {
	   #    		config = {
	   #    			hook = function(keybinds)
	   #    				keybinds.unmap("norg", "n", "<LocalLeader>li")
	   #    				keybinds.remap_key("norg", "n", "<LocalLeader>lt", "<LocalLeader>nL")
	   #    			end,
	   #    		},
	   #    	},
	   #    	["core.concealer"] = {
	   #    		config = {
	   #    			icon_preset = "varied",
	   #    			icons = {
	   #    				code_block = {
	   #    					conceal = true,
	   #    					content_only = true,
	   #    					highlight = "CursorLine",
	   #    				},
	   #    			},
	   #    		},
	   #    	},
	   #    	["core.dirman"] = {
	   #    		config = {
	   #    			workspaces = {
    #             brain = "~/Brain",
    #             fleeting = "~/Brain/100 Fleeting Notes",
    #             literature = "~/Brain/200 Literature Notes",
    #             professional = "~/Brain/300 Professional",
    #             personal = "~/Brain/400 Personal",
    #             princeton = "~/Brain/500 Princeton",
    #             science = "~/Brain/600 Science",
    #             software = "~/Brain/700 Software Eng",
    #             technology = "~/Brain/800 Technology",
	   #    			},
	   #    			index = "index.norg",
	   #    		},
	   #    	},
	   #    	["core.esupports.metagen"] = {
	   #    		config = {
	   #    			type = "auto",
	   #    		},
	   #    	},
	   #    	["core.completion"] = {
	   #    		config = {
	   #    			engine = "nvim-cmp",
	   #    			name = "[Neorg]",
	   #    		},
	   #    	},
	   #    },
    #   }
    #
    #
    #   local highlight = {
    #       "RainbowRed",
    #       "RainbowYellow",
    #       "RainbowBlue",
    #       "RainbowOrange",
    #       "RainbowGreen",
    #       "RainbowViolet",
    #       "RainbowCyan",
    #   }
    #   local hooks = require "ibl.hooks"
    #   -- create the highlight groups in the highlight setup hook, so they are reset
    #   -- every time the colorscheme changes
    #   hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    #       vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    #       vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    #       vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    #       vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    #       vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    #       vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    #       vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    #   end)
    #
    #   vim.g.rainbow_delimiters = { highlight = highlight }
    #   require("ibl").setup { scope = { highlight = highlight } }
    #
    #   hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    #
    #   hooks.register(
    #     hooks.type.WHITESPACE,
    #     hooks.builtin.hide_first_space_indent_level
    #   )
    #
    #   -- require("winbar").setup({
    #   --   icons = true,
    #   --   diagnostics = true,
    #   --   buf_modified = true,
    #   --   buf_modified_symbol = "M",
    #   --   dim_inactive = {
    #   --     enabled = false,
    #   --     highlight = "WinbarNC",
    #   --     icons = true,
    #   --     name = true,
    #   --   }
    #   -- })
    #
    #   require("colorful-winsep").setup({
    #     -- highlight for Window separator
    #     hi = {
    #       bg = "#222436",
    #       fg = "#222436",
    #     },
    #     -- This plugin will not be activated for filetype in the following table.
    #     no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
    #     -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
    #     symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
    #     -- #70: https://github.com/nvim-zh/colorful-winsep.nvim/discussions/70
    #     only_line_seq = true,
    #     -- Smooth moving switch
    #     smooth = true,
    #     exponential_smoothing = true,
    #     anchor = {
    #       left = { height = 1, x = -1, y = -1 },
    #       right = { height = 1, x = -1, y = 0 },
    #       up = { width = 0, x = -1, y = 0 },
    #       bottom = { width = 0, x = 1, y = 0 },
    #    },
    #    light_pollution = function(lines) end,
    #   })
    #
    #   local devicons = require("nvim-web-devicons")
    #
    #   devicons.setup {
    #     color_icons = true;
    #     default = true;
    #     strict = true;
    #     override_by_filename = {
    #       [".gitignore"] = {
    #         icon = "",
    #         color = "#f1502f",
    #         name = "Gitignore"
    #       }
    #     };
    #     override_by_extension = {
    #       ["log"] = {
    #         icon = "",
    #         color = "#81e043",
    #         name = "Log"
    #       }
    #     };
    #   } 
    #
    #
    #   -- require("incline").setup {
    #   --   render = function(props)
    #   --     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    #   --     if filename == "" then
    #   --       filename = "[No Name]"
    #   --     end
    #   --     local ft_icon, ft_color = devicons.get_icon_color(filename)
    #
    #   --     local function get_git_diff()
    #   --       local icons = { removed = "", changed = "", added = "" }
    #   --       local signs = vim.b[props.buf].gitsigns_status_dict
    #   --       local labels = {}
    #   --       if signs == nil then
    #   --         return labels
    #   --       end
    #   --       for name, icon in pairs(icons) do
    #   --         if tonumber(signs[name]) and signs[name] > 0 then
    #   --           table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
    #   --         end
    #   --       end
    #   --       if #labels > 0 then
    #   --         table.insert(labels, { "┊ " })
    #   --       end
    #   --       return labels
    #   --     end
    #
    #   --     local function get_diagnostic_label()
    #   --       local icons = { error = "", warn = "", info = "", hint = "" }
    #   --       local label = {}
    #
    #   --       for severity, icon in pairs(icons) do
    #   --         local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    #   --         if n > 0 then
    #   --           table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
    #   --         end
    #   --       end
    #   --       if #label > 0 then
    #   --         table.insert(labels, { "┊ " })
    #   --       end
    #   --       return label
    #   --     end
    #
    #   --     return {
    #   --       { get_diagnostic_label() },
    #   --       { get_git_diff() },
    #   --       { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
    #   --       { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
    #   --       { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
    #   --     }
    #   --   end,
    #   -- }
    #
    #   local lualine = require("lualine")
    #   local function file_path_with_parent()
    #     local file = vim.fn.expand('%:t')
    #     local parent = vim.fn.expand('%:h:t')
    #     if parent == '.' then
    #       return file
    #     else
    #       return parent .. '/' .. file
    #     end
    #   end
    #   local colors = {
    #     bg       = '#000000',
    #     fg       = '#bbc2cf',
    #     yellow   = '#ECBE7B',
    #     cyan     = '#008080',
    #     darkblue = '#081633',
    #     green    = '#98be65',
    #     orange   = '#FF8800',
    #     violet   = '#a9a1e1',
    #     magenta  = '#c678dd',
    #     blue     = '#51afef',
    #     red      = '#ec5f67',
    #   }
    #   local conditions = {
    #     buffer_not_empty = function()
    #       return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    #     end,
    #     hide_in_width = function()
    #       return vim.fn.winwidth(0) > 80
    #     end,
    #     check_git_workspace = function()
    #       local filepath = vim.fn.expand("%:p:h")
    #       local gitdir = vim.fn.finddir(".git", filepath .. ";")
    #       return gitdir and #gitdir > 0 and #gitdir < #filepath
    #     end,
    #   }
    #   local cursor_symbols = {
    #     "▁",
    #     "▂",
    #     "▃",
    #     "▄",
    #     "▅",
    #     "▆",
    #     "▇",
    #     "█",
    #   }
    #   local function cursor_location()
    #     local current_line = vim.fn.line(".")
    #     local total_lines = vim.fn.line("$")
    #     local percentage = math.floor((current_line / total_lines) * 100)
    #     local index = math.floor((percentage / 100) * (#cursor_symbols - 1)) + 1
    #     return cursor_symbols[index]
    #   end
    #   local config = {
    #     options = {
    #       disabled_filetypes = {
    #         statusline = { "alpha", "dashboard" },
    #       },
    #       component_separators = "",
    #       section_separators = "",
    #       theme = {
    #         normal = { c = { fg = colors.fg, bg = colors.bg } },
    #         inactive = { c = { fg = colors.fg, bg = colors.bg } },
    #       },
    #     },
    #     sections = {
    #       lualine_a = {},
    #       lualine_b = {},
    #       lualine_y = {},
    #       lualine_z = {},
    #       lualine_c = {},
    #       lualine_x = {},
    #     },
    #     inactive_sections = {
    #       lualine_a = {},
    #       lualine_b = {},
    #       lualine_y = {},
    #       lualine_z = {},
    #       lualine_c = {},
    #       lualine_x = {},
    #     },
    #   }
    #   local function ins_left(component)
    #     table.insert(config.sections.lualine_c, component)
    #   end
    #   local function ins_right(component)
    #     table.insert(config.sections.lualine_x, component)
    #   end
    #   ins_left({
    #     function()
    #       return require("battery").get_status_line()
    #     end,
    #     color = { fg = "#1affff", bg = "#000000" },
    #   })
    #   ins_left({
    #     function()
    #       local mode = vim.fn.mode()
    #       local mode_symbols = {
    #         n = " N",
    #         i = " I",
    #         v = " V",
    #         [""] = " V",
    #         V = " V",
    #         c = " C",
    #         no = " N",
    #         s = " S",
    #         S = " S",
    #         [""] = " S",
    #         ic = " I",
    #         R = " R",
    #         Rv = " R",
    #         cv = " C",
    #         ce = " C",
    #         r = " R",
    #         rm = " R",
    #         ["r?"] = " R",
    #         ["!"] = " !",
    #         t = " T",
    #       }
    #       return mode_symbols[mode]
    #     end,
    #     color = function()
    #       local mode_color = {
    #         n = colors.red,
    #         i = colors.green,
    #         v = colors.blue,
    #         [""] = colors.blue,
    #         V = colors.blue,
    #         c = colors.magenta,
    #         no = colors.red,
    #         s = colors.orange,
    #         S = colors.orange,
    #         [""] = colors.orange,
    #         ic = colors.yellow,
    #         R = colors.violet,
    #         Rv = colors.violet,
    #         cv = colors.red,
    #         ce = colors.red,
    #         r = colors.cyan,
    #         rm = colors.cyan,
    #         ["r?"] = colors.cyan,
    #         ["!"] = colors.red,
    #         t = colors.red,
    #       }
    #       return { fg = mode_color[vim.fn.mode()] }
    #     end,
    #     padding = { right = 1, left = 1 },
    #   })
    #   ins_left({
    #     "diagnostics",
    #     sources = { "nvim_diagnostic" },
    #     symbols = { error = " ", warn = " ", info = " " },
    #     diagnostics_color = {
    #       color_error = { fg = colors.red },
    #       color_warn = { fg = colors.yellow },
    #       color_info = { fg = colors.cyan },
    #     },
    #   })
    #   ins_left({
    #     function()
    #       return "%="
    #     end,
    #   })
    #   ins_left({
    #     "diff",
    #     symbols = { added = " ", modified = "󰝤 ", removed = " " },
    #     diff_color = {
    #       added = { fg = "#81C784" },
    #       modified = { fg = "#FFB74D" },
    #       removed = { fg = "#E57373" },
    #     },
    #     cond = conditions.hide_in_width,
    #   })
    #   ins_left({
    #     "branch",
    #     icon = "",
    #     color = { fg = "#BA68C8", gui = "bold" },
    #   })
    #   ins_right({
    #     function()
    #       local names = {}
    #       for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    #         table.insert(names, server.name)
    #       end
    #       local count = #names
    #       return "" .. count .. " LSP"
    #     end,
    #     icon = "🧠",
    #     color = { fg = "#EF9A9A", gui = "bold" },
    #   })
    #   ins_right({
    #     "progress",
    #     color = {
    #       fg = "#4DD0E1",
    #       gui = "bold",
    #     },
    #   })
    #   ins_right({
    #     function()
    #       return cursor_location()
    #     end,
    #     color = { fg = "#4DD0E1", gui = "bold" },
    #   })
    #   
    #   lualine.setup(config)
    #
    #
    #   local status_ok, indent_blankline = pcall(require, "indent_blankline")
    #   if not status_ok then
    #   	return
    #   end
    #   
    #   vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
    #   vim.g.indent_blankline_filetype_exclude = {
    #   	"help",
    #   	"dashboard",
    #   }
    #   vim.g.indent_blankline_show_trailing_blankline_indent = true
    #
    #
    #   function get_file_path_with_parent()
    #     local file = vim.fn.expand("%:t")
    #     local parent = vim.fn.expand("%:h:t")
    #     if parent == "." then
    #       return file
    #     else
    #       return parent .. "/" .. file
    #     end
    #   end
    #
    #   vim.opt.winbar = "%{%v:lua.get_file_path_with_parent()%}"
    #   -- vim.api.nvim_set_hl(0, "WinBar", { bg = "#222436", fg = "#1affff", bold = true, italic = true })
    #   vim.api.nvim_set_hl(0, "WinBarNC", { bg = "#000000" })
    #
    #
    #   function get_signs(buf, lnum)
    #     local signs = {}
    #     local placed_signs = vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs
    #     for _, sign in ipairs(placed_signs) do
    #       local defined_sign = vim.fn.sign_getdefined(sign.name)[1]
    #       if defined_sign then
    #         local ret = {
    #           name = defined_sign.name,
    #           text = defined_sign.text,
    #           texthl = defined_sign.texthl,
    #           priority = sign.priority
    #         }
    #         table.insert(signs, ret)
    #       end
    #     end
    #
    #     local extmarks = vim.api.nvim_buf_get_extmarks(
    #       buf,
    #       -1,
    #       { lnum - 1, 0 },
    #       { lnum - 1, -1 },
    #       { details = true, type = "sign" }
    #     )
    #     for _, extmark in pairs(extmarks) do
    #       signs[#signs + 1] = {
    #         name = extmark[4].sign_hl_group or "",
    #         text = extmark[4].sign_text,
    #         texthl = extmark[4].sign_hl_group,
    #         priority = extmark[4].priority,
    #       }
    #     end
    #
    #     table.sort(signs, function(a, b)
    #       return (a.priority or 0) < (b.priority or 0)
    #     end)
    #
    #     return signs
    #   end
    #
    #   function get_mark(buf, lnum)
    #     local marks = vim.fn.getmarklist(buf)
    #     vim.list_extend(marks, vim.fn.getmarklist())
    #     for _, mark in ipairs(marks) do
    #       if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
    #         return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
    #       end
    #     end
    #   end
    #
    #   function icon(sign, len)
    #     sign = sign or {}
    #     len = len or 2
    #     local text = vim.fn.strcharpart(sign.text or "", 0, len)
    #     text = text .. string.rep(" ", len - vim.fn.strchars(text))
    #     return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
    #   end
    #
    #   function statuscolumn()
    #     local win = vim.g.statusline_winid
    #     local buf = vim.api.nvim_win_get_buf(win)
    #     local is_file = vim.bo[buf].buftype == ""
    #     local show_signs = vim.wo[win].signcolumn ~= "no"
    #   
    #     local components = { "", "", "" }
    #   
    #     if show_signs then
    #       local left, right, fold
    #       for _, s in ipairs(get_signs(buf, vim.v.lnum)) do
    #         if s.name and s.name:find("GitSign") then
    #           right = s
    #         else
    #           left = s
    #         end
    #       end
    #       if vim.v.virtnum ~= 0 then
    #         left = nil
    #       end
    #       vim.api.nvim_win_call(win, function()
    #         if vim.fn.foldclosed(vim.v.lnum) >= 0 then
    #           fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
    #         end
    #       end)
    #       components[1] = icon(get_mark(buf, vim.v.lnum) or left)
    #       components[3] = is_file and icon(fold or right) or ""
    #     end
    #   
    #     local is_num = vim.wo[win].number
    #     local is_relnum = vim.wo[win].relativenumber
    #   
    #     if (is_num or is_relnum) then
    #       if vim.v.virtnum > 0 then
    #         -- This is a wrapped line
    #         components[2] = string.rep(" ", 4) -- Adjust the number of spaces as needed
    #       elseif vim.v.virtnum == 0 then
    #         if vim.v.relnum == 0 then
    #           components[2] = is_num and "%l" or "%r"
    #         else
    #           components[2] = is_relnum and "%r" or "%l"
    #         end
    #         components[2] = "%=" .. components[2] .. " "
    #       else
    #         -- This handles the case of 'diff' mode
    #         components[2] = "%="
    #       end
    #     end
    #   
    #     return table.concat(components, "")
    #   end
    #   -- Set the statuscolumn option
    #   vim.opt.statuscolumn = [[%!v:lua.statuscolumn()]]
    #
    #   require('render-markdown').setup({})
    #
    #   require'lspconfig'.lua_ls.setup {
    #     on_init = function(client)
    #       local path = client.workspace_folders[1].name
    #       if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
    #         return
    #       end
    #   
    #       client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
    #         runtime = {
    #           version = 'LuaJIT'
    #         },
    #         workspace = {
    #           checkThirdParty = false,
    #           library = {
    #             vim.env.VIMRUNTIME
    #           }
    #         }
    #       })
    #     end,
    #     settings = {
    #       Lua = {}
    #     }
    #   }
    #
    #   require("typescript-tools").setup {}
    #   require("tailwind-tools").setup {}
    #
    #   -- require('ufo').setup()
    #
    #
    #   vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    #   vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    #   local capabilities = vim.lsp.protocol.make_client_capabilities()
    #   capabilities.textDocument.foldingRange = {
    #       dynamicRegistration = false,
    #       lineFoldingOnly = true
    #   }
    #   local language_servers = require("lspconfig").util.available_servers()
    #   for _, ls in ipairs(language_servers) do
    #       require('lspconfig')[ls].setup({
    #           capabilities = capabilities
    #       })
    #   end
    #   require('ufo').setup()
    #
    #   require('yazi').setup({
    #     -- open_for_directories = true,
    #
    #     set_keymappings_function = function(yazi_buffer_id, config, context)
    #       vim.notify("hello from yazi plugin")
    #     end, 
    #
    #
    #     -- yazi_floating_window_border = "none"
    #     -- use_ya_for_events_reading = true,
    #     -- use_yazi_client_id_flag = true,
    #   })
    # '';
  };

}
