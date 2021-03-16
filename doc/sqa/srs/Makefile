LATEX_FLAGS=-interaction=nonstopmode

all: hybrid_software_requirements_specifications.pdf

hybrid_software_requirements_specifications.pdf : hybrid_software_requirements_specifications.tex hybrid_software_requirements_specifications.bib intro.tex ../../version.tex ../sdd/DepAndLimitations.tex
	python ../../../raven/developer_tools/readRequirementsAndCreateLatex.py -i requirements_list.xml -o requirements.tex
	pdflatex $(LATEX_FLAGS) hybrid_software_requirements_specifications.tex
	pdflatex $(LATEX_FLAGS) hybrid_software_requirements_specifications.tex
	pdflatex $(LATEX_FLAGS) hybrid_software_requirements_specifications.tex

../../version.tex : *.tex
	git log -1 --format="%H %an %aD" .. > ../../version.tex

default: *.tex
	python ../../../raven/developer_tools/readRequirementsAndCreateLatex.py -i requirements_list.xml -o requirements.tex

.PHONY: clean

clean:
	@rm -f *~ *.aux *.bbl *.blg *.log *.out *.toc *.lot *.lof hybrid_software_requirements_specifications.pdf requirements.tex
