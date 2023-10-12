ANALYSIS = ../../gen/analysis/output
PAPER = ../../gen/paper/output


all: $(PAPER)/descriptives.Rmd $(PAPER)/descriptives.knit.md

$(PAPER)/descriptives.Rmd $(PAPER)/descriptives.knit.md: script_to_generate_descriptives.R 
	R --vanilla < script_to_generate_descriptives.R 





