#!/bin/bash
echo "Starting to compile manual..."
chmod u+x script/copy_tex.sh
script/copy_tex.sh
cd build
pdflatex -interaction=nonstopmode Validation_template_user_manual.tex
cd ..
biber build/Validation_template_user_manual
cd build
pdflatex -interaction=nonstopmode Validation_template_user_manual.tex
pdflatex -interaction=nonstopmode Validation_template_user_manual.tex
cd ..
cp -f build/Validation_template_user_manual.pdf pdf/
echo "User manual build complete."
echo "Cleaning build"
cd ..
rm -rf build/
echo "Done"