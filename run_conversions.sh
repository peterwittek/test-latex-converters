#!/bin/bash
if [ -d "results" ]; then
  rm -fr "results"
fi
mkdir "results"

pdflatex test_case.tex
bibtex test_case
pdflatex test_case_tex4ht.tex
bibtex test_case_tex4ht

pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.html test_case.tex
pandoc --mathjax --bibliography=./bibliography.bib -o ./results/test_case_pandoc_with_mathjax.html test_case.tex
pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.odt test_case.tex
pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.docx test_case.tex
pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.rtf test_case.tex

# This will run indefinitely
# latex2html test_case.tex -split 0 -no_navigation -info "" -address "" -html_version 4.0,unicode

latex2rtf -o ./results/test_case_latex2rtf.rtf test_case.tex

mk4ht oolatex test_case_tex4ht.tex
mv test_case_tex4ht.odt ./results/test_case_mk4ht.odt

htlatex test_case_tex4ht.tex
if [ -d "results/test_case_htlatex" ]; then
  rm -fr "results/test_case_htlatex"
fi
mkdir "results/test_case_htlatex"
cp -R figures results/test_case_htlatex/
mv test_case_tex4ht*png test_case_tex4ht.html results/test_case_htlatex
