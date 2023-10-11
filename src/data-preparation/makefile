DATA = ../../data
TEMP = ../../gen/data-preparation/temp
OUTPUT = ../../gen/data-preparation/output

all: $(TEMP)/data_framed.csv $(OUTPUT)/cleaned_data_final.csv

$(TEMP)/data_framed.csv: download_merge_data.R
	R --vanilla < download_merge_data.R

$(OUTPUT)/cleaned_data_final.csv: clean_data.R $(TEMP)/data_framed.csv
	R --vanilla < clean_data.R
