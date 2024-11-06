return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure colors for the terminal
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = "dark", -- Style for sidebars
        floats = "dark", -- Style for floating windows
      },
      sidebars = { "qf", "help" }, -- Darker background for sidebar-like windows
      hide_inactive_statusline = false, -- Keep inactive statuslines visible
      dim_inactive = false, -- Do not dim inactive windows
      lualine_bold = true, -- Bold section headers in lualine

      -- Override specific highlights to make Telescope window transparent
      on_highlights = function(highlights, colors)
        highlights.TelescopeNormal = { bg = "NONE" } -- Background transparent for Telescope
        highlights.TelescopeBorder = { bg = "NONE" } -- Border transparent for Telescope
        highlights.TelescopePromptNormal = { bg = "NONE" } -- Prompt background transparent
        highlights.TelescopeResultsNormal = { bg = "NONE" } -- Results background transparent
        highlights.TelescopePreviewNormal = { bg = "NONE" } -- Preview background transparent
      end,
    },
    config = function(_, opts)
      require("eldritch").setup(opts) -- Initialize the theme with opts
      -- vim.cmd("colorscheme eldritch") -- Set the colorscheme to eldritch
    end,
  },
}
