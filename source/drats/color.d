/** This module stolen and inspired by TODO at HERE.
 * 
 */

module drats.color;

struct Color {
	ubyte r, g, b;
	string toHex() {
		return null;
	}
}
enum
	red = Color(255,0,0),
	green = Color(0,255,0),
	blue = Color(0,0,255),
	crimson = Color(176,23,31),
	pink = Color(255,192,203),
	raspberry = Color(135,38,87),
	orchid = Color(218,112,214),
	thistle = Color(216,191,216),
	violet = Color(238,130,238),
	magenta = Color(255,0,255),
	purple = Color(128,0,128),
	white = Color(255,255,255),
	black = Color(0,0,0);

