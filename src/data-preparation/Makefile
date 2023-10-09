download: Download_Data_Relative.R
	Rscript Download_Data_Relative.R

transform: Transform_Data_Relative.R
	Rscript Transform_Data_Relative.R

output: Output_Data_Relative.R
	Rscript Output_Data_Relative.R
	
# Specify a default target
.DEFAULT_GOAL := all

# Define a default action to run all stages by default
all: download transform output

.PHONY: all download transform output

	
