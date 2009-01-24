" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Remover beep de consola
set vb
" Fazer hilight dos searches
set hlsearch

" Mostrar numeracao
set nu

" F3 para entrar em modo paste, para fazer paste de codigo ja indentado
set pastetoggle=<F3>

" Configuracoes para Python

set softtabstop=4 shiftwidth=4  " default character indentation level
set tabstop=4
set expandtab
set autoindent
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Remover whitespace no fim das linhas
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" Transformar tabs em espaços
autocmd BufWritePre *.py normal 1,$retab!

" Activar auto completacao (Ctrl - X O)

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Funcao MyGrep. Para procurar ocurrencias de uma palavra, num ficheiro, ou pasta
" sintaxe: MyGrep <options> <pattern> <dir>
" Exemplo: :MyGrep -r "cow" ~/Desktop/*

function! MyGrep(...)
  if a:0 < 2
    echo "Usage: MyGrep <options> <pattern> <dir>"
    echo 'Example: MyGrep -r "cow" ~/Desktop/*'
    return
  endif
  if a:0 == 2
    let options = '-rsinI'
    let pattern = a:1
    let dir = a:2
  else
    let options = a:1 . 'snI'
    let pattern = a:2
    let dir = a:3
  endif
  let exclude = 'grep -v "/.svn"'
  let cmd = 'grep '.options.' '.pattern.' '.dir. '| '.exclude
  let cmd_output = system(cmd)
  if cmd_output == ""
    echomsg "Pattern " . pattern . " not found"
    return
  endif

  let tmpfile = tempname()
  exe "redir! > " . tmpfile
  silent echon '[grep search for "'.pattern.'" with options "'.options.'"]'."\n"
  silent echon cmd_output
  redir END

  let old_efm = &efm
  set efm=%f:%\\s%#%l:%m

  execute "silent! cgetfile " . tmpfile
  let &efm = old_efm
  botright copen

  call delete(tmpfile)
endfunction
command! -nargs=* -complete=file MyGrep call MyGrep(<f-args>)

" For use in Bash support
let g:BASH_AuthorName   = 'Rolando Pereira'
let g:BASH_Email        = 'finalyugi@sapo.pt'
"let g:BASH_Company      = 'Company Name'

" Fechar um buffer, mas deixando a janela aberta.
" Put this into .vimrc or make it a plugin.
" Mapping :Bclose to some keystroke would probably be more useful.
" I like the way buflisted() behaves, but some may like the behavior
" of other buffer testing functions.

command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
let l:currentBufNum = bufnr("%")
let l:alternateBufNum = bufnr("#")

if buflisted(l:alternateBufNum)
buffer #
else
bnext
endif

if bufnr("%") == l:currentBufNum
new
endif

if buflisted(l:currentBufNum)
execute("bdelete ".l:currentBufNum)
endif
endfunction 


" Ctrl + D mostra as opcoes quando se esta a usar command-line completation
set wildmenu
"set wildmode=list:longest

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*
 

"Get out of VI's compatible mode..
set nocompatible

"Enable filetype plugin
filetype plugin on
filetype indent on

set background=dark
colorscheme koehler

set fileformat=unix " The Right Way(tm)

" this takes effect when the syntax file is loaded
let python_highlight_all=1

augroup Python
    au FileType python set comments=b:# 
    " turn off the C preprocessor indenting
    " (allow comments to be indented properly)
    au FileType python inoremap # X#
    au FileType python set foldmethod=indent
    " do I want everything collapsed when I open the file?
    "au FileType python set foldenable
    au FileType python set nofoldenable
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Always show current position
set ruler

"The commandbar is 2 high
"set cmdheight=2


"Set magic on
set magic

  """"""""""""""""""""""""""""""
  " => Statusline
  """"""""""""""""""""""""""""""
  "Always hide the statusline
  set laststatus=2

  function! CurDir()
     let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
     return curdir
  endfunction

  "Format the statusline
  set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

""""""""""""""""""""""""""""""
" => Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /
map <c-space> ?

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows
"Bclose function ca be found in "Buffer related" section
nmap <leader>bd :Bclose<cr>
" Only in Gvim
nmap <m-down> <leader>bd
"Use the arrows to something usefull
nmap <right> :bn<cr>
nmap <left> :bp<cr>

