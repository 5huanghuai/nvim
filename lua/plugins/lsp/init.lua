-- mason manage external editor tooling  : LSP DAP linters formatters
--LSP language Server Protocol
--DAP Debug Adapter Protocol
-- linters find error
-- formatters foramt code
return {

	--lsp
	{
"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim", --mason
			"williamboman/mason-lspconfig.nvim", -- connect lspconfig and mason
			{ "folke/neodev.nvim", opts = {} }, -- better show help ,docs and completion
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true }, --manage global and project-local settings.
			{ "simrat39/inlay-hints.nvim", config = true }, --Neovim support for LSP Inlay Hints
			"haringsrob/nvim_context_vt", -- Shows virtual text of the current context after functions, methods, statements, etc.
			{
				"hrsh7th/cmp-nvim-lsp",

				--cond = function()
				--		return require("util").has("nvim-cmp")
				--	end,
			},
			{
				"folke/trouble.nvim",
				cmd = { "TroubleToggle", "Trouble" },
				opts = { use_diagnostic_signs = true },
			}, --A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
		},

		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			-- Automatically format on save
			autoformat = true,
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overriden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			-- LSP Server Settings
			---@type lspconfig.options
			servers = {
				lua_ls = {
					-- mason = false, -- set to false if you don't want this server to be installed with mason
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		---@param-opts-PluginLspOpts
		config = function(plugin, opts)
			-- setup autoformat
			require("plugins.lsp.format").autoformat = opts.autoformat
			-- setup formatting and keymaps
			require("util").on_attach(function(client, buffer)
				require("plugins.lsp.format").on_attach(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- diagnostics
			for name, icon in pairs(require("config.icons").diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local server_opts = servers[server] or {}
				server_opts.capabilities = capabilities
				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup_handlers({ setup })
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" } },

		opts = {
			ensure_installed = {
				-- Formatter
				"stylua",
				"prettier",
				"shfmt",
				"jq",
				-- Linter
				"eslint_d",
				"standardrb",
				"golangci-lint",
				"shellcheck",
				"yamllint",
			},
		},

		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(plugin, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},

	-- complete
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip", -- luasnip for cmp plugin
		},
		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					--["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- using enter and <control+l> to Accept selected item simultaneously
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-l>"] = cmp.mapping({
						i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
						c = function(fallback)
							if cmp.visible() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
							else
								fallback()
							end
						end,
					}),
					-- using TAB and <control + j> to choose next item simultaneously
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end, { "i", "s", "c" }),
					["<C-j>"] = cmp.mapping(function(fallback)
						-- ["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end, { "i", "s", "c" }),
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s", "c" }),
				}),
				sources = cmp.config.sources({

					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				}),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			---- Set up lspconfig.
			--local capabilities = require("cmp_nvim_lsp").default_capabilities()
			---- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			--require("lspconfig")["<YOUR_LSP_SERVER>"].setup({
			--	capabilities = capabilities,
			--})
		end,
	},
	--luasnip
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ -- luasnip plugin for telescope
				"benfowler/telescope-luasnip.nvim",
				config = function()
					require("telescope").load_extension("luasnip")
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			--require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
		end,
		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<tab>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<s-tab>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},
	--formatter
	{
		"mhartington/formatter.nvim",
		cmd = "Format",
		dependencied = {
			{ "ckipp01/stylua-nvim", run = "cargo install stylua" },
		},
		config = function()
			-- Utilities for creating configurations
			local util = require("formatter.util")

			-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
			require("formatter").setup({
				-- Enable or disable logging
				logging = true,
				-- Set the log level
				log_level = vim.log.levels.WARN,
				-- All formatter configurations are opt-in
				filetype = {
					-- Formatter configurations for filetype "lua" go here
					-- and will be executed in order
					lua = {
						-- "formatter.filetypes.lua" defines default configurations for the
						-- "lua" filetype
						require("formatter.filetypes.lua").stylua,

						-- You can also define your own configuration
						function()
							-- Supports conditional formatting
							if util.get_current_buffer_file_name() == "special.lua" then
								return nil
							end

							-- Full specification of configurations is down below and in Vim help
							-- files
							return {
								exe = "stylua",
								args = {
									"--search-parent-directories",
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
									"--",
									"-",
								},
								stdin = true,
							}
						end,
					},

					-- Use the special "*" filetype for defining formatter configurations on
					-- any filetype
					["*"] = {
						-- "formatter.filetypes.any" defines default configurations for any
						-- filetype
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
		end,
	},
}
