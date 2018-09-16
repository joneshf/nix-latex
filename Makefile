.DEFAULT_GOAL := foo.pdf

.PHONY: clean
clean:
	rm -fr \
	  *.aux \
	  *.dvi \
	  *.fdb_latexmk \
	  *.fls \
	  *.fmt \
	  *.log \
	  *.out \
	  *.pdf \
	  result

foo.pdf: default.nix foo.tex
	nix-build --pure
	cp result/$@ $@
	chmod 0644 $@
