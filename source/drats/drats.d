module drats.drats;

//import core.stdc.signal;
import std.exception;
import drats.kbd;
import drats.ringbuf;
import drats.term;


/*version(__GNU__) || version(__LDC__) {
 immutable SO_IMPORT=__attribute__((visibility("default")));
} else {
  immutable SO_IMPORT="";
}*/
version(linux) {
  import core.sys.posix.termios;
}
version(Win32) {
  import core.sys.windows.termios;
}

class Drats
{
public:

  void init() {}
  void shutdown() {}

 private:

  //Terminal.Cellbuffer _frontBuffer, _backBuffer;
  Ringbuffer!byte _outBuffer, _inBuffer;


}


class DratsUnknownTermException : Exception
{
  this(string s) { super(s); }
}
class DratsOpenTTYFailedException : Exception
{
  this(string s) { super(s); }
}
