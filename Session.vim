let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +2 ~/.config/nvim/.gitignore
badd +1 ~/.config/nvim/config/lua/config/visuals.lua
badd +6 ~/.config/nvim/config/lua/config/opts.lua
badd +40 ~/.config/nvim/config/lua/config/editor_support.lua
badd +12 ~/.config/nvim/config/lua/config/init.lua
badd +2 ~/.config/nvim/.stylua.toml
badd +21 ~/.config/nvim/config/lua/config/lsp.lua
badd +1 ~/.config/nvim/config/lua/config/navigation_keybinds.lua
badd +22 ~/.config/nvim/config/lua/config/neotree.lua
badd +1 ~/.config/nvim/config/lua/config/plug.lua
badd +1 ~/.config/nvim/config/lua/config/rainbow_delimiters.lua
badd +1 ~/.config/nvim/config/lua/config/text_editing.lua
badd +21 ~/.config/nvim/config/lua/config/debugging.lua
badd +4 ~/.config/nvim/plugins/neo-tree.nvim/lua/neo-tree/ui/highlights.lua
argglobal
%argdel
edit ~/.config/nvim/plugins/neo-tree.nvim/lua/neo-tree/ui/highlights.lua
argglobal
balt ~/.config/nvim/config/lua/config/neotree.lua
setlocal foldmethod=manual
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 48 - ((42 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 48
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
