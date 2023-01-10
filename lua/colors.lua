local color = function(name, value)
  vim.api.nvim_set_hl(0, name, value)
end

color('GruvboxOrange', { fg = '#fe8019' })
color('GruvboxBlue', { fg = '#458588' })
