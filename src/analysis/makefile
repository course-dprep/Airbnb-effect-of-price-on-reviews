DATA = ../../src/data-preparation
TEMP = ../../gen/data-preparation/temp
ANALYSIS = ../../gen/analysis/output

all: $(ANALYSIS)/bar_chart.png

$(ANALYSIS)/bar_chart.png: $(DATA)/download_merge_data.R $(DATA)/clean_data.R $(TEMP)/cleaned_data_final.csv analyze.R
	R --vanilla < analyze.R



