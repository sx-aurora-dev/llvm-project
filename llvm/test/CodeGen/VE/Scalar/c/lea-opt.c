/// Tests for lea instruction and its optimizations

static char data;
typedef struct {
    long len;
    char data[1];
} buffer;
static buffer buf;

char* lea_basic() {
    return &data;
}

char* lea_offset() {
    return &buf.data[0];
}