"Tab configuration
nmap <F5> :tabnew <cr>
nmap <F6> :tabclose<cr>
nmap <F7> :tabp<cr>
nmap <F8> :tabn<cr>
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set completeopt=menu,preview

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  if g:cmd == g:cmd_edited
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>

cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set smarttab
set lbr
set tw=500

   """"""""""""""""""""""""""""""
   " => Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   set ai

   "Smart indet
   set si

   "C-style indeting
   set cindent

   "Wrap lines
   set wrap
   
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   """"""""""""""""""""""""""""""
   " => File explorer
   """"""""""""""""""""""""""""""
   "Split vertically
   let g:explVertical=1

   "Window size
   let g:explWinSize=35

   let g:explSplitLeft=1
   let g:explSplitBelow=1

   "Hide some files
   let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$'

   "Hide the help thing..
   let g:explDetailedHelp=0
   
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   """"""""""""""""""""""""""""""
   " => HTML related
   """"""""""""""""""""""""""""""
   " HTML entities - used by xml edit plugin
   let xml_use_xhtml = 1
   "let xml_no_auto_nesting = 1

   "To HTML
   let html_use_css = 1
   let html_number_lines = 0
   let use_xhtml = 1

   """"""""""""""""""""""""""""""
   " => Python section
   """"""""""""""""""""""""""""""
   "Run the current buffer in python - ie. on leader+space
"   au FileType python so ~/vim_local/syntax/python.vim
   autocmd FileType python map <buffer> <leader><space> :w!<cr>:!python %<cr>
"   autocmd FileType python so ~/vim_local/plugin/python_fold.vim

   "Set some bindings up for 'compile' of python
   autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
   autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

   "Python iMaps
   au FileType python set cindent
   au FileType python inoremap <buffer> $r return 
   au FileType python inoremap <buffer> $s self 
   au FileType python inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
   au FileType python inoremap <buffer> $i import 
   au FileType python inoremap <buffer> $p print 
   au FileType python inoremap <buffer> $d """<cr>"""<esc>O

   "Run in the Python interpreter
   function! Python_Eval_VSplit() range
     let src = tempname()
     let dst = tempname()
     execute ": " . a:firstline . "," . a:lastline . "w " . src
     execute ":!python " . src . " > " . dst
     execute ":pedit! " . dst
   endfunction
   au FileType python vmap <F7> :call Python_Eval_VSplit()<cr> 
   
""""""""""""""""""""""""""""""
" => Snippets
"""""""""""""""""""""""""""""""
   "You can use <c-j> to goto the next <++> - it is pretty smart ;)

   """""""""""""""""""""""""""""""
   " => Python
   """""""""""""""""""""""""""""""
   autocmd FileType python inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("def <++>(<++>):\n<++>\nreturn <++>")<cr>
   autocmd FileType python inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for <++> in <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>\nelse:\n<++>")<cr>
   
   """""""""""""""""""""""""""""""
   " => HTML
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah,html inorea <buffer> cahref <c-r>=IMAP_PutTextWithMovement('<a href="<++>"><++></a>')<cr>
   autocmd FileType cheetah,html inorea <buffer> cbold <c-r>=IMAP_PutTextWithMovement('<b><++></b>')<cr>
   autocmd FileType cheetah,html inorea <buffer> cimg <c-r>=IMAP_PutTextWithMovement('<img src="<++>" alt="<++>" />')<cr>
   autocmd FileType cheetah,html inorea <buffer> cpara <c-r>=IMAP_PutTextWithMovement('<p><++></p>')<cr>
   autocmd FileType cheetah,html inorea <buffer> ctag <c-r>=IMAP_PutTextWithMovement('<<++>><++></<++>>')<cr>
   autocmd FileType cheetah,html inorea <buffer> ctag1 <c-r>=IMAP_PutTextWithMovement("<<++>><cr><++><cr></<++>>")<cr>
   
   "Presse c-q insted of space (or other key) to complete the snippet
   imap <C-q> <C-]>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"A function that inserts links & anchors on a TOhtml export.
" Notice:
" Syntax used is:
"   *> Link
"   => Anchor
function! SmartTOHtml()
   TOhtml
   try
    %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
    %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
    %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
   catch
   endtry
   exe ":write!"
   exe ":bd"
endfunction

    " REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
    filetype plugin on
    
    " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
    " can be called correctly.
    set shellslash
    
    " IMPORTANT: grep will sometimes skip displaying the file name if you
    " search in a singe file. This will confuse Latex-Suite. Set your grep
    " program to alway generate a file-name.
    set grepprg=grep\ -nH\ $*
    
    " OPTIONAL: This enables automatic indentation as you type.
    filetype indent on

