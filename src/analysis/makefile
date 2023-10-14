OUTPUT = ../../gen/data-preparation/output
ANALYSIS = ../../gen/analysis/output

all: $(ANALYSIS)/bar_chart.png

$(ANALYSIS)/bar_chart.png: $(OUTPUT)/cleaned_data_final.csv analyze.R
	R --vanilla < analyze.R



