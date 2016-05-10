BIN = ansitohtml
EXAMPLES = $(wildcard test/*)

compile:
	ocamlbuild src/$(BIN).native
	@mv $(BIN).native $(BIN)
	@echo "ansitohtml "successfully" built."

test: compile
	./$(BIN) -s $(addprefix -i ,$(EXAMPLES)) -o test.html

clean:
	ocamlbuild -clean
	rm -f $(BIN)

