Introduction
------------

This is a set of test cases to check the features of various conversion tools from LaTeX source files to HTML and word processor formats. The original experiment was described in this blog post:

http://peterwittek.com/comparing-latex-conversion-tools.html

Usage
-----
If you have all converters installed, this will produce all output files in the results folder except latex2html, which often hangs:

    make all

Individual converters can be tested one by one by calling ``make converter``, where the converter can be one of the following:

  - pandoc_html 
  - pandoc_mathjax 
  - pandoc_odt 
  - pandoc_docx 
  - pandoc_rtf 
  - latex2rtf 
  - mk4ht 
  - htlatex 
  - latexml
  - latex2html

Based on the suggestion in [this issue](https://github.com/peterwittek/test-latex-converters/issues/1), the current best option to generate something that works okay in a word processor is to generate the html4 output with latexml and open the resulting HTML file in the word processor.
