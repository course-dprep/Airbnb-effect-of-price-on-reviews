relative_path_complete_code.R : Output_Data_Relative.R Transform_Data_Relative.R Download_Data_Relative.R
	Rscript Download_Data_Relative.R 
	Rscript Transform_Data_Relative.R
	Rscript Output_Data_Relative.R
	
clean:
	R -e "unlink('*.csv')"
	
