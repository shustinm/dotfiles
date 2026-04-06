return {
  {
    "FabijanZulj/blame.nvim",
    cmd = "BlameToggle",
    keys = {
      { "<leader>ga", "<cmd>BlameToggle<cr>", desc = "Git Annotations" },
    },
    opts = {
      format_fn = function(line_porcelain, config, idx)
        local now = os.time()
        local age_days = (now - line_porcelain.author_time) / 86400

        local hl
        if age_days < 7 then
          hl = "BlameRecent"
        elseif age_days < 30 then
          hl = "BlameMonth"
        elseif age_days < 180 then
          hl = "BlameHalfYear"
        else
          hl = "BlameOld"
        end

        local date = os.date(config.date_format, line_porcelain.author_time)
        return {
          idx = idx,
          values = {
            { textValue = line_porcelain.hash:sub(1, 8), hl = hl },
            { textValue = date, hl = hl },
            { textValue = line_porcelain.author, hl = hl },
          },
          format = "%s %s %s",
        }
      end,
    },
    init = function()
      vim.api.nvim_set_hl(0, "BlameRecent", { fg = "#50fa7b" })
      vim.api.nvim_set_hl(0, "BlameMonth", { fg = "#f1fa8c" })
      vim.api.nvim_set_hl(0, "BlameHalfYear", { fg = "#ffb86c" })
      vim.api.nvim_set_hl(0, "BlameOld", { fg = "#6272a4" })
    end,
  },
}
