local dashboard = require("dashboard")

local conf = {}
conf.header = {
  "                                                       ",
  "                                                       ",
  "                                                       ",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  "                                                       ",
  "                                                       ",
  "                                                       ",
  "                                                       ",
}

conf.center = {
  {
    icon = "💰  ",
    desc = "Brain                              ",
    action = "tabnew /home/tai/Brain/index.norg | tcd %:p:h",
    key = "b",
  },
  {
    icon = "🔎  ",
    desc = "Find File                              ",
    action = "lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))",
    key = "f",
  },
  -- {
  -- 	icon = "🗿  ",
  -- 	desc = "Project Grep                            ",
  -- 	action = "Telescope projects",
  -- 	key = "p",
  -- },
  {
    icon = "🧬  ",
    desc = "Nvim Dots                        ",
    action = "tabnew $MYVIMRC | tcd %:p:h",
    key = "c",
  },
  {
    icon = "🥷  ",
    desc = "Quit Nvim                               ",
    -- desc = "Quit Nvim                               ",
    action = "qa",
    key = "q",
  },
}

dashboard.setup({
  theme = "doom",
  shortcut_type = "number",
  config = conf,
  -- hide = { tabline = false, winbar }
})
