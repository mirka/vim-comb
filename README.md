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

Because vim-comb is implemented using a `formatexpr` that is set for CSS (and CSS-like files, e.g. [SCSS](http://sass-lang.com/)), you can use the standard `gq` with a motion (or after making a visual selection) to format your code through csscomb.js.

If csscomb.js returns an error (say, for instance, if you encounter [this problem](https://github.com/csscomb/csscomb.js/issues/275)), then the error will be displayed without changing the contents of the buffer.

## Configuration

vim-comb will look for a file named `.csscomb.json` in your project directory. If it cannot find one, it will use a stock pre-defined configuration file.

The format of the `.csscomb.json` file is [documented on the CSScomb site](http://csscomb.com/docs/options.md).

## Acknowledgments

The vim portion of this plugin was originally based on that of [vim-csscomb](https://github.com/csscomb/vim-csscomb).
