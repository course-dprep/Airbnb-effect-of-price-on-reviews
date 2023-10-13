ANALYSIS = ../../gen/analysis/output
PAPER = ../../gen/paper/output


all:$(PAPER)/descriptives.html

$(PAPER)/descriptives.html: descriptives.Rmd
		R -e rmarkdown::render(input = "descriptives.Rmd", output_dir = "../../gen/paper/output/descriptives.html")




