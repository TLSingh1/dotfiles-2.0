require('yazi').setup({
	-- open_for_directories = true,

	set_keymappings_function = function(yazi_buffer_id, config, context)
		vim.notify("hello from yazi plugin")
	end,


	-- yazi_floating_window_border = "none"
	-- use_ya_for_events_reading = true,
	-- use_yazi_client_id_flag = true,
})
