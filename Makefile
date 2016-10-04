# A makefile for LaTeX.
# LaTeX cannot be built very efficiently with `make` itself
# because of cyclic dependencies ("re-run pdflatex/bibtex" messages).
# Therefore we use `latexmk`.

TARGETS = name_of_my_tex_file

# build configuration

LATEXMK = latexmk
# for pdflatex: LATEXMK_TARGET = -pdf
# for latex -> dvi -> pdf: LATEXMK_TARGET = -pdfdvi
LATEXMK_TARGET = -pdf
LATEXMK_OPTS += -silent -recorder -use-make -latexoption="-interaction=nonstopmode -synctex=1"


PROMPT	= @echo "$< -> $@"


.PHONY: build live debug clean

build:
	$(PROMPT)
	@$(LATEXMK) $(LATEXMK_TARGET) $(LATEXMK_OPTS) $(TARGETS)

# continuous compilation, always recompile whenever the file has changed
live:
	$(PROMPT)
	@$(LATEXMK) $(LATEXMK_TARGET) $(LATEXMK_OPTS) -pvc $(TARGETS)



debug:
	$(PROMPT)
	@$(LATEXMK) $(LATEXMK_TARGET) $(LATEXMK_OPTS) -verbose $(TARGETS)

clean:
	$(PROMPT)
	$(LATEXMK) -C
	rm -f *.bbl *.synctex.gz *-converted-to.pdf *.synctex.gz\(busy\)


# If you have non-LaTeX dependencies, such as externally generated plots, or converted GIMP images, you can add rules here:

# myimage.png: source.bmp
#	convert source.bmp myimage.png
