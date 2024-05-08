return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup {
      -- Recommended - see "Configuring" below for more config options
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
      terminal_colors = true,
      colors = {
        -- For a list of colors see `lua/cyberdream/colours.lua`
        -- Example:
        bg = "#000000",
        green = "#00ff00",
        magenta = "#ff00ff",
      },
    }
    vim.cmd "colorscheme cyberdream" -- set the colorscheme
  end,
}
