dir.create("../../gen/paper")
dir.create("../../gen/paper/output")
# Load necessary libraries
install.packages("png", repos = "https://cran.r-project.org")
install.packages("shiny", repos = "https://cran.r-project.org")
library(shiny)
library(png)
library(grid)
library(knitr)



# Define the content for your Rmd document
rmd_content <- c(
  "---",
  "title: Descriptives of Results",
"output:",
  "html_document:",
    "toc: true",
"params:",
  "workdir: '../../gen/analysis/output/bar_chart.png'",
  "---",
  "",
  "## Introduction",
  "",
  "This is a dynamic Rmd document that will briefly analyse the results from this project.
The main goal was to examine the effect that price of a Private room has on the number of reviews. 
In the graph below, we generated the results of 5 capital cities in western Europe to answer the research question. .",
  "",
  
  "## Image",
  "",
  "",
  "```{r display_image, out.width = '100%'}",
  "image_path <- '../../gen/analysis/output/bar_chart.png'",
  "knitr::include_graphics(image_path)",
  "```",
  "",
  "## Data Summary",
  "",
"From the graph we can tell that in 4 out of the 5 cities we analyzed, the cheaper private rooms have a higher number of yearly average reviews.
Except for Berlin, there we see that the expensive rooms have the upper hand in number of yearly average reviews.",
"In conclusion, we can say that the yearly average number of reviews for the cheaper rooms is bigger than the yearly average number of reviews of more expensive rooms.",
  ""
)

# Create an Rmd file and write the content
output_rmd_file <- "../../gen/analysis/output/descriptives.Rmd"
writeLines(rmd_content, output_rmd_file)




