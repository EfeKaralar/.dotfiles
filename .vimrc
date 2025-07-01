" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" Download Plugins
" if filereadable('./vimrc.plug')
"     silent! source './vimrc.plug'
" endif

" Start call
call plug#begin('~/.config/vim/autoload/plug.vim')

" Asyncheonous Lint Engine (Syntax Checking and Semantic Errors)
Plug 'dense-analysis/ale'

" LLM Integration into VIM
Plug 'madox2/vim-ai'
Plug 'madox2/vim-ai-provider-google'

" Deoplete - Autocomplete
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

" Markdown support
Plug 'plasticboy/vim-markdown'

" Writing-focused features
Plug 'junegunn/goyo.vim'          " Distraction-free writing
Plug 'junegunn/limelight.vim'     " Paragraph highlighting
Plug 'reedes/vim-pencil'          " Better text editing
Plug 'reedes/vim-wordy'           " Writing analysis

" File management
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'

" End call
call plug#end()

" Customize Plugins
"
"
" ALE (Linting and fixing) --------
" Set linters here
let g:ale_linter = {'python' : ['flake8'], 'c' : ['cc'],}
" Set fixers here
let g:ale_fixers = {'*' : ['remove_trailing_lines', 'trim_whitespace'], 'python': ['black'], 'javascript': ['eslint', 'prettier']}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

" VIM AI (LLM Integration) -------
let g:vim_ai_token_file_path = '~/config/gemini.token'
let g:vim_ai_roles_config_file = '~/.config/roles.ini'

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Set leader key to space for easier access
let mapleader = " "

" Mappings code goes here.

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" Set custom color scheme
colorscheme evening

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Add relative line numbers to each line on the left-hand side
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs
set expandtab

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Set jj to Escape for easier reach when entering vim
inoremap jj <esc>

" Universal copying
set clipboard^=unnamedplus

" Splits open at the bottom and right
set splitbelow splitright

" Hide hidden files in netrw (gh to toggle)
let g:netrw_hide = 1

" SIMPLE WRITING SETTINGS FOR MARKDOWN
augroup writing
    autocmd!
    " Enable spell checking for markdown files
    autocmd FileType markdown setlocal spell spelllang=en_us

    " Enable soft line wrapping (visual only, no line breaks inserted)
    autocmd FileType markdown setlocal wrap linebreak

    " Set text width to 80 for paragraph formatting with gq
    autocmd FileType markdown setlocal textwidth=80

    " Use 2-space indentation for markdown (better for lists)
    autocmd FileType markdown setlocal shiftwidth=2 tabstop=2
augroup END

" AUTOMATIC GIT SYNC FOR NOTES
" Function to get the standard Documents directory across systems
function! GetDocumentsDir()
    " Try XDG user directory first (most reliable cross-platform)
    let xdg_docs = system('xdg-user-dir DOCUMENTS 2>/dev/null')
    if v:shell_error == 0 && !empty(trim(xdg_docs))
        return trim(xdg_docs)
    endif

    " Fallback to common paths
    if isdirectory(expand('~/Documents'))
        return expand('~/Documents')
    elseif isdirectory(expand('~/Docs'))
        return expand('~/Docs')
    else
        " Last resort - assume Documents
        return expand('~/Documents')
    endif
endfunction

" Function to sync Notes directory with git
function! SyncNotes()
    let docs_dir = GetDocumentsDir()
    let notes_dir = docs_dir . '/Notes'

    " Check if Notes directory exists and is a git repo
    if !isdirectory(notes_dir)
        echo "Notes directory not found at: " . notes_dir
        return
    endif

    if !isdirectory(notes_dir . '/.git')
        echo "Notes directory is not a git repository"
        return
    endif

    " Save current directory
    let current_dir = getcwd()

    try
        " Change to Notes directory
        execute 'cd ' . fnameescape(notes_dir)

        " Pull latest changes
        echo "Pulling latest changes..."
        let pull_result = system('git pull')
        if v:shell_error != 0
            echo "Git pull failed: " . pull_result
            return
        endif

        " Add all changes
        call system('git add .')

        " Check if there are changes to commit
        let status_result = system('git status --porcelain')
        if !empty(trim(status_result))
            " Commit changes with timestamp
            let commit_msg = "Auto-sync from " . hostname() . " on " . strftime("%Y-%m-%d %H:%M:%S")
            let commit_result = system('git commit -m "' . commit_msg . '"')
            if v:shell_error != 0
                echo "Git commit failed: " . commit_result
                return
            endif

            " Push changes
            echo "Pushing changes..."
            let push_result = system('git push')
            if v:shell_error != 0
                echo "Git push failed: " . push_result
                return
            endif

            echo "Notes synced successfully!"
        else
            echo "Notes are up to date"
        endif

    finally
        " Restore original directory
        execute 'cd ' . fnameescape(current_dir)
    endtry
