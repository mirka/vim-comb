# vim-comb

vim-comb is a vim bridge to [csscomb.js](https://github.com/csscomb/csscomb.js), a coding style formatter for CSS (and its various pre-processors). csscomb.js replaces the deprecated [csscomb](https://github.com/csscomb/csscomb).

## Requirements

You will need csscomb.js installed, which is a [node.js](http://nodejs.org/) package. On Mac OS X with [homebrew](http://brew.sh/) installed, you can get set up with:

```
brew install node
npm install -g csscomb
```

## Installation

### With vim-plug

Add this to `.vimrc`:

```vim
Plug 'danhodos/vim-comb'
```

and run `:PlugInstall`

### With Pathogen

```
cd ~/.vim/bundle
git clone https://github.com/danhodos/vim-comb.git
```

## Usage

When in a CSS (or a CSS-like file, e.g. [SCSS](http://sass-lang.com/)), you can run `:CSScomb` to format the entire file. You can also visually select a range (e.g. a selector, perhaps with `vas`) and run `:CSScomb` to just format that range.

This plugin does not add any mappings for you, but you can feel free to add your own. I use the following in my `.vimrc`:

```vim
" Run CSScomb against the entire file:
nnoremap <leader>c :CSScomb<CR>

# Run CSS against the visually-selected range:
vnoremap <leader>c :CSScomb<CR>
```

## Configuration

vim-comb will look for a file named `.csscomb.json` in your project directory. If it cannot find a one, it will use a stock pre-defined configuration file.

The format of the `.csscomb.json` file is [documented on the CSScomb site](http://csscomb.com/docs/options.md).

## Acknowledgments

The vim portion of this plugin was originally based on that of [vim-csscomb](https://github.com/csscomb/vim-csscomb).
