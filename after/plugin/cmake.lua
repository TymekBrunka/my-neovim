vim.cmd([[nnoremap <F5> :wa <bar> :set makeprg=cd\ build\ &&\ cmake\ ..\ -DCMAKE_BUILD_TYPE=debug\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1\ &&\ cmake\ ..\ &&\ cmake\ --build\ . <bar> :compiler gcc <bar> :make <CR>]])


