TEMP = ../../gen/data-preparation/temp
ANALYSIS = ../../gen/analysis/output

all: $(ANALYSIS)/barcharts/

$(ANALYSIS)/barcharts: $(TEMP)/data_cleaned.csv analyze.R
	R --vanilla < analyze.R



