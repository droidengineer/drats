module drats.event;

import drats.kbd;

enum EventType { 
	
	Raw = 0,
	Echo = (1<<1),
	Key = (1<<2),
	Resize = (1<<3),
	Mouse = (1<<4),
	Paste = (1<<5),
	ReleasedKeys = (1<<6),
	AllEvents = (Resize|Paste|Mouse)
}
struct Event(EventType t)
{



	this(int i1, int i2)
	{
		_type = t;
		coord.wx = i1;
		coord.hy = i2;
	}

	Tuple!(int,"wx",int,"hy") coord;
	//int w, h, x, y;
	uint ch;
	Key key;
	KeyMod mod;
	Type _type;

	public void attach(SlotFunction fn)
	{
		this._funcs ~= fn;
	}

	private alias void function(D) SlotFunction;
	private SlotFunction[] _funcs;

	public void opCall(D d)
	{
		synchronized
		{
			foreach(ref f; _funcs)
				f(d);
		}
	}
}