#!/bin/bash
if [ -d "results" ]; then
  rm -fr "results"
fi
mkdir "results"

pdflatex test_case.tex
bibtex test_case
pdflatex test_case.tex
pdflatex test_case.tex

pdflatex test_case_mk4ht.tex
bibtex test_case_mk4ht
pdflatex test_case_mk4ht.tex
pdflatex test_case_mk4ht.tex

pdflatex test_case_htlatex.tex
bibtex test_case_htlatex
pdflatex test_case_htlatex.tex
pdflatex test_case_htlatex.tex

pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.html test_case.tex
pandoc --mathjax --bibliography=./bibliography.bib -o ./results/test_case_pandoc_with_mathjax.html test_case.tex
pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.odt test_case.tex
pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.docx test_case.tex
pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.rtf test_case.tex

# This will run indefinitely
# latex2html test_case.tex -split 0 -no_navigation -info "" -address "" -html_version 4.0,unicode

latex2rtf -f0 -o ./results/test_case_latex2rtf.rtf test_case.tex

mk4ht oolatex test_case_mk4ht.tex
mv test_case_mk4ht.odt ./results/

htlatex test_case_htlatex.tex "myxhtml"
if [ -d "results/test_case_htlatex" ]; then
  rm -fr "results/test_case_htlatex"
fi
mkdir "results/test_case_htlatex"
cp -R figures results/test_case_htlatex/
mv test_case*png test_case_*.html results/test_case_htlatex
