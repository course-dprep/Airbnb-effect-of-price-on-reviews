download: Download_Data_Relative.R
	Rscript Download_Data_Relative.R

transform: Transform_Data_Relative.R
	Rscript Transform_Data_Relative.R

output: Output_Data_Relative.R
	Rscript Output_Data_Relative.R
	
clean:
	R -e "unlink('*.csv')"
	
