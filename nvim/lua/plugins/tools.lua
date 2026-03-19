return {
  {
    {
      "stevearc/conform.nvim",
      opts = {},
    },
    {
      "saghen/blink.cmp",
      opts = {
        completion = {
          trigger = { show_on_insert_on_trigger_character = false },
          list = { selection = { preselect = false, auto_insert = false } },
          menu = {
            auto_show = false,
          },
        },
        keymap = {
          ["<Esc>"] = { "hide", "fallback" },
        },
      },
    },
  },
}
