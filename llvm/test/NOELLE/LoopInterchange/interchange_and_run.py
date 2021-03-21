import sys
import os
import subprocess

def run_command(cmd):
	output = subprocess.run(cmd.split(), stdout=subprocess.PIPE, universal_newlines=True, cwd='.')

	if output.stdout:
		print(output.stdout)

	if output.stderr:
		eprint(output.stderr)

assert len(sys.argv) == 2, "Should have exactly 2 arguments, the .c file"

c_file = sys.argv[1]
ext = os.path.splitext(c_file)[1]
assert (ext == '.c'), "Expected .c file"
actual_name = os.path.splitext(c_file)[0]
llfile = actual_name + '.ll'
exe = actual_name

CREATE_UNOPTIMIZED_LL = 'clang -S -g -emit-llvm '+c_file+' -o '+llfile+' -O3 -mllvm -disable-llvm-optzns'
CREATE_CANONICALIZED_LL = 'opt -mem2reg -simplifycfg -loop-simplify '+llfile+' -S -o '+llfile
APPLY_INTERCHANGE='opt '+llfile+' -o '+llfile+' -passes=noelle-transformer,verify,verify<loops>,verify<domtree> -noelle-transformer-apply=loop-interchange'
CREATE_EXE='clang '+llfile+' -o '+actual_name

run_command(CREATE_UNOPTIMIZED_LL)
run_command(CREATE_CANONICALIZED_LL)
run_command(APPLY_INTERCHANGE)
run_command(CREATE_EXE)
run_command(actual_name)
run_command("rm "+llfile)
run_command("rm "+actual_name)