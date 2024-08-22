vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
require("lazy").setup({
	performance = {
		reset_packpath = false,
		rtp = {
			reset = false,
		},
	},
	dev = {
		path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
	},
	install = {
		-- Safeguard in case we forget to install a plugin with Nix
		missing = false,
	},
})
