SRCFILE = hybrid_requirements_traceability_matrix
LATEX_FLAGS=-interaction=nonstopmode

all: default hybrid_requirements_traceability_matrix.pdf

hybrid_requirements_traceability_matrix.pdf : hybrid_requirements_traceability_matrix.tex hybrid_requirements_traceability_matrix.bib ../srs/intro.tex ../../version.tex ../sdd/DepAndLimitations.tex
	pdflatex $(LATEX_FLAGS) hybrid_requirements_traceability_matrix.tex
	pdflatex $(LATEX_FLAGS) hybrid_requirements_traceability_matrix.tex
	pdflatex $(LATEX_FLAGS) hybrid_requirements_traceability_matrix.tex

../../version.tex : *.tex
	git log -1 --format="%H %an %aD" .. > ../../version.tex

default: *.tex
	python ../../../developer_tools/createSQAtracebilityMatrix.py -i ../srs/requirements_list.xml -o traceability_matrix.tex
	git log -1 --format="%H %an %aD" .. > ../../version.tex

.PHONY: clean

clean:
	@rm -f *~ *.aux *.bbl *.blg *.log *.out *.toc *.lot *.lof hybrid_requirements_traceability_matrix.pdf raceability_matrix.tex
