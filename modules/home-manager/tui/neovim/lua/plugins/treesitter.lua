return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = false,
      ensure_installed = {},
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