endfunction

" Auto-sync when opening/closing files in Notes directory
augroup notes_sync
    autocmd!
    " Sync when entering a file in Notes directory
    autocmd BufEnter * if expand('%:p') =~ GetDocumentsDir() . '/Notes' | call SyncNotes() | endif
    " Sync when writing a file in Notes directory
    autocmd BufWritePost * if expand('%:p') =~ GetDocumentsDir() . '/Notes' | call SyncNotes() | endif
augroup END

" Manual sync command
command! NotesSync call SyncNotes()

" DOTFILES AUTO-SYNC (for existing ~/.dotfiles directory)
" Function to sync dotfiles directory with git
function! SyncDotfiles()
    let dotfiles_dir = expand('~/.dotfiles')

    " Check if dotfiles directory exists and is a git repo
    if !isdirectory(dotfiles_dir)
        echo "Dotfiles directory not found at: " . dotfiles_dir
        return
    endif

    if !isdirectory(dotfiles_dir . '/.git')
        echo "Dotfiles directory is not a git repository"
        return
    endif

    " Save current directory
    let current_dir = getcwd()

    try
        " Change to dotfiles directory
        execute 'cd ' . fnameescape(dotfiles_dir)

        " Pull latest changes
        echo "Pulling latest dotfiles changes..."
        let pull_result = system('git pull')
        if v:shell_error != 0
            echo "Git pull failed: " . pull_result
            return
        endif

        " Add all changes
        call system('git add .')

        " Check if there are changes to commit
        let status_result = system('git status --porcelain')
        if !empty(trim(status_result))
            " Commit changes with timestamp
            let commit_msg = "Auto-sync dotfiles from " . hostname() . " on " . strftime("%Y-%m-%d %H:%M:%S")
            let commit_result = system('git commit -m "' . commit_msg . '"')
            if v:shell_error != 0
                echo "Git commit failed: " . commit_result
                return
            endif

            " Push changes
            echo "Pushing dotfiles changes..."
            let push_result = system('git push')
            if v:shell_error != 0
                echo "Git push failed: " . push_result
                return
            endif

            echo "Dotfiles synced successfully!"
        else
            echo "Dotfiles are up to date"
        endif

    finally
        " Restore original directory
        execute 'cd ' . fnameescape(current_dir)
    endtry
endfunction

" DOTFILES SYMLINK HELPER
" Function to move file to dotfiles and create symlink
function! DotfilesLink(filename)
    let dotfiles_dir = expand('~/.dotfiles')
    let home_file = expand('~/' . a:filename)
    let dotfiles_file = dotfiles_dir . '/' . a:filename

    " Check if dotfiles directory exists
    if !isdirectory(dotfiles_dir)
        echo "Dotfiles directory not found at: " . dotfiles_dir
        return
    endif

    " Check if file exists in home directory
    if !filereadable(home_file) && !isdirectory(home_file)
        echo "File not found: " . home_file
        return
    endif

    " Check if file already exists in dotfiles
    if filereadable(dotfiles_file) || isdirectory(dotfiles_file)
        echo "File already exists in dotfiles: " . dotfiles_file
        echo "Remove it first or use a different name"
        return
    endif

    " Move file to dotfiles directory
    let move_result = system('mv ' . shellescape(home_file) . ' ' . shellescape(dotfiles_file))
    if v:shell_error != 0
        echo "Failed to move file: " . move_result
        return
    endif

    " Create symlink back to home directory
    let link_result = system('ln -s ' . shellescape(dotfiles_file) . ' ' . shellescape(home_file))
    if v:shell_error != 0
        echo "Failed to create symlink: " . link_result
        " Try to move file back
        call system('mv ' . shellescape(dotfiles_file) . ' ' . shellescape(home_file))
        return
    endif

    echo "Successfully linked " . a:filename . " to dotfiles"
endfunction

" Auto-sync dotfiles when saving files that might be in dotfiles directory
augroup dotfiles_sync
    autocmd!
    " Sync when saving common dotfiles
    autocmd BufWritePost ~/.vimrc,~/.bashrc,~/.scripts/*,~/.dotfiles/* call SyncDotfiles()
augroup END

" Manual sync command
command! DotfilesSync call SyncDotfiles()

" Command to link files to dotfiles
command! -nargs=1 DotfilesLink call DotfilesLink(<q-args>)

" Goyo settings for distraction-free writing
let g:goyo_width = 100
let g:goyo_height = 90

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
