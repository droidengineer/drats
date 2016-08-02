module drats.kbd;

// Taken from termbox for portability.
enum Key : uint
{
  F1 = 0xFFFF,
  F2 = (0xffff-1),
  F3 = (0xffff-2),
  F4 = (0xffff-3),
  F5 = (0xffff-4),
  F6 = (0xffff-5),
  F7 = (0xffff-6),
  F8 = (0xffff-7),
  F9 = (0xffff-8),
  F10 = (0xffff-9),
  F11 = (0xffff-10),
  F12 = (0xffff-11),
  Insert = (0xffff-12),
  Delete = (0xffff-13),
  Home = (0xffff-14),
  End = (0xffff-15),
  PgUp = (0xffff-16),
  PgDn = (0xffff-17),
  ArrowUp = (0xffff-18),
  ArrowDown = (0xffff-19),
  ArrowLeft = (0xffff-20),
  ArrowRight = (0xffff-21),
  MouseLeft = (0xffff-22),
  MouseMiddle = (0xffff-23),
  MouseRight = (0xffff-24),
  MouseUp = (0xffff-25),
  MouseWheelUp = (0xffff-26),
  MouseWheelDown = (0xffff-27),
  //
  Backspace = 0x08,
  Tab = 0x09,
  Enter = 0x0D,
  Esc = 0x1B,
  Backslash = 0x1c,
  Slash = 0x1f,
  Underscore = 0x1f,
  Space = 0x20
}
enum KeyMod : uint
{
  None = 0x0,
  Alt = 0x1,
  Ctrl = 0x2,
  Meta = 0x4,
  Motion = 0x8
}

immutable CURSOR_HIDDEN=-1;

