# DRATS
A terminal console handling library written in pure D in the theme of (n)Curses.

## INTRO
Drats is a functional class library for the D programming language that abstracts the platform-specific terminal controls
and capabilities of the system and provides a simple, intuitive API for the creation and use of console-based (text) user interface
elements. See [curses/ncurses](https://github.com/D-Programming-Deimos/ncurses) or [Termbox](https://github.com/nsf/termbox),[Termbox-go](https://github.com/nsf/termbox-go) for similar projects for other
programming languages.

### Why Drats? Why another text-based interface library?
The first and most widely adopted is the [ncurses](https://en.wikipedia.org/wiki/Ncurses) library. It is written in C and provides
a basic set of terminal handling capabilities. Termbox is similar but strives for even more simplicity of API (it only has 8 public 
functions). I wanted the capabilites to handle text-based consoles in the [D programming language](http://www.dlang.org) without
having to use the C/C++ bindings to access and external library written in those languages; I wanted an implementation written
in pure D. Beyond this, I had a few API extensions I wanted to add to support a slightly more sophisticated terminal handling.

## Supported Terminals
 * ANSI
 * VT100/120
 * IBM 3270
 * xterm
 * xterm-256color
 * screen (character mode)
 * screen (graphics mode)
 * sun-console
 * rxvt

Support for Linux, OSX, and Windows is part of the requirements to be supported (in the order previously listed in importance), although at the time of this writing only Linux support is released.





