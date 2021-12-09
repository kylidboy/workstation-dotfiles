require'nvim-treesitter.configs'.setup {
  -- List of languages we want parsers to always be installed
  ensure_installed = {"html", "javascript", "lua", "rust", "go", "typescript"}, 
  -- You can also install all the parsers by changing the value to {"all"} or {"maintained"}
  -- Enable Syntax Highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- Disables default vim regex highlighting
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autopairs = {
    enable = true
  }
}
