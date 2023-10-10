TEMP = ../../gen/data-preparation/temp
ANALYSIS = ../../gen/analysis/output

all: $(ANALYSIS)/barcharts/

$(ANALYSIS)/barcharts: $(TEMP)/data_cleaned.csv Output_Data_Relative.R
	R --vanilla < Output_Data_Relative.R



