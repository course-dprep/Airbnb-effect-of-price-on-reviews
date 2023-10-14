RMD_FILE = descriptives.Rmd
HTML_OUTPUT = descriptives.html


../../gen/paper/output/html: $(RMD_FILE)
	Rscript -e "rmarkdown::render('$<', output_file = '../../gen/paper/output/$(HTML_OUTPUT)')"