module drats.term;

import core.stdc.stdlib;
import std.container;

public import drats.color;
import drats.kbd;

enum TerminalFuncs {
  EnterCA, ExitCA,
  ShowCursor, HideCursor,
  ClearScreen,
  SGR, SGR0,
  Underline, Bold, Blink,
  MoveCursor,
  EnterKeypad, ExitKeypad
}

immutable enum CharFlags: ulong
{
	None = 0,
	Normal = (1u-1u),
	Attributes = nbits(~(1u-1u),0),
	CharText = nbits(1u,0) - 1u,
	Color = nbits((1u << 8)-1u,0),
	Standout = nbits(1u,8),
	Underline = nbits(1u,9),
	Reverse = nbits(1u,10),
	Blink = nbits(1u,11),
	Dim = nbits(1u,12),
	Bold = nbits(1u,13),
	AltCharset = nbits(1u,14),
	Invisible = nbits(1u,15),
	Protect = nbits(1u,16),
	Horizontal = nbits(1u,17),
	Left = nbits(1u,18),
	Low = nbits(1u,19),
	Right = nbits(1u,20),
	Top = nbits(1u,21),
	Vertical = nbits(1u,22)
}



ulong nbits(uint mask, ubyte shift) {
	return (mask << (shift + 8));
}
/*****************************
 * 
 */
class Character
{
	Color _fg, _bg;
	CharFlags _attr;
	dchar c;

	this(dchar c = 0, Color fg = Color(255,255,255), Color bg = Color(0,0,0))
	{
		this.c = c;
		this._fg = fg;
		this._bg = bg;
	}



	@property ref CharFlags attr() { return _attr; }
	@property dchar ch() { return c; }
	@property Color fg() { return _fg; }
	@property Color bg() { return _bg; }

	@property Character ch(dchar c) {
		this.c = c;
		return this;
	}

	Character setForeColor(Color f) {
		this._fg = f;
		return this;
	}
	Character setBackColor(Color b) {
		this._bg = b;
		return this;
	}
}


/*****************************
 * 
 */
interface Terminal //(ref string[] k, ref string[] f)
{
  ref string[] keys();
  ref string[] funcs();
  string name();
  void init();

  static char* getType() {
    return getenv("TERM");
  }
	final bool isInFamily(string[] terms...) {
		import std.process;
		import std.string;
		auto term = environment.get("TERM");
		foreach(t; terms)
			if(indexOf(term,t) != -1)
				return true;
		return false;
	}
	enum InputMode { 
		Current, 
		Esc, 
		Alt, 
		Mouse
	}
	enum OutputMode { 
		Current, Normal, Color256, Color216, Grayscale 
	}
	enum OutputType {
		Linear, // want output to work one line at a time?
		Cellular, // want access to term screen as grid of char?
		Grid,
		Table,
		Minimal
	}

	struct Cell {
		int width, height;
		Character * runes;
		immutable enum Flags
		{
			Subwin = (1<<1),
			Endline = (1<<2),
			Fullscreen = (1<<3),
			Scrollwin = (1<<4),
			Pad = (1<<5),
			CursorMoved = (1<<6),
			CursorWrapped = (1<<7)
		}
	}

	static string[string] termcapDB;

//	immutable enum {
//
//	}

}

//Terminal[] terminals;

class Screen : Terminal
{
  this(int l, int c)
	{
		_lines = l;
		_cols = c;
		_tabsz = 4;
		_frontBuffer = new Cell[32];
		_backBuffer = new Cell[32];
	}
//	Screen start()
//	{
//		Screen retval = Screen(80,40);
//		init();
//		return retval;
//	}
  override void init()
  {

  }
	Key getKey()
	{
		return cast(Key)0u;
	}

  @property override ref string[] keys() {
    return _keys;
  }
  @property override string name() { return "screen"; }
  @property override ref string[] funcs() {
    return _funcs;
  }
  static string[] _keys = [
    "\033OP","\033OQ","\033OR","\033OS","\033[15~","\033[17~","\033[18~","\033[19~","\033[20~","\033[21~","\033[23~","\033[24~","\033[2~","\033[3~","\033[1~","\033[4~","\033[5~","\033[6~","\033OA","\033OB","\033OD","\033OC"
  ];
  static string[] _funcs = [
    "\033[?1049h",
    "\033[?1049l",
    "\033[34h\03[?25h",
    "\033[?25l",
    "\033[H\033[J",
    "\033[3%u;4%um",
    "\033[m",
    "\033[4m",
    "\033[1m",
    "\033[5m",
    "\033[%u;%uH",
    "\033[?1h\033=",
    "\033[?1l\033>"
  ];

	int _lines, _cols, _tabsz;
	int _lastx = -1, _lasty = -1;
	int _cursorx = -1, _cursory = -1;

	InputMode imode = InputMode.Esc;
	OutputMode omode = OutputMode.Normal;
	Cell[] _frontBuffer, _backBuffer;
}
//terminals ~= Screen;

/**
 *
 */
class XTerm : Terminal
{
	override void init()
	{}
  @property override ref string[] keys() { return _keys; }
  @property override ref string[] funcs() { return _funcs; }
  @property override string name() { return "xterm"; }

  static string[] _keys = ["\033OP","\033OQ","\033OR","\033OS","\033[15~","\033[17~","\033[18~","\033[19~","\033[20~","\033[21~","\033[23~","\033[24~","\033[2~","\033[3~","\033OH","\033OF","\033[5~","\033[6~","\033OA","\033OB","\033OD","\033OC"
];
  static string[] _funcs = [
    "\033[?1049h",
    "\033[?1049l",
    "\033[?12l\033[?25h",
    "\033[?25l",
    "\033[H\033[2J",
    "\033[3%u;4%um",
    "\033(B\033[m",
    "\033[4m",
    "\033[1m",
    "\033[5m",
    "\033[%u;%uH",
    "\033[?1h\033=",
    "\033[?1l\033>"
  ];
}

/**
 *
 */
class LinuxTerm : Terminal
{
	override void init()
	{}

  @property override ref string[] keys() { return _keys; }
  @property override ref string[] funcs() { return _funcs; }
  @property override string name() { return "linux"; }

  static string[] _keys = [	"\033[[A","\033[[B","\033[[C","\033[[D","\033[[E","\033[17~","\033[18~","\033[19~","\033[20~","\033[21~","\033[23~","\033[24~","\033[2~","\033[3~","\033[1~","\033[4~","\033[5~","\033[6~","\033[A","\033[B","\033[D","\033[C"
];
  static string[] _funcs = [
    "",
    "",
    "\033[?25h\033[?0c",
    "\033[?25l\033[?1c",
    "\033[H\033[J",
    "\033[3%u;4%um",
    "\033[0;10m",
    "\033[4m",
    "\033[1m",
    "\033[5m",
    "\033[%u;%uH",
    "",
    ""
  ];
}
