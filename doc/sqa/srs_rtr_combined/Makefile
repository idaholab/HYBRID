LATEX_FLAGS=-interaction=nonstopmode

all: hybrid_software_requirements_specifications_and_traceability.pdf

hybrid_software_requirements_specifications_and_traceability.pdf : hybrid_software_requirements_specifications_and_traceability.tex hybrid_software_requirements_specifications_and_traceability.bib ../srs/intro.tex ../../version.tex ../sdd/DepAndLimitations.tex
	python ../../../raven/developer_tools/readRequirementsAndCreateLatex.py -i ../srs/requirements_list.xml -o ../srs/requirements.tex
	python ../../../developer_tools/createSQAtracebilityMatrix.py -i ../srs/requirements_list.xml -o ../rtr/traceability_matrix.tex
	pdflatex $(LATEX_FLAGS) hybrid_software_requirements_specifications_and_traceability.tex
	pdflatex $(LATEX_FLAGS) hybrid_software_requirements_specifications_and_traceability.tex
	pdflatex $(LATEX_FLAGS) hybrid_software_requirements_specifications_and_traceability.tex

../../version.tex : *.tex
	git log -1 --format="%H %an %aD" .. > ../../version.tex

default: *.tex
	python ../../../raven/developer_tools/readRequirementsAndCreateLatex.py -i ../srs/requirements_list.xml -o ../srs/requirements.tex
	python ../../../developer_tools/createSQAtracebilityMatrix.py -i ../srs/requirements_list.xml -o ../rtr/traceability_matrix.tex

.PHONY: clean

clean:
	@rm -f *~ *.aux *.bbl *.blg *.log *.out *.toc *.lot *.lof hybrid_software_requirements_specifications_and_traceability.pdf dependencies.tex
