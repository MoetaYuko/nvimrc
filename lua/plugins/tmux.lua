return {
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    opts = {
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
    },
    config = function(_, opts)
      require("tmux").setup(opts)

      local keys = {
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
        { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
        { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
        { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
        { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
        { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
        { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
        { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
        { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
        { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
        { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
        { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
        { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
        { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
      }
      keys = require("lazy.core.handler.keys").resolve(keys)
      for _, key in pairs(keys) do
        vim.keymap.set(key.mode, key.lhs, function()
          if vim.env.TMUX then
            require("tmux.copy").sync_registers()
          end
          return key.rhs
        end, {
          desc = key.desc,
          expr = true,
        })
      end

      vim.keymap.set("n", [["]], function()
        if vim.env.TMUX then
          require("tmux.copy").sync_registers()
        end
        require("which-key").show('"', { mode = "n", auto = true })
      end)
      vim.keymap.set("x", [["]], function()
        if vim.env.TMUX then
          require("tmux.copy").sync_registers()
        end
        require("which-key").show('"', { mode = "v", auto = true })
      end)
    end,
    keys = {
      {
        "<A-H>",
        function()
          require("tmux").move_left()
        end,
        desc = "Go to left window",
        remap = true,
      },
      {
        "<A-J>",
        function()
          require("tmux").move_bottom()
        end,
        desc = "Go to lower window",
        remap = true,
      },
      {
        "<A-K>",
        function()
          require("tmux").move_top()
        end,
        desc = "Go to upper window",
        remap = true,
      },
      {
        "<A-L>",
        function()
          require("tmux").move_right()
        end,
        desc = "Go to right window",
        remap = true,
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      "<Plug>(YankyPutAfter)",
      "<Plug>(YankyPutBefore)",
      "<Plug>(YankyGPutAfter)",
      "<Plug>(YankyGPutBefore)",
      "<Plug>(YankyPutIndentAfterLinewise)",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      "<Plug>(YankyPutIndentAfterShiftRight)",
      "<Plug>(YankyPutIndentAfterShiftLeft)",
      "<Plug>(YankyPutIndentBeforeShiftRight)",
      "<Plug>(YankyPutIndentBeforeShiftLeft)",
      "<Plug>(YankyPutAfterFilter)",
      "<Plug>(YankyPutBeforeFilter)",
      { "p", false, mode = { "n", "x" } },
      { "P", false, mode = { "n", "x" } },
      { "gp", false, mode = { "n", "x" } },
      { "gP", false, mode = { "n", "x" } },
      { "]p", false },
      { "[p", false },
      { "]P", false },
      { "[P", false },
      { ">p", false },
      { "<p", false },
      { ">P", false },
      { "<P", false },
      { "=p", false },
      { "=P", false },
    },
  },
}
