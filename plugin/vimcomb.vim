" Internal: The directory of this file (e.g. ~/.vim/bundle/vim-comb/plugin)
let s:vimCombPluginDirectory = fnamemodify(expand("<sfile>"), ":h")

" Internal: Used to call a node.js file that wraps csscomb.js.
"
" This function will execute the node.js file, passing the content of the
" selected lines via stdin and the syntax and path to the config file (if
" found) as arguments.
"
" If there are errors, the selected area is replaced with the formatted
" output; otherwise, the errors are displayed.
"
" line1 - The first line number of content
" line2 - The last line number of content
"
" Returns nothing.
function! s:vimComb(line1, line2)
    let configFilePath = fnameescape(fnamemodify('.csscomb.json', ':p'))
    let extension = expand('%:e')
    let nodeFile = fnameescape(s:vimCombPluginDirectory . "/index.js")
    let node_path = "NODE_PATH=" . fnameescape(s:vimCombPluginDirectory . "/../")

    let command = join([node_path, "node", nodeFile, extension, configFilePath], " ")
    let content = join(getline(a:line1, a:line2), "\n")
    let output = system(command, content)
    let lines = split(output, "\n")

    if v:shell_error == 0
        " NOTE: We cannot use `setline` here, because the number of formatted
        " lines may not be the same as the number of unformatted lines.
        execute a:line1 . ',' . a:line2 . 'd'
        call append(a:line1 - 1, lines)
    else
        echo output
    endif
endfunction

" Public: A function that can be used as a `formatexpr` in CSS and CSS-like
" files.
"
" Returns nothing.
function! VimCombFormat()
    if !empty(v:char)
        return 1
    else
        call s:vimComb(v:lnum, v:lnum + v:count - 1)
    endif
endfunction

" Internal: Sets up our custom `formatexpr` function for CSS and CSS-like files.
"
" The original intention was to use `formatprg`, but `formatprg` is a
" global option, and has no local equivalent. There's some debate as to
" whether `formatexpr` is correct or not as well, see:
"
" http://vimcasts.org/episodes/using-external-filter-commands-to-reformat-html/
if has("autocmd")
    autocmd FileType css,scss,sass,less setlocal formatexpr=VimCombFormat()
endif
