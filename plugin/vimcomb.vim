let s:vimCombPluginDirectory = fnamemodify(expand("<sfile>"), ":h")

function! s:vimComb(count, line1, line2)
    let configFilePath = fnameescape(fnamemodify('.csscomb.json', ':p'))
    let extension = expand('%:e')
    let nodeFile = fnameescape(s:vimCombPluginDirectory . "/index.js")

    let command = join(["node", nodeFile, extension, configFilePath], " ")
    let content = join(getline(a:line1, a:line2), "\n")
    let output = system(command, content)

    let lines = split(output, "\n")
    call setline(a:line1, lines)
endfunction

command! -nargs=? -range=% CSScomb :call s:vimComb(<count>, <line1>, <line2>, <f-args>)
