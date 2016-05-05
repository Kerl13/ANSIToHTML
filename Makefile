BIN = ansitohtml.native

all: compile
	./$(BIN) > test.html

compile:
	ocamlbuild -cflags -w,+A-4 src/$(BIN)

clean:
	ocamlbuild -clean

