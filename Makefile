BIN = ansitohtml.native

all: compile
	./$(BIN) -s -i test/test.ansi -i test/test2.ansi -o test.html

compile:
	ocamlbuild -cflags -w,+A-4 src/$(BIN)

clean:
	ocamlbuild -clean

