--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["d"] = {}
lvim.builtin.which_key.mappings["c"] = {}
lvim.builtin.which_key.mappings["p"] = {}
lvim.builtin.which_key.mappings["x"] = { "<cmd>BufferKill<CR>", "Close Buffer" }

-- -- Change theme settings
lvim.colorscheme = "darcula-solid"


lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  },
  {
    "briones-gabriel/darcula-solid.nvim", 
    dependencies = "rktjmp/lush.nvim"
  },
  {
    'nmac427/guess-indent.nvim',
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "ofirgall/open.nvim",
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}


local opt = vim.opt

opt.number = true -- Enables line numbers
opt.relativenumber = true -- Enables relative line numbers
opt.autoindent = true -- Indent automatically
opt.cursorline = true -- Enables cursor line
opt.ignorecase = true -- Ignore case when searching
opt.splitright = true -- Split to the right on vertical
opt.splitbelow = true -- Split below when horizontal
opt.swapfile = false -- Don't use swap files (I use auto-save.nvim instead)
opt.wrap = true -- Wrap lines
opt.updatetime = 100 -- mainly for trld.nvim which utilize CursorHold autocmd
opt.formatoptions:append('cro') -- continue comments when going down a line, hit C-u to remove the added comment prefix
opt.sessionoptions:remove('options') -- don't save keymaps and local options
opt.foldlevelstart = 99 -- no auto folding
opt.clipboard=default

local function map(mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
end


map('x', '<leader>p', '"_dP', 'Replace without yanking')

map('n', '<leader>d', '"_d', 'Delete without yanking') -- e.g <leader>dd deletes the current line without yanking it
map('n', '<leader>D', '"_D', 'Delete until EOL without yanking')

map('n', '<leader>c', '"_c', 'Change without yanking')
map('n', '<leader>C', '"_C', 'Change until EOL without yanking')

map('', '<leader>y', '"+y', 'Yank to clipboard') -- E.g: <leader>yy will yank current line to os clipboard
map('', '<leader>Y', '"+y$', 'Yank until EOL to clipboard')

map('n', '<leader>p', '"+p', 'Paste after cursor from clipboard')
map('n', '<leader>P', '"+P', 'Paste before cursor from clipboard')

lvim.builtin.treesitter.textobjects.select = {
    enable = true,
    lookahead = true,
    keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["a/"] = "@comment.outer",
        ["i/"] = "@comment.outer", -- no inner for comment
        ["aa"] = "@parameter.outer", -- parameter -> argument
        ["ia"] = "@parameter.inner",
    },
}
lvim.builtin.treesitter.textobjects.move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
        ["]m"] = "@function.outer",
        ["gj"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]b"] = "@block.outer",
        ["]a"] = "@parameter.inner",
    },
    goto_next_end = {
        ["]M"] = "@function.outer",
        ["gJ"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]B"] = "@block.outer",
        ["]A"] = "@parameter.inner",
    },
    goto_previous_start = {
        ["[m"] = "@function.outer",
        ["gk"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[b"] = "@block.outer",
        ["[a"] = "@parameter.inner",
    },
    goto_previous_end = {
        ["[M"] = "@function.outer",
        ["gK"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[B"] = "@block.outer",
        ["[A"] = "@parameter.inner",
    },
}

map({'n', 't'}, '<C-h>', '<C-w>h')
map({'n', 't'}, '<C-j>', '<C-w>j')
map({'n', 't'}, '<C-k>', '<C-w>k')
map({'n', 't'}, '<C-l>', '<C-w>l')

map('n', '<M-e>', '<cmd>vsplit<cr>')
map('n', '<M-o>', '<cmd>split<cr>')

map('n', '<M-q>', '<cmd>q<cr>')

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tabline binds
map('n', '<C-q>', function() require('bufdelete').bufdelete(0, true) end) -- shift+Quit to close current tab
map('n', 'g1', function() require('bufferline').go_to_buffer(1, true) end)
map('n', 'g2', function() require('bufferline').go_to_buffer(2, true) end)
map('n', 'g3', function() require('bufferline').go_to_buffer(3, true) end)
map('n', 'g4', function() require('bufferline').go_to_buffer(4, true) end)
map('n', 'g5', function() require('bufferline').go_to_buffer(5, true) end)
map('n', 'g6', function() require('bufferline').go_to_buffer(6, true) end)
map('n', 'g7', function() require('bufferline').go_to_buffer(7, true) end)
map('n', 'g8', function() require('bufferline').go_to_buffer(8, true) end)
map('n', 'g9', function() require('bufferline').go_to_buffer(9, true) end)
map('n', 'g0', function() require('bufferline').go_to_buffer(10, true) end)
map('n', '<M-j>', '<cmd>BufferLineCyclePrev<CR>') -- Alt+j to move to left
map('n', '<M-k>', '<cmd>BufferLineCycleNext<CR>') -- Alt+k to move to right
map('n', '<M-J>', '<cmd>BufferLineMovePrev<CR>') -- Alt+Shift+j grab to with you to left
map('n', '<M-K>', '<cmd>BufferLineMoveNext<CR>') -- Alt+Shift+k grab to with you to right


-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
