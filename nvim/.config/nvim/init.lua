-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Options
vim.opt.syntax = "on"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Keybindings
vim.g.mapleader = " "

-- Plugins
require("lazy").setup({
	-- Themes
	{
		"Mofiqul/dracula.nvim",
		name = "dracula",
		config = function()
			vim.cmd("colorscheme dracula")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.treesitter.language.register("html", "html")
			require("nvim-treesitter").setup({
				ensure_installed = {
					"html", "css", "php", "python", "c", "rust", "cpp", "java", "javascript", "lua", "asm", "c_sharp"
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("pyright", {})
			vim.lsp.config("clangd", {})
			vim.lsp.config("rust_analyzer", {})
			vim.lsp.config("ts_ls", {})
			vim.lsp.config("intelephense", {})
			vim.lsp.config("lua_ls", {})
			vim.lsp.config("html", {})
			vim.lsp.config("tailwindcss", {})
			vim.lsp.config("omnisharp", {})

			vim.lsp.enable({
				"pyright", "clangd", "cmake", "rust_analyzer", "ts_ls", "intelephense", "lua_ls", "html", "tailwindcss", "omnisharp", "bashls", "yamlls", "jsonls", "taplo"
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
				vim.lsp.handlers.hover, {
					border = "rounded",
				}
			)
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright", "clangd", "cmake", "rust_analyzer", "ts_ls", "intelephense", "lua_ls", "html", "tailwindcss", "omnisharp", "bashls", "yamlls", "jsonls", "taplo"
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "dracula",
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function ()
			require("telescope").setup({})

			-- Keybindings
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep)
			vim.keymap.set("n", "<leader>fb", builtin.buffers)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add			 = { text = "+" },
					change		 = { text = "~" },
					delete		 = { text = "-" },
					topdelete	 = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					hover = { enabled = false },
					signature = { enabled = false },
				},
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function ()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                      _____       _ _        _                  _          ",
				"    /\\               |  __ \\     | | |      ( )                (_)         ",
				"   /  \\   _ __   ___ | |  | | ___| | |_ __ _|/ ___   _ ____   ___ _ __ ___",
				"  / /\\ \\ | '_ \\ / _ \\| |  | |/ _ \\ | __/ _` | / __| | '_ \\ \\ / / | '_ ` _ \\",
				" / ____ \\| | | | (_) | |__| |  __/ | || (_| | \\__ \\ | | | \\ V /| | | | | | |",
				"/_/    \\_\\_| |_|\\___/|_____/ \\___|_|\\__\\__,_| |___/ |_| |_|\\_/ |_|_| |_| |_|",
				"",
				"                       		AnoDelta's nvim",
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", " Find File", ":Telescope find_files<CR>"),
				dashboard.button("r", " Recent Files", ":Telescope oldfiles<CR>"),
				dashboard.button("g", " Grep", ":Telescope live_grep<CR>"),
				dashboard.button("q", " Quit", ":qa<CR>"),
			}

			local quotes = {
				"Delta was here",
				"Random lad",
				"DID SOMEONE SAY...",
				"...",
				"expected some good quotes?",
				":D",
				":3",
				"- v -",
			}

			math.randomseed(os.time())
			local quote = quotes[math.random(#quotes)]

			dashboard.section.footer.val = quote
			alpha.setup(dashboard.opts)
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
})
