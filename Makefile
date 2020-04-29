PY=python
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style

# CHANGE THESE to configure file paths
BIBFILE=$(INPUTDIR)/references.bib
REF_CSLFILE=$(STYLEDIR)/nature.csl
METADATAFILE=$(BASEDIR)/metadata.yaml
# lastname_firstname_middleinitial(s)_graduationyearmonth_degreedesignator_thesis.pdf
TARGET_OUTPUT_NAME=$(OUTPUTDIR)/Last_First_M_YYYYMM_PhD_thesis

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        generate a web version             '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make docx	                       generate a Docx file 			  '
	@echo '   make tex	                       generate a Latex file 			  '
	@echo '                                                                       '
	@echo ' 																	  '
	@echo ' 																	  '
	@echo 'get local templates with: pandoc -D latex/html/etc	  				  '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates		  '

pdf:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(TARGET_OUTPUT_NAME).pdf" \
	-H "$(STYLEDIR)/preamble.tex" \
	--template="$(STYLEDIR)/template.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(REF_CSLFILE)" \
	--filter pandoc-citeproc \
	--metadata-file="$(METADATAFILE)" \
	--highlight-style pygments \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-N \
	--pdf-engine=xelatex \
	--verbose

tex:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(TARGET_OUTPUT_NAME).tex" \
	-H "$(STYLEDIR)/preamble.tex" \
	--bibliography="$(BIBFILE)" \
	--metadata-file="$(METADATAFILE)" \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-N \
	--csl="$(REF_CSLFILE)" \
	--latex-engine=xelatex

docx:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(TARGET_OUTPUT_NAME).docx" \
	--bibliography="$(BIBFILE)" \
	--csl="$(REF_CSLFILE)" \
	--toc

html:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(TARGET_OUTPUT_NAME).html" \
	--standalone \
	--template="$(STYLEDIR)/template.html" \
	--bibliography="$(BIBFILE)" \
	--csl="$(REF_CSLFILE)" \
	--include-in-header="$(STYLEDIR)/style.css" \
	--toc \
	--number-sections
	rm -rf "$(OUTPUTDIR)/source"
	mkdir "$(OUTPUTDIR)/source"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)/source/figures"

.PHONY: help pdf docx html tex
