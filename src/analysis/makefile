OUTPUT = ../../gen/data-preparation/output
ANALYSIS = ../../gen/analysis/output

all: $(ANALYSIS)/barcharts.pdf

$(ANALYSIS)/barcharts.pdf: $(OUTPUT)/data_cleaned.csv Output_Data_Relative.R
	R --vanilla < Output_Data_Relative.R
