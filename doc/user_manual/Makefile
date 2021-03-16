SRCFILE = hybrid_user_manual
MANUAL_FILES = hybridStructure.tex \
introduction.tex hybrid_user_manual.tex \
Installation/clone.tex Installation/conda.tex Installation/linux.tex  Installation/main.tex \
Installation/overview.tex Installation/windows.tex 
LATEX_FLAGS=-interaction=nonstopmode

all: hybrid_user_manual.pdf

hybrid_user_manual.pdf: $(MANUAL_FILES) ../version.tex
	pdflatex $(LATEX_FLAGS) $(SRCFILE).tex
	bibtex $(SRCFILE)
	pdflatex $(LATEX_FLAGS) $(SRCFILE).tex
	pdflatex $(LATEX_FLAGS) $(SRCFILE).tex

draft: $(MANUAL_FILES) ../version.tex
	pdflatex $(LATEX_FLAGS) "\def\DRAFT{1}\input{$(SRCFILE).tex}"
	bibtex $(SRCFILE)
	pdflatex $(LATEX_FLAGS) "\def\DRAFT{1}\input{$(SRCFILE).tex}"
	pdflatex $(LATEX_FLAGS) "\def\DRAFT{1}\input{$(SRCFILE).tex}"

.PHONY: clean

clean:
	@rm -f *~ *.aux *.bbl *.blg *.log *.out *.toc *.lot *.lof $(SRCFILE).pdf

#Short method of creating version file, offical version is in make_docs.sh script
../version.tex : $(MANUAL_FILES)
	git log -1 --format="%H %an %aD" .. > ../version.tex

