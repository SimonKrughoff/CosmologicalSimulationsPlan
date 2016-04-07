
# Use this shell to interpret shell commands, & pass its value to sub-make
#
export SHELL = /bin/sh
#
#
MAKEFLAGS =
#
# Define compilation programs:
#
TEX = pdflatex
BIB = bibtex
#
# Base names of the documents:
#
CSREPORT = csPlan
#
# All tex files used:
#
CSDEPENDENCIES = csPlan.tex macros.tex cs/*.tex references.bib
#
# This line helps prevent make from getting confused in the case where you
# have a file named 'clean'.
#
.PHONY: clean all
#
# This will compile both reports, eventually
#
all: $(CSREPORT).pdf 
#
# Generic instruction for compiling tex files.
#
%.pdf: %.tex
	$(TEX) -halt-on-error $<
	$(TEX) -halt-on-error $<
#
# CS compilation instructions, including dependencies:
#
$(CSREPORT): $(CSREPORT).pdf
$(CSREPORT).pdf: $(CSREPORT).tex $(CSDEPENDENCIES)
	$(TEX) -halt-on-error $(CSREPORT).tex
	$(TEX) -halt-on-error $(CSREPORT).tex
	$(BIB) $(CSREPORT)
	$(TEX) -halt-on-error $(CSREPORT).tex
	$(TEX) -halt-on-error $(CSREPORT).tex

#
# GNU make pre-defines $(RM).  The - in front of $(RM) causes make to
# ignore any errors produced by $(RM).
#
clean:
	- $(RM) -f *.aux *.toc *.out *.log *.bbl *.blg *.wrt *.tor *~
	- $(RM) -f */*.aux */*.toc */*.out */*.log */*.bbl */*.blg */*.wrt */*.tor *~
#
vclean:	clean
	- $(RM) -f  $(CSREPORT).pdf
