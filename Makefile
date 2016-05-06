BIN = ansitohtml.native

all: compile
	./$(BIN) -s -i test/test.ansi -i test/test2.ansi -o test.html

compile:
	ocamlbuild src/$(BIN)

clean:
	ocamlbuild -clean

