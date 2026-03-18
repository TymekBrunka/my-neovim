vim.lsp.config("haxe-language-server",{
  root_markers = { "*.hxml" },
  file_types = {"hx","hxml"},
  before_init = function(params)
    params.initializationOptions = {
      displayArguments = 'compile.hxml'
    };
    end,
  cmd={ 'node', vim.fn.expand('~/Documents/') .. 'haxe-language-server/bin/server.js' },
  settings={
    haxe={
      initializationOptions = {
        displayArguments = "compile.hxml"
      }
    }
  },
  root_dir = vim.fs.root(0,{'*.hxml'})
})
-- vim.lsp.log.set_level('debug');
vim.lsp.enable('haxe-language-server');

vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
callback = function()
  require('nvim-treesitter.parsers').haxe = {
    install_info = {
      url = "https://github.com/tong/tree-sitter-haxe",
      branch = "main",
      -- url = 'https://github.com/zimbulang/tree-sitter-zimbu',
      -- revision = <sha>, -- commit hash for revision to check out; HEAD if missing
      -- -- optional entries:
      -- branch = 'develop', -- only needed if different from default branch
      -- location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
      -- generate = true, -- only needed if repo does not contain pre-generated `src/parser.c`
      -- generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
      queries = 'queries', -- also install queries from given directory
    },
  }
end})
vim.treesitter.language.register('haxe', { 'hx', 'hxml', '*.hx' })
vim.filetype.add({
  pattern = {
    ['.*/*.hx'] = 'haxe',
  },
})

