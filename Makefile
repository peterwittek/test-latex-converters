TARGETS=pandoc_html pandoc_mathjax pandoc_odt pandoc_docx pandoc_rtf latex2rtf mk4ht htlatex latexml

all: $(TARGETS)

pandoc_html: aux results_dir
		pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.html test_case.tex

pandoc_mathjax: aux results_dir
		pandoc --mathjax --bibliography=./bibliography.bib -o ./results/test_case_pandoc_with_mathjax.html test_case.tex
		
pandoc_odt: aux results_dir		
		pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.odt test_case.tex

pandoc_docx: aux results_dir		
		pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.docx test_case.tex

pandoc_rtf: aux results_dir		
		pandoc -s --bibliography=./bibliography.bib -o ./results/test_case_pandoc.rtf test_case.tex

latex2html: aux results_dir
		latex2html test_case.tex -split 0 -no_navigation -info "" -address "" -html_version 4.0,unicode

latex2rtf: aux results_dir
		latex2rtf -f0 -o ./results/test_case_latex2rtf.rtf test_case.tex

mk4ht: aux results_dir
		mk4ht oolatex test_case_mk4ht.tex
		mv test_case_mk4ht.odt ./results/

htlatex: aux results_dir
		htlatex test_case_htlatex.tex "myxhtml"
		if [ -d "results/test_case_htlatex" ]; then rm -fr "results/test_case_htlatex"; fi
		mkdir "results/test_case_htlatex"
		cp -R figures results/test_case_htlatex/
		mv test_case*png test_case_*.html results/test_case_htlatex

latexml: aux results_dir
		if [ -d "results/test_case_latexml" ]; then	rm -fr "results/test_case_latexml"; fi
		mkdir "results/test_case_latexml"
		latexml --dest="results/test_case_latexml/test_case_latexml.xml" test_case.tex
		latexmlpost --format=html4 --dest="results/test_case_latexml/test_case_latexml.html" "results/test_case_latexml/test_case_latexml.xml"
		
aux: 
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

results_dir:
		if [ ! -d results ]; then	mkdir results; fi

clean: clean_tmp
		rm -fr results

clean_tmp:
		rm -fr *.4* *tmp *out *aux *bbl *log *pdf *dvi *lg *idv *xref *ps *css figures/*.4*
