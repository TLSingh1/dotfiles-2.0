return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require'window-picker'.setup({
      hint = 'floating-big-letter',
      selection_chars = 'FJDKSLA;CMRUEIWOQP',
      picker_config = {
        floating_big_letter = {
          font = 'ansi-shadow',
        },
      },
      show_prompt = true,
      prompt_message = 'Pick window: ',
      filter_func = nil,
      filter_rules = {
        autoselect_one = true,
        include_current_win = false,
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { 'NvimTree', 'neo-tree', 'notify' },

          -- if the file type is one of following, the window will be ignored
          buftype = { 'terminal' },
        },
      },
    })
  end,
}
