return {
  {
    "nguyenvukhang/nvim-toggler",
    opts = {
      inverses = {
        ["start"] = "stop",
      },
      remove_default_keybinds = true,
    },
    config = function(_, opts)
      require("nvim-toggler").setup(opts)
    end,
    keys = {
      {
        "<leader>i",
        function()
          require("nvim-toggler").toggle()
        end,
        mode = { "n", "v" },
        desc = "Invert word",
      },
    },
  },
}
