require("auto-session").setup({
	auto_session_enabled = true,
	auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	auto_session_enable_last_session = true,
	auto_session_use_git_branch = true,
	auto_restore_enabled = true,
	auto_save_enabled = true,
	session_lens = {
		load_on_setup = true,
		theme_conf = { border = true },
		previewer = false,
	},
})
