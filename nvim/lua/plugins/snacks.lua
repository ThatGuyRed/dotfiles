return {
   "folke/snacks.nvim",
   priority = 1000,
   lazy = false,
   ---@type snacks.Config
   opts = {
      explorer = { enabled = false },
      ---@type table<string, snacks.win.Config>
      styles = {
	      terminal = { height = 0.2 },
	      explorer = { width = 0.3}
      }
   }

}

