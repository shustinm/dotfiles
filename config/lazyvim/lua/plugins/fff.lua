return {
	{
		"dmtrKovalenko/fff.nvim",
		build = function()
			require("fff.download").download_or_build_binary()
		end,
		lazy = false,
		opts = {},
		keys = {
			{ "<leader>ff", function() require("fff").find_files() end, desc = "Find Files (fff)" },
			{ "<leader><space>", function() require("fff").find_files() end, desc = "Find Files (fff)" },
			{ "<leader>sg", function() require("fff").live_grep() end, desc = "Grep (fff)" },
			{ "<leader>/", function() require("fff").live_grep() end, desc = "Grep (fff)" },
			{ "<leader>sz",
				function() require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } }) end,
				desc = "Fuzzy Grep (fff)",
			},
			{ "<leader>sw",
				function() require("fff").live_grep({ query = vim.fn.expand("<cword>") }) end,
				desc = "Grep Word (fff)",
			},
		},
	},
}
