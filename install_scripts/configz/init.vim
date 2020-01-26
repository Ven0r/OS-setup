syntax on
filetype plugin indent on
set number
set tabstop=2
set foldmethod=indent
set foldlevelstart=99

autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType javascript setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab

if $VIMENV == 'prev'
	noremap <Space> :n<CR>
	noremap <Backspace> :N<CR>
	set noswapfile
endif

call plug#begin('~/.local/share/nvim/site/plugged')

"visual
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'

call plug#end()

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif







