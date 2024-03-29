return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      store_selection_keys = "<Tab>",
    },
    keys = {
      { "<tab>", nil, mode = "v" },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        function()
          require("spider").motion("w")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "e",
        function()
          require("spider").motion("e")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "b",
        function()
          require("spider").motion("b")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "ge",
        function()
          require("spider").motion("ge")
        end,
        mode = { "n", "x", "o" },
      },
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    keys = {
      {
        "aS",
        function()
          require("various-textobjs").subword(false)
        end,
        mode = { "o", "x" },
        desc = "a subword (with white space)",
      },
      {
        "iS",
        function()
          require("various-textobjs").subword(true)
        end,
        mode = { "o", "x" },
        desc = "inner subword",
      },
      {
        "aL",
        function()
          require("various-textobjs").lineCharacterwise(false)
        end,
        mode = { "o", "x" },
        desc = "current line (with indentation and trailing spaces)",
      },
      {
        "iL",
        function()
          require("various-textobjs").lineCharacterwise(true)
        end,
        mode = { "o", "x" },
        desc = "current line",
      },
      {
        "gG",
        function()
          require("various-textobjs").entireBuffer()
        end,
        mode = { "o", "x" },
        desc = "entire buffer as one text object",
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "uga-rosa/cmp-dictionary",
        opts = {
          paths = { vim.fn.stdpath("config") .. "/assets/american-english" },
          first_case_insensitive = true,
        },
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local sources = vim.list_extend(opts.sources, {
        {
          name = "dictionary",
          keyword_length = 2,
        },
      })
      for _, src in pairs(sources) do
        if src.name == "buffer" then
          src.option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          }
        end
      end
      opts.sources = cmp.config.sources(sources)
    end,
  },
  {
    "JuanZoran/Trans.nvim",
    build = function()
      require("Trans").install()
    end,
    keys = {
      -- 可以换成其他你想映射的键
      { "mm", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = " Translate" },
      { "mk", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
      -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
      { "mi", "<Cmd>TranslateInput<CR>", desc = " Translate From Input" },
    },
    dependencies = { "kkharji/sqlite.lua" },
    config = true,
  },
  {
    "cappyzawa/trim.nvim",
    config = true,
    cmd = {
      "TrimToggle",
      "Trim",
    },
    event = "LazyFile",
    keys = {
      { "<leader>u<space>", "<Cmd>TrimToggle<CR>", desc = "Toggle trim on save" },
    },
  },
  {
    "ojroques/nvim-osc52",
    event = "LazyFile",
    opts = { silent = true },
    config = function(_, opts)
      local osc52 = require("osc52")
      osc52.setup(opts)
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          if vim.v.event.operator == "y" and (vim.v.event.regname == "+" or vim.v.event.regname == "") then
            osc52.copy_register(vim.v.event.regname)
          end
        end,
      })
    end,
  },
}
