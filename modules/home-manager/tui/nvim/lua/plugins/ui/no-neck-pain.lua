return {
  "shortcuts/no-neck-pain.nvim", 
  version = "*",
  config = function()
    require("no-neck-pain").setup({
      buffers = {
        scratchPad = {
          enabled = true,
          location = "~/Documents/",
        },
        bo = {
          filetype = "md",
        },
        wo = {
          fillchars = "eob: ",
        },
      },
    })
  end,
}
