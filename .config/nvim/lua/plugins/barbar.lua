vim.g.barbar_auto_setup = false

require'barbar'.setup {
  animation = false,
  clickable = false,
  sidebar_filetypes = {
    NvimTree = true,
  }
}

require'barbar.api'.set_offset(31, "File Tree")
