# Module Manager for Neovim

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Specification Format](#specification-format)
- [Lazy Loading](#lazy-loading)
- [Custom Modules](#custom-modules)
- [Examples](#examples)
- [Architecture](#architecture)
- [Images](#images)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Module Manager is a lightweight, flexible system designed specifically for
managing Neovim plugins and custom modules within a NixOS environment using
home-manager. This project was born out of the need for a simpler, more
integrated solution for Neovim configuration management in NixOS.

### Why Module Manager?

1. **NixOS Integration**: While popular plugin managers like Lazy.nvim offer
   powerful features, they can be complex to integrate seamlessly with NixOS and
   home-manager. Our Module Manager is designed from the ground up to work
   harmoniously with the NixOS ecosystem.

2. **Simplicity**: We found existing solutions to be overly complex for our
   needs. Module Manager provides a streamlined approach to plugin management
   without sacrificing functionality.

3. **Nix-Centric Approach**: Instead of relying on a plugin manager to handle
   installations, we leverage Nix packages to install plugins. Module Manager
   focuses solely on configuring and loading these pre-installed plugins.

4. **Reduced Bloat**: By offloading plugin installation to Nix and focusing on
   configuration and loading, Module Manager remains lean and efficient.

5. **Custom Module Support**: Beyond plugin management, Module Manager allows
   easy integration of custom Lua modules, providing a unified approach to
   Neovim configuration.

### How It Works

1. **Plugin Installation**: Plugins are installed via Nix packages, typically
   defined in your `home.nix` or a dedicated Neovim configuration file.

2. **Configuration**: Module Manager provides a simple specification format for
   configuring these installed plugins.

3. **Loading**: Plugins are loaded either immediately or lazily based on your
   specifications.

4. **Custom Modules**: Your own Lua modules can be seamlessly integrated
   alongside plugins.

This approach combines the power of Nix for package management with a simple,
purpose-built system for Neovim configuration, resulting in a clean,
reproducible, and efficient setup.

## Features

- **Plugin Management**: Easily configure and load Neovim plugins installed via
  Nix
- **Lazy Loading**: Improve startup time by loading plugins only when needed
- **Custom Modules**: Integrate your own Lua modules seamlessly
- **Keymaps Management**: Centralized keymap configuration for plugins
- **Error Handling**: Robust error reporting for plugin loading and
  configuration
- **NixOS Integration**: Designed to work flawlessly with NixOS and home-manager

## Installation

1. Ensure your NixOS configuration includes the necessary Neovim plugins. In
   your `home.nix` or Neovim configuration file, add something like:

```nix
programs.neovim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    # Your plugins here
    telescope-nvim
    nvim-treesitter
    # ... other plugins
  ];
};
```

2. Clone this repository into your Neovim configuration directory:

3. In your `init.lua`, add the following line:

```lua
require("core.module_manager").setup()
```

> [!WARNING]
>
> I don't know what i'm doing would love feedback/tips/help Also AI made this
> readme

## Usage

To use the Module Manager, create specification files for your plugins in the
`lua/modules` directory. Here's a basic example:

```lua
-- lua/modules/ui/somecolorscheme.lua
local module_manager = require("core.module_manager")

module_manager.use({
    name = "somecolorscheme",
    config = function()
        vim.cmd("colorscheme somecolorscheme")
    end
})
```

## Specification Format

Each plugin or module is defined using a specification table with the following
fields:

- `name` (string, required): The name of the plugin
- `event` (string or table): Event(s) to trigger lazy loading
- `ft` (string or table): Filetype(s) to trigger lazy loading
- `cmd` (string or table): Command(s) to trigger lazy loading
- `keys` (table): Keymaps to trigger lazy loading
- `config` (function): Configuration function for the plugin
- `keymaps` (table): Keymaps to be set for the plugin

## Lazy Loading

Lazy loading can be configured using the `event`, `ft`, `cmd`, or `keys` fields.
Here's an example:

```lua
module_manager.use({
    name = "telescope.nvim",
    cmd = "Telescope",
    config = function()
        require("telescope").setup({})
    end,
    keymaps = {
        n = {
            ["<leader>ff"] = "<cmd>Telescope find_files<CR>",
        }
    }
})
```

## Custom Modules

Custom modules can be added using the `use_custom` function:

```lua
module_manager.use_custom({
    name = "my_custom_module",
    config = function()
        -- Your custom module setup
    end
})
```

## Examples

### Plugin with Lazy Loading

```lua
module_manager.use({
    name = "nvim-treesitter",
    event = "BufRead",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            highlight = { enable = true },
        })
    end
})
```

### Custom Status Line

```lua
module_manager.use_custom({
    name = "custom_statusline",
    config = function()
        vim.o.statusline = "%f %y %m %r %=%l,%c %P"
    end
})
```

## Architecture

The Module Manager follows this high-level architecture:

```mermaid
graph TD
    A[init.lua] -->|Loads| B[module_manager.lua]
    B -->|Scans| C[modules directory]
    C -->|Loads| D[Plugin Specs]
    C -->|Loads| E[Custom Modules]
    B -->|Processes| F[Plugins]
    B -->|Processes| G[Custom Modules]
    F -->|Lazy Load| H[On Event/Command]
    F -->|Immediate Load| I[On Startup]
    G -->|Load| J[Custom Functionality]
```

## Images

![Sample 1](https://media.discordapp.net/attachments/1257127902974316565/1284346196349157387/pic-1.png?ex=66e64c1b&is=66e4fa9b&hm=dd8c163f3642c73466e017831de55ce76c215f06aefe84a6cf512d8b4f8737e9&=&format=webp&quality=lossless&width=602&height=661)
![Sample 2](https://media.discordapp.net/attachments/1257127902974316565/1284345697151483945/pic-2.png?ex=66e64ba4&is=66e4fa24&hm=eef472177970d437ace6a2e12d4cdd58bfc480d42752c678c05090ce47bcb917&=&format=webp&quality=lossless&width=572&height=661)
![Sample 3](https://media.discordapp.net/attachments/1257127902974316565/1284345697625313311/pic-3.png?ex=66e64ba4&is=66e4fa24&hm=1169ec2ab07d7e68c70ff1708ad15de9f6d8488c46d865550b915cb7c8db0b35&=&format=webp&quality=lossless&width=609&height=661)
![Sample 4](https://media.discordapp.net/attachments/1257127902974316565/1284345699147714594/pic-6.png?ex=66e64ba4&is=66e4fa24&hm=41c35618535a17bebc488620eea9338781e1e4b988e08fe311b20c8ef0a28704&=&format=webp&quality=lossless&width=609&height=661)
![Sample 5](https://media.discordapp.net/attachments/1257127902974316565/1284345698581614724/pic-5.png?ex=66e64ba4&is=66e4fa24&hm=8e29560673fbcf283b33033f553d1a04693527f5d93f3b3914970832da65e0c6&=&format=webp&quality=lossless&width=603&height=661)
![Sample 6](https://media.discordapp.net/attachments/1257127902974316565/1284345698090745938/pic-4.png?ex=66e64ba4&is=66e4fa24&hm=eb3c3b47326b4884ba1c96f8132bdb90a21932cce1110b218e0d7cb289ed62fc&=&format=webp&quality=lossless&width=610&height=661)
![Sample 7](https://cdn.discordapp.com/attachments/1257127902974316565/1282289833535868990/nvim-2.png?ex=66e61138&is=66e4bfb8&hm=e06a9d8ff23fb21ca91e935a75e437b75dbaa3c44d65c4f2fec2feb6ef272d8f&)
![Sample 8](https://media.discordapp.net/attachments/1257127902974316565/1282289833955561543/nvim-1.png?ex=66e61138&is=66e4bfb8&hm=ee35c92035dc992d53dabdf70693c8cc8f8717da3befe2d7a60b9993dd26a59d&=&format=webp&quality=lossless&width=1174&height=661)
