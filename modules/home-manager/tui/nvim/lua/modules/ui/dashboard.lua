-- ./lua/modules/ui/dashboard.lua
local module_manager = require("core.module_manager")

module_manager.use({
  name = "dashboard-nvim",
  event = "VimEnter",
  config = function()
    local db = require("dashboard")

    -- Function to get the number of loaded plugins
    local function get_plugin_count()
      return #module_manager.plugins
    end

    -- Function to get the startup time in seconds with 2 digits of milliseconds
    local function get_startup_time()
      return string.format("%.2f", (vim.loop.hrtime() - vim.g.start_time) / 1000000000)
    end

    db.setup({
      theme = 'doom',
      config = {
        header = {
          "",
          "",
          "",
          "",
          "⠀⠀⠀⠀⠀⡐⢂⡒⠰⢢⠀⠀⠀⠰⡁⢎⠠⠃⡔⠢⠄⠀⠀⠀⠀⠀⠀⠀⢢⠀⠀⠀⡗⢦⠒⠤⣀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⢿⣿⣿",
          "⠀⠀⠀⠀⠀⡘⠤⢌⠱⠡⢆⠀⠀⠰⣁⠂⡄⣡⢀⡐⢬⣘⠲⣀⠀⠀⠀⠀⠀⣎⢧⠄⠈⢧⢏⡳⣤⠣⢄⠀⠀⠀⠀⠀⢤⣀⣈⠛⠻⢿",
          "⠀⠀⠀⠀⠠⡑⣈⠢⢡⢉⠒⡀⠀⠰⢤⡙⣰⢡⣋⡜⣤⢊⡗⡭⢦⡀⠄⠀⠀⢹⣎⠷⠳⠘⣈⠤⣤⢰⡠⢄⠀⠀⠀⠀⠀⠈⢻⣿⢿⣿",
          "⠀⠀⠀⠀⢢⠑⡤⢣⢆⡬⣘⡐⡂⢸⣄⠶⣥⣦⡉⠾⣶⢭⡞⣽⠋⣳⣆⠱⠄⠈⠊⠠⠲⠼⠬⠳⠮⣷⡱⣎⢆⠀⠀⠀⠀⠀⠀⠘⢿⣯",
          "⠀⠀⠀⠐⢤⢋⡴⢣⡞⣴⣣⢟⡽⣴⣫⡝⣬⠛⠙⠦⠹⠎⢷⡀⠃⠀⠀⠀⠐⡀⠃⣠⡴⠒⢶⣶⣦⣄⠙⠽⡎⣆⠀⠀⠀⠀⠀⠀⠀⠹",
          "⠀⠀⠀⠈⠒⠉⠚⠃⠛⠑⠋⠛⠙⠓⠋⠋⠉⢀⠠⢀⡰⢃⣀⠈⠉⠀⢠⣐⠃⢠⣿⣿⢳⣴⣮⣿⣿⠿⠷⠦⢴⡄⠀⠀⠀⠀⠀⢦⣀⡀",
          "⠀⠀⠀⢈⠭⡙⣭⠙⠂⣀⣀⣀⣀⠂⠂⠤⣁⠀⡄⡠⢄⠒⢌⠙⠀⢈⠖⡰⠀⣾⣿⣼⣿⣿⠛⢙⣀⡴⡶⠖⢠⠿⠦⣄⠀⠀⠀⠀⠙⢿",
          "⠀⠀⠀⡈⢶⠉⣠⣴⠉⠔⣹⡿⣿⣿⣷⣤⡈⠓⡶⣱⢊⡕⠈⠀⠀⠀⢈⠁⣰⣟⠛⠉⣉⠁⡀⠏⠎⠱⠁⣁⠈⠐⠀⠈⢆⠀⠀⠀⠀⠀",
          "⠀⠀⠀⡌⠁⣴⣿⡻⢿⣾⣿⣽⣷⣾⣻⣿⣷⣤⡁⠃⢯⠰⣁⠀⠛⠀⠀⠀⠁⣈⡀⠁⠀⢈⣁⣠⠤⠄⠘⠑⠀⠠⢀⡀⠈⡀⠀⠀⠙⢿",
          "⢂⠀⠀⢀⣰⠿⠳⠿⠻⠏⠛⠚⠙⠛⠛⢉⡀⠄⢈⡱⠀⢣⡐⠂⢠⢙⡀⠈⠆⢀⡉⠉⠲⠏⢠⣀⡄⢤⡀⠐⠘⡄⢡⡚⠄⡀⢀⠤⡀⢜",
          "⠈⡆⢀⠊⢠⡖⠖⡖⠂⢶⡚⢖⡡⠆⠀⠀⣠⠴⡩⠃⠀⠷⡁⢀⢠⣏⢶⡈⢦⡘⢿⣟⡶⣦⣤⡑⣚⠦⣝⠲⡄⢿⠀⡿⣄⡁⠠⠀⠡⠈",
          "⠀⠸⣏⠀⠄⠩⠀⠻⠀⠡⠘⠀⠀⣠⠲⣙⠖⠀⢁⣼⢳⣦⡔⠘⠆⠙⠊⠁⠘⢃⡈⡉⠙⠓⠘⠫⠽⣞⣬⡓⣖⡘⣰⠓⡮⡇⠀⣀⠜⢠",
          "⠀⠡⡏⠀⠞⡠⠀⢡⠀⡐⠰⣈⠱⡠⢯⠍⢀⡞⣏⣾⠳⠉⢀⣤⣶⣿⡿⠿⠿⠿⠽⠹⠏⠴⠬⠤⠈⠘⠂⠙⠦⢓⢤⢫⡱⣹⠀⠀⢩⠠",
          "⠀⠀⢷⠀⠱⡐⡈⢠⠀⡌⡱⢠⠳⣽⠃⣤⠃⣿⠞⠁⣀⣴⡿⠛⠞⠀⠀⣀⣀⣀⠀⠀⢀⣀⣠⣀⠠⣄⣄⣀⡀⠀⠈⢳⣱⢹⡄⠀⠆⠐",
          "⠀⡀⠘⡆⠐⣡⡓⡸⣇⢨⢵⡩⣟⢥⡺⣜⠃⠋⣠⠶⠋⠁⠀⣀⣤⡶⣟⠿⠙⠏⠿⢷⢦⡉⠛⢿⡄⣿⣿⡿⣿⡆⠱⠀⢱⡋⢷⠀⠁⣘",
          "⠀⢙⡄⠙⣄⠱⡍⢧⡱⢎⡞⡱⢇⢮⡑⢁⣴⠛⠀⢀⣤⠖⢠⡿⡹⠉⢀⡀⡄⣠⠀⡄⡉⠙⢳⣄⠑⢻⣿⣽⣿⢻⠀⠁⢸⡜⠀⠃⢰⣎",
          "⠀⠈⢜⠠⡆⠱⡎⢳⣍⠳⡜⡹⠘⠂⠠⠎⢀⣠⣾⣿⡟⢀⠿⡜⢁⡐⠶⢠⢳⡀⢻⣤⡙⢮⡆⣭⠳⣄⠉⠉⠈⡁⠀⠀⡽⠀⠀⡇⢸⣿",
          "⠀⠁⠈⠖⡽⢀⠱⡀⢎⡳⣩⡑⠈⠀⢡⣴⣧⣻⣿⣿⠁⠈⢃⣦⡜⣡⢋⡗⢢⣽⣂⢳⣽⣠⡙⣶⣣⢯⡽⣥⠂⣄⣀⡉⠏⠀⢀⠃⣼⣿",
          "⠐⠤⢠⠀⢹⡰⠀⡇⠸⡔⣣⠄⠀⡐⣿⣿⣿⣷⡹⠇⠘⠀⢮⣔⡻⢄⣿⡙⢶⣻⠶⣌⠳⣧⣝⡲⡽⣬⠷⣍⡟⡁⡟⠐⠀⡰⢎⢠⣿⣿",
          "⠈⢒⡡⢚⠀⢇⠀⡡⠐⡇⢱⠀⠀⢶⠫⣿⠿⡿⡏⠀⢀⢈⡷⣎⢽⡞⡶⣟⢬⡳⣻⢧⢧⡙⢮⢳⠳⢏⠞⢦⠉⢀⠁⠀⣠⠄⣋⣸⣿⣿",
          "⣄⠐⠌⢡⢒⡀⠡⠐⠀⠣⠈⢆⠀⠘⠁⠈⡉⠀⠀⠀⣼⡘⡲⣍⠎⡽⠓⡭⢒⡱⣉⢎⢢⠙⡌⢣⠹⢈⠞⡠⠀⠆⠀⠌⣻⠆⣿⣿⣿⣿",
          "⣿⡆⠀⠀⠀⠀⠀⠀⠹⣄⠆⠈⣰⠀⢂⡀⢠⠆⣠⢋⢶⡡⢓⡌⢎⠡⠓⡌⢡⠓⡈⠆⠢⢑⡈⠆⠁⠈⠢⠁⢠⡶⠚⠀⠘⢠⣿⣿⣿⣿",
          "⣿⣷⠀⢀⣿⡦⢐⡀⠀⠀⠙⠲⠄⠙⠳⣍⡘⢆⠦⡉⢆⡃⠆⣌⢢⢡⠣⠜⣠⢂⠱⣈⡑⢢⠜⠀⠀⠃⠀⠀⠙⠒⠀⡇⢠⣼⣿⣿⣿⣿",
          "⣷⣿⢠⣾⣿⡇⠸⣇⠀⠁⢬⠀⣄⠀⢀⠀⠁⠀⠉⠒⢠⠈⠁⡐⠈⠓⢮⠘⠀⠊⠑⠂⠉⠁⠀⠀⡀⠀⢠⣃⠄⠀⠀⡗⢸⣿⣿⣯⣿⣷",
          "⣿⣿⣿⣿⣿⣿⠘⡊⢀⣿⣮⣇⣼⣆⣀⣦⠀⠐⡀⠀⠼⡄⠀⠄⠀⠀⠚⠀⠀⠀⠀⠀⠂⠀⡀⠀⠇⢨⢳⡜⣄⠀⠀⠋⠘⠟⠛⠋⠡⢀",
          "",
          "",
          "",
          "",
        },
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File           ',
            desc_hl = 'String',
            key = 'b',
            keymap = 'f',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'lua print(2)'
          },
          {
            icon = ' ',
            desc = 'Find Dotfiles',
            key = 'f',
            keymap = 'SPC f d',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'lua print(3)'
          },
          { desc = "" },
          { desc = "" },
          { desc = "" },
          { desc = "" },
          { desc = "" },
          { desc = "" },
          { desc = "" },
        },
        footer = function()
          local plugin_count = get_plugin_count()
          local startup_time = get_startup_time()
          return {
            string.format("Neovim loaded %d plugins in %s seconds", plugin_count, startup_time),
            "Happy coding!"
          }
        end
      }
    })
  end,
})
