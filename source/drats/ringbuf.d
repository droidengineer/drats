//
module drats.ringbuf;

struct Ringbuffer(T)
{
  T [] buf;
  size_t sz, capacity;
  size_t head;
  size_t tail;

  this(size_t s)
  {
    sz = 0;
    capacity = s;
    buf = new T [capacity];
    head = tail = 0;
  }

  void free() {
    //GC.free(buf);
  }



  void push(T data) {
    buf[tail++] = data;
    if (tail >= capacity) tail = 0;
    ++sz;
  }

  T pop() {
    if (sz == 0) return cast(byte)null;
    T c = buf[head++];
    if (head >= capacity) head = 0;
    --sz;
    return c;
  }

  @property bool empty() const { return (head == tail); }
}
