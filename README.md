# ANSIToHTML

ANSIToHTML is a command line tool which converts ANSI (VT100) code to HTML. The
idea is to provide an easy way to show a bunch of code taken from the terminal
on a website. It is not about syntax highlight but about rendering exactly what
is displayed on your screen when you use your terminal.

## Get started

1. Make sure [ocamlbuild](https://ocaml.org/learn/tutorials/ocamlbuild/) is
   installed on your system
2. Clone this repository
3. Run `make` to compile ANSIToHTML

That's it !

## Usage

It is quite simple: assuming the files `file1`, `file2`, ... contain valid ANSI
code, run

    ansitohtml [-s] -i file1 -i file2 ... -o output_file.html

to produce a nice HTML output similar to what a VT100 terminal would display.  
If set, the `-s` optional argument tells ANSIToHTML to produce a standalone HTML
file. If not set, only a `<pre>` HTML element will be produced.

_NB:_ on Unix platforms, ANSI code can be obtained with the `script` utility.

* A complete example:

    prompt> script
    Script started, output file is typescript
   
    prompt> ... [you type whatever you want...]
    prompt> exit
    Script done, output file is typescript
   
    ansitohtml -i typescript -o my-session.html

* An other example: run `make test` to see another example using the files
  given in `test/`

## And then

This is still a work in progress so please let me know about any remarks, bugs,
possible enhancements and do not hesitate to tell me if it has been useful to
you !