" RELOAD LAST SESSION!
"######################################################

function! MakeSession()
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    if (filewritable(b:sessiondir) != 2)
        exe 'silent !mkdir -p ' b:sessiondir
        redraw!
    endif
    let b:filename = b:sessiondir . '/session.vim'
    let _dir = expand("%:p:h")
    if _dir != '^/home/rolando'
        exe "mksession! " . b:filename
    endif
endfunction

function! LoadSession()
    let b:sessiondir  = $HOME . "/.vim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
        exe 'source ' b:sessionfile
    else
        echo "No session loaded."
    endif
endfunction

" Comment, it can give erroes when using crontab -e
"au VimEnter * :call LoadSession()
"map ,l :call LoadSession()<cr>
"map ,m :call MakeSession()<cr>
"au VimLeave * :call MakeSession()

"###################################################### 

" Make the HTML.vim file insert lowercase tags when in gvim
let g:html_tag_case = 'lowercase'

" Common typos
command! Q quit
command! W write
command! Wq wq
command! Qa qa

let mapleader = ","

" reading Ms-Word documents, requires antiword
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"

set foldmethod=manual
set foldcolumn=5

set iskeyword+=.

"autocmd BufEnter * :syntax sync fromstart

" Source vimsh on-demand
"nmap <Leader>sh :source ~/.vim/vimsh/vimsh.vim<cr>
set cul

"function! CHANGE_CURR_DIR()
"exec "cd %:p:h"
"endfunction

"autocmd BufEnter * call CHANGE_CURR_DIR() 

set autochdir

"set sessionoptions=blank,buffers,curdir,folds,help,tabpages,options
"map <c-q> :mksession! ~/.vim/.session <cr>
"map <c-s> :source ~/.vim/.session <cr>

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Undoing in Insert Mode (Control-Z)
"map <c-z> <c-o>u
"Actually scrolls to other files

let g:Tex_ViewRule_dvi = 'xdvi'
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_GotoError = 0
"let g:Imap_FreezeImap = 1

set history=1000
set scrolloff=3

" Aumentar a velocidade do scroll
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Intuitive backspacing in insert mode
set backspace=indent,eol,start
nmap <silent> <leader>n :silent :nohlsearch<CR>

"Para fazer login no sapo
"Nread ftp://rolando.do.sapo.pt@ftp.homepages.sapo.pt/

" Vim code for .vimrc file
" Maintainer: Carl Mueller, cmlr@math.rochester.edu
" Last Change:  March 6, 2007
" Version:  1.2
"
"In xemacs, or emacs if you have it enabled, you can speed up copying and 
"pasting.  Select some text with the left mouse button, while pressing the 
"control key.  The selected text will be copied and pasted to the original 
"position of the cursor.  This saves time in moving the cursor.  Also, the
"same action with the shift key instead of the control key moves the
"selected text instead of copying it.  Put the following code in your .vimrc.

" Shift-left mouse drag moves text, xemacs style.
inoremap <S-LeftMouse> <C-R>=<SID>LeftMouseMap()<CR><LeftMouse>
inoremap <S-Leftdrag> <Leftdrag>
vnoremap <S-Leftdrag> <Leftdrag>
vnoremap <S-LeftRelease> <LeftRelease>x:call <SID>LeftReleaseMap()<CR><C-R>"

" Control-left mouse drag copies and pastes, xemacs style.
inoremap <C-LeftMouse> <C-R>=<SID>LeftMouseMap()<CR><LeftMouse>
inoremap <C-Leftdrag> <Leftdrag>
vnoremap <C-Leftdrag> <Leftdrag>
vnoremap <C-LeftRelease> <LeftRelease>y:call <SID>LeftReleaseMap()<CR><C-R>"
function! s:LeftMouseMap()
    let g:thisline=line('.')
    let g:thiscol=virtcol('.')
    if g:thiscol == strlen(getline(g:thisline))+1
    let g:atend=1
    else
    let g:atend=0
    endif
    return ""
endfunction
function! s:LeftReleaseMap()
    exe 'normal '.g:thisline.'G0'.g:thiscol.'|'
    if g:atend == 1
    startinsert!
    else
    startinsert
    endif
    return ""
endfunction

" For obviousmode.vim
set laststatus=2
""""

