return {
  "rebelot/heirline.nvim",
  event = "UIEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- if you want to use icons in the statusline
  },
  config = function()
    require("heirline").setup({
      -- Your heirline configuration here
    })
  end,
}
