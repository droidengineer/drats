/* license
*/
import std.stdio;
import std.stream;
import ods.ringbuff;

version(__GNUC__) {
	immutable SO_IMPORT = __attribute__((visibility("default")));
} else {
	immutable SO_IMPORT = "";
}
version(__linux__)
{
	import std.c.linux.termios;
	termios orig_termios;

} else {
	assert(0,"There is no support for Windows at the moment");
}

enum TB_KEY {
	F1 = 0xFFFF - 0,
	F2 = 0xFFFF - 1,
	F3 = 0xFFFF - 2,
	F4 = 0xFFFF - 3,
	F5 = 0xFFFF - 4,
	F6 = 0xFFFF - 5,
	F7 = 0xFFFF - 6,
	F8 = 0xFFFF - 7,
	F9 = 0xFFFF - 8,
	F10 = 0xFFFF - 9,
	F11 = 0xFFFF - 10,
	F12 = 0xFFFF - 11,
	INSERT = 0xFFFF - 12,
	DELETE = 0xFFFF - 13,
	HOME = 0xFFFF - 14,
	END = 0xFFFF - 15,
	PGUP = 0xFFFF - 16,
	PGDN = 0xFFFF - 17,
	ARROW_UP = 0xFFFF - 18,
	ARROW_DOWN = 0xFFFF - 19,
	ARROW_LEFT = 0xFFFF - 20,
	ARROW_RIGHT = 0xFFFF - 21,
	CTRL_TILDE = 0x00,
	CTRL_2 = 0x00,
	CTRL_A = 0x01,
	CTRL_B = 0x02,
	CTRL_C = 0x03,
	CTRL_D = 0x04,
	CTRL_E = 0x05,
	CTRL_F = 0x06,
	CTRL_G = 0x07,
	CTRL_H = 0x08,
	CTRL_I = 0x09,
	CTRL_J = 0x0a,
	CTRL_K = 0x0b,
	CTRL_L = 0x0c,
	CTRL_M = 0x0d,
	CTRL_N = 0x0e,
	CTRL_O = 0x0f,
	CTRL_P = 0x10,
	CTRL_Q = 0x11,
	CTRL_R = 0x12,
	CTRL_S = 0x13,
	CTRL_T = 0x14,
	CTRL_U = 0x15,
	CTRL_V = 0x16,
	CTRL_W = 0x17,
	CTRL_X = 0x18,
	CTRL_Y = 0x19,
	CTRL_Z = 0x1a,
	BACKSPACE = 0x08,
	TAB = 0x09,
	ENTER = 0x0D,
	ESC = 0x1B,
	LSQ_BRACKET = 0x1B,
	CTRL_3 = 0x1B,
	CTRL_4 = 0x1C,
	BACKSLASH = 0x1C,
	CTRL_5 = 0x1D,
	RSQ_BRACKET = 0x1D,
	CTRL_6 = 0x1E,
	CTRL_7 = 0x1F,
	CTRL_SLASH = 0x1F,
	CTRL_UNDERSCORE = 0x1F,
	SPACE = 0x20,
	BACKSPACE2 = 0x7F,
	CTRL_8 = 0x7F
}

const TB_MOD_ALT = 0x01;
const TB_HIDE_CURSOR = -1;
const TB_INPUT_ESC = 1;
const TB_INPUT_ALT = 2;
const TB_INPUT_CTRL = 3;
const TB_EOF = -1;

enum TB_COLORS {
	BLACK, RED, GREEN, YELLOW, BLUE,
	MAGENTA, CYAN, WHITE, DEFAULT = 0x0F
}

enum TB_ATTRIBUTE {
	BOLD = 0x10,
	UNDERLINE = 0x20,
	BLINK = 0x40
}

struct tb_cell
{
	uint32_t ch;
	uint16_t fg;
	uint16_t bg;
}

struct cell_buffer
{
	this(uint w, uint h)
	{
		width = w; height = h;
		cells = new tb_cell[];
	}

	tb_cell getCell(uint x, uint y) {
		return cells[y * width + x];
	}

	void resize(uint w, uint h) {

	}

	void clear() {

	}

	void free() {

	}

	uint width;
	uint height;
	tb_cell [] cells;
}

cell_buffer back_buff;
cell_buffer front_buff;

wstring write_buffer_data;
BufferedStream write_buff;

RingBuffer rxBuff;

int buff_size_change_req;

int out_filenum;
int in_filenum;

uint lastX = LAST_COORD_INIT;
uint lastY = LAST_COORD_INIT;

struct tb_event
{
	int blockingFillEvent(Duration d) {

	}

	uint8_t type;
	uint8_t mod;
	uint16_t key;
	uint32_t ch;
	int32_t w;
	int32_t h;
}

const TB_EVENT_KEY = 1;
const TB_EVENT_RESIZE = 2;

enum TB_ERROR {
	UNSUPPORTED_TERM = -1,
	TTY_OPEN_FAIL = -2,
	PIPE_TRAP = -3
}

const LAST_COORD_INIT 0xFFFFFFFE;

TB_COLORS background = TB_COLORS.DEFAULT;
TB_COLORS foreground = TB_COLORS.DEFAULT;


struct TermBox
{
	static int init() {

	}

	static void fini() {

	}

	static uint width() {

	}

	static uint height() {

	}

	static void clear() {

	}

	static void present() {

	}

	static updateSize() {

	}

	static void updateTermSize() {

	}

	static void emitAttribute(uint16_t fg, uint16_t bg) {

	}

	static void emitChar(uint x, uint y, uint32_t c) {

	}

	static void emitClear() {

	}

	void setCursor(int cx, int cy) {
		cursor_x = cx; cursor_y = cy;
	}

	void putCell(uint x, uint y, tb_cell c) {

	}

	void changeCell(uint x, uint y, uint32_t ch, uint16_t fg, uint16_t bg) {

	}

	void blit(uint x, uint y, uint w, uint h, tb_cell [] cells) {

	}

	int setInputMode(int m) {

	}

	void setClearAttributes(uint16_t fg, uint16_t bg) {

	}

	int eventPeek(tb_event e, uint t) {

	}

	int eventPoll(tb_event e) {

	}

	bool isCursorHidden(uint cx, uint cy) { return (cx == -1||cy == -1); }
	void drawCursor() {

	}
	void drawSGR(uint32_t fg, uint32_t bg) {

	}

	uint width;
	uint height;
	int inputMode = TB_INPUT_CTRL;
	uint cursor_x = -1;
	uint cursor_y = -1;
}

// need to implement sigWINCH signal handler (std.signal)
