# Template for writing a University of Toronto SGS-specific Thesis in Markdown

This template is based heavily off of the [PhD Thesis Markdown](https://github.com/tompollard/phd_thesis_markdown) template by Tom Pollard, while conforming to the specific guidelines for thesis formatting at the University of Toronto, School of Graduate Studies (SGS). I've also used the [LaTeX template provided by SGS ](http://www.ctan.org/tex-archive/macros/latex/contrib/ut-thesis/) but with major modifications to allow the template to work nicely with Pandoc. 

**Note, this template is NOT officially endorsed by SGS, nor do I guarantee it will be maintained to accomodate updates and changes to either the PhD Thesis Markdown template or the SGS Latex Template by their maintainers. It is provided as is and something I found useful to format my own PhD thesis in conformity with the University of Toronto, SGS guidelines. Feel free to make changes to meet your own formatting preferences.**

The main changes between the original markdown template by Tom Pollard and this University of Toronto specific template are listed below: 
- **title page** and **abstract header** is automatically populated based on the information in the `metadata.yaml` file. 
- new **chapters** are denoted using `\chapter{Chapter Name}` instead of `#` (H1)
  - using `#` to denote a header within a chapter will create a section (or subsection when using more than one `##`)
  under that chapter (e.g. Chapter X, Section X.1; in the TOC as X.1)
  - the content of each chapter (intro, results aim 1, results aim 2, Discussion etc) does not need to 
  be contained in one file. As long as the start of chapter is denoted using `\chapter{Chapter Name}`, all subsequent sections
  will belong to that chapter, until the next `\chapter{}` starts. 
- `.md` **filenames/numbering are grouped** for the different parts of the thesis, such that you can more easily add new files, sections or subsections without having to change the numbering of all the other files to keep the same desired ordering:
  - for example, instead of having the table of contents, list of figures, list of plates etc. being numbered as
  `03_toc.md`, `04_list_of_figures.md`, `05_list_of_plates.md`, they're grouped under `03_01_toc.md`, `03_02_list_of_figures.md` etc.
  - if you need to populate different appendixes, or lists along with the TOC, you can just add a new file, `03_XX_name_of_page.md`
  such that xx is a number that places the page in the correct order when the pdf is generated (alphanumeric order).


## Configuring your project
1. Edit `metadata.yaml` with your information for the title page/abstract (thesis title, thesis author name, department/faculty, graduating year).
    - You can also specify any document class options here. For example, any of the standard options available 
    for the LaTeX2e `report` class (e.g. 10pt, 12pt, oneside, twoside etc.), or those specifically available for the 
    `ut-thesis` class. You can see `ut-thesis.cls` for more detailed information. 
2. Edit the `Makefile` to change the `TARGET_OUTPUT_NAME` based on `Last_First_M_YYYYMM_DEG_thesis` where:
    - Last = Last name
    - First = First name
    - M = Middle initial(s)
    - YYYYMM = Year and month of graduation (e.g. 202011 for November 2020)
    - DEG = Degree designator, for example, `MSc`, `MA`, `PhD`
    - Keep `_thesis` as is. 
3. Place your `.bib` file in the `/source` directory, and edit the `BIBFILE` entry in the `Makefile` (or the equivalent in `fabfile.py`) to match.
4. Place your reference format file (`.csl`) in the `/style` directory and edit the `CSLFILE` entry in the `Makefile` (or the equivalent in `fabfile.py`) to match.
 
**Note:** I have not tested the fabfile or Gruntfile, but have left them in the repository in case you want to modify for your own purposes. 

## Writing 
The structure of the sections/chapters included (Intro, Lit Review, Methods etc) are only meant to be a guide. You can discuss with your supervisor(s) or registrar for more information if you're unsure. Here are just some examples of differences in structure I've seen looking through other University of Toronto theses (which you can do too [T-Space Theses Repository](https://tspace.library.utoronto.ca/handle/1807/9944)), I would highly suggest looking through some theses from your field/department, as certain formats may be more common/expected in different fields.
- Instead of a separate sections for Introduction and Literature Review, your Introduction is essentially your literature review.
- some people choose to include one Methods section that covers all methods used in the thesis, while others will include methods within each results chapter, or some combination of both (general methods at the start, and more specific methods in each results chapter)
- the number of results chapters varies by department/field, so check through theses from alumni of your research group, or department to get an idea 
- You can only report the results in each Results Chapter and have a longer Discussion section, or some people include a Discussion section within each results chapter, and spend more time in the Discussion/Conclusions section focusing on future directions, or more broad speculations about the results in terms of the current literature and state of the field. 

**Regardless, always consult the SGS Guidelines ([General Info](https://www.sgs.utoronto.ca/academic-progress/program-completion/producing-your-thesis/), [Formatting](https://www.sgs.utoronto.ca/academic-progress/program-completion/formatting/)) to make sure your thesis meets all the up-to-date criteria for a thesis.**

Read on below in the [How do I get started?](#how-do-i-get-started) section to read more about using this template.

----

_Below are the general information and instructions from Tom Pollard, the original creator of the PhD thesis markdown template_
 
# Template for writing a PhD thesis in Markdown [![Build Status](https://travis-ci.org/tompollard/phd_thesis_markdown.svg?branch=master)](https://travis-ci.org/tompollard/phd_thesis_markdown)  

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.58490.svg)](http://dx.doi.org/10.5281/zenodo.58490)

This repository provides a framework for writing a PhD thesis in Markdown. I used the template for my PhD submission to University College London (UCL), but it should be straightforward to adapt suit other universities too.

## Citing the template

If you have used this template in your work, please cite the following publication:

> Tom Pollard et al. (2016). Template for writing a PhD thesis in Markdown. Zenodo. http://dx.doi.org/10.5281/zenodo.58490

## Why write my thesis in Markdown?

Markdown is a super-friendly plain text format that can be easily converted to a bunch of other formats like PDF, Word and LaTeX. You'll enjoy working in Markdown because:
- it is a clean, plain-text format...
- ...but you can use LaTeX when you need it (for example, in laying out mathematical formula).
- it doesn't suffer from the freezes and crashes that some of us experience when working with large, image-heavy Word documents.
- it automatically handles the table of contents, bibliography etc with Pandoc.
- comments, drafts of text, etc can be added to the document by wrapping them in &lt;!--  --&gt;
- it works well with Git, so keeping backups is straightforward. Just commit the changes and then push them to your repository.
- there is no lock-in. If you decide that Markdown isn't for you, then just output to Word, or whatever, and continue working in the new format.

## Are there any reasons not to use Markdown?

There are some minor annoyances:
- if you haven't worked with Markdown before then you'll find yourself referring to the style-guide fairly often at first.
- it isn't possible to add a short caption to tables ~~and figures~~ ([figures are now fixed](https://github.com/tompollard/phd_thesis_markdown/pull/47), thanks to @martisak). This means that /listoftables includes the long-caption, which probably isn't what you want. If you want to include the list of tables, then you'll need to write it manually.
- the style documents in this framework could be improved. The PDF and HTML (thanks [@ArcoMul](https://github.com/ArcoMul)) outputs are acceptable, but ~~HTML and~~ Word needs work if you plan to output to this format.  
- ~~there is no straightforward way of specifying image size in the markdown right now, though this functionality is coming (see: https://github.com/tompollard/phd_thesis_markdown/issues/15)~~ (Image size can now be specified. Thanks to @rudolfbyker for [highlighting this](https://github.com/tompollard/phd_thesis_markdown/issues/15)).
- ... if there are more, please add them here.

## How is the template organised?

- README.md => these instructions.
- License.md => terms of reuse (MIT license).
- Makefile => contains instructions for using Pandoc to produce the final thesis.
- output/ => directory to hold the final version.
- source/ => directory to hold the thesis content. Includes the references.bib file.
- source/figures/ => directory to hold the figures.
- style/ => directory to hold the style documents.

## How do I get started?

1. Install the following software:
    - A text editor, like [Sublime](https://www.sublimetext.com/), which is what you'll use write the thesis.  
    - A LaTeX distribution (for example, [MacTeX](https://tug.org/mactex/) for Mac users).
    - [Pandoc](http://johnmacfarlane.net/pandoc), for converting the Markdown to the output format of your choice.  You may also need to install [Pandoc cite-proc](http://pandoc.org/demo/example19/Extension-citations.html) to create the bibliography.
    - Install @martisak's shortcaption module for Pandoc, with `pip install pandoc-shortcaption`
    - Git, for version control.
2. [Fork the repository](https://github.com/tompollard/phd_thesis_markdown/fork) on Github  
3. Clone the repository onto your local computer (or [download the Zip file](https://github.com/tompollard/phd_thesis_markdown/archive/master.zip)).  
4. Navigate to the directory that contains the Makefile and type "make pdf" (or "make html") at the command line to update the PDF (or HTML) in the output directory.  
**In case of an error** (e.g. `make: *** [pdf] Error 43`) run the following commands:  
    ```
    sudo tlmgr install truncate
    sudo tlmgr install tocloft
    sudo tlmgr install wallpaper
    sudo tlmgr install morefloats
    sudo tlmgr install sectsty
    sudo tlmgr install siunitx
    sudo tlmgr install threeparttable
    sudo tlmgr update l3packages
    sudo tlmgr update l3kernel
    sudo tlmgr update l3experimental
    ```
    
5. Edit the files in the 'source' directory, then goto step 4.  

## What else do I need to know?

Some useful points, in a random order:
- each chapter must finish with at least one blank line, otherwise the header of the following chapter may not be picked up.
- add two spaces at the end of a line to force a line break.
- the template uses [John Macfarlane's Pandoc](http://johnmacfarlane.net/pandoc/README.html) to generate the output documents. Refer to this page for Markdown formatting guidelines.
- PDFs are generated using the LaTeX templates in the style directory. Fonts etc can be changed in the TeX templates.
- To change the citation style, just overwrite ref_format.csl with the new style. Style files can be obtained from [citationstyles.org/](http://citationstyles.org/)
- For fellow web developers, there is a Grunt task file (Gruntfile.js) which can be used to 'watch' the markdown files. By running `$ npm install` and then `$ npm run watch` the PDF and HTML export is done automatically when saving a Markdown file.
- You can automatically reload the HTML page on your browser using LiveReload with the command `$ npm run livereload`. The HTML page will automatically reload when saving a Markdown file after the export is done.

# Contributing

Contributions to the template are encouraged! There are lots of things that could be improved, like:
- finding a way to add short captions for the tables, so that the lists of tables can be automatically generated.
- cleaning up the LaTeX templates, which are messy at the moment.
- improving the style of Word and TeX outputs.

Please fork and edit the project, then send a pull request.
