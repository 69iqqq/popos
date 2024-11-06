return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = {
      theme = "auto", -- This setting tells lualine to adapt to the active colorscheme
      component_separators = "",
      section_separators = { left = "", right = "" },
    }
    opts.sections = {
      lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
      lualine_b = { "filename", "branch", { "diagnostics", sources = { "nvim_diagnostic" } } },
      lualine_c = { "%=" },
      lualine_x = {},
      lualine_y = { "filetype", "progress" },
      lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
    }
    opts.inactive_sections = {
      lualine_a = { "filename" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    }
    opts.tabline = {}
    opts.extensions = {}
  end,
}
