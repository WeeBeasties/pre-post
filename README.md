## pre-post

This project consists of a set of R scripts to process pre- and post-test results from my Blackboard courses. The files included in this project are:

* **LICENSE** --- The license file for the project as a whole
* **pre-post.Rproj** --- The RStudio project file for this project
* **PrePostQuestion.csv** --- A processed dataset of scores by question
* **PrePostScores.csv** --- A processed dataset of scores by person
* **process.R** --- An R script that converts raw Blackboard data into the two processed data sets
* **README.md** --- This file
* **references.bib** --- A bibtex file of references for the report
* **report.pdf** --- The output of the report process
* **report.Rmd** --- An R markdown document that generates report.pdf from the processed datasets

The sequence of events

1) Save pre-test and post-test output from Blackboard in this folder as "Pre-Course.csv" and "Post-Course.csv"  
2) Run process.R to generate PrePostScores.csv and PrePostQuestions.csv  
3) Open report.Rmd and knit to PDF to generate report.pdf
4) Edit the report.Rmd file to describe your results and re-knit the report file.
