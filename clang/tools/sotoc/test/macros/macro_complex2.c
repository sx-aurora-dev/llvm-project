// RUN: %sotoc-transform-compile

#define DECL_COMMAND(NAME) void NAME ##_command();
#define COMMAND(NAME)  { #NAME, NAME ## _command }

#pragma declare target
DECL_COMMAND(quit)
DECL_COMMAND(help)

struct Command
{
  char *name;
  void (*function) (void);
};
#pragma declare end target

int main(){
  #pragma omp target
  {
    struct Command commands[] =
    {
      COMMAND (quit),
      COMMAND (help),
    };
  }
  return 0;
}

