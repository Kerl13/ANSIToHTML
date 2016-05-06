BIN = ansitohtml

compile:
	ocamlbuild src/$(BIN).native
	@mv $(BIN).native $(BIN)
	@echo "ansitohtml "successfully" built."

test: compile
	./$(BIN) -s -i test/test.ansi -i test/test2.ansi -o test.html

clean:
	ocamlbuild -clean
	rm -f $(BIN)

