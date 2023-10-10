DATA = ../../data
TEMP = ../../gen/data-preparation/temp
OUTPUT = ../../gen/data-preparation/output

all: $(DATA)/listings_amsterdam22.csv $(DATA)/listings_berlin22.csv $(DATA)/listings_brussels22.csv $(DATA)/listings_london22.csv $(DATA)/listings_paris22.csv $(DATA)/listings_amsterdam23.csv $(DATA)/listings_berlin23.csv $(DATA)/listings_brussels23.csv $(DATA)/listings_london23.csv $(DATA)/listings_paris23.csv $(OUTPUT)/data_cleaned.csv

$(DATA)/listings_amsterdam22.csv $(DATA)/listings_berlin22.csv $(DATA)/listings_brussels22.csv $(DATA)/listings_london22.csv $(DATA)/listings_paris22.csv $(DATA)/listings_amsterdam23.csv $(DATA)/listings_berlin23.csv $(DATA)/listings_brussels23.csv $(DATA)/listings_london23.csv $(DATA)/listings_paris23.csv: download_data.R
	R --vanilla < download_data.R

$(TEMP)/data_framed.csv: input_data.R $(DATA)/listings_amsterdam22.csv $(DATA)/listings_berlin22.csv $(DATA)/listings_brussels22.csv $(DATA)/listings_london22.csv $(DATA)/listings_paris22.csv $(DATA)/listings_amsterdam23.csv $(DATA)/listings_berlin23.csv $(DATA)/listings_brussels23.csv $(DATA)/listings_london23.csv $(DATA)/listings_paris23.csv
	R --vanilla < input_data.R

$(OUTPUT)/data_cleaned.csv: cleaned_data.R $(TEMP)/data_framed.csv
	R --vanilla < cleaned_data.R

