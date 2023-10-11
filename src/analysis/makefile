DATA PREP = ../../src/data-preparation
TEMP = ../../gen/data-preparation/temp
ANALYSIS = ../../gen/analysis/output

all: $(ANALYSIS)/barcharts/

$(ANALYSIS)/barcharts: $(DATA PREP)/download_data.R $(DATA PREP)/input_data.R $(DATA PREP)/cleaned_data.R $(TEMP)/data_cleaned.csv analyze.R
	R --vanilla < analyze.R



