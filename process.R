###########################################################################
## process.R
##
## An R script to process pre- and post-test results from Blackboard into
## two de-identified datasets for later analyses.
##
## Copyright by Dr. Clifton Franklund, 2016
## Licensed under the MIT license:
## http://www.opensource.org/licenses/mit-license.php
###########################################################################


packages<-function(x){
	x<-as.character(match.call()[[2]])
	if (!require(x,character.only=TRUE)){
		install.packages(pkgs=x,repos="http://cran.r-project.org")
		require(x,character.only=TRUE)
	}
}

library(dplyr)                            # Used to manipulate the data

numPoints <- 40                            # Define the number of questions in the instrument used

preData <- read.csv("201701_Pre-Course.csv")      # Read in Blackboard file
preScore <- preData %>%
	group_by(Username) %>%
	summarise(Pre = sum(Auto.Score)) %>%
	filter(Pre > 0)                   # Pre-test score by student

postData <- read.csv("201701_Post-Course.csv")   # Read in Blackboard file
postScore <- postData %>%
	group_by(Username) %>%
	summarise(Post = sum(Auto.Score)) %>%
	filter(Post > 0)                  # Post-test score by student

PrePost <- merge(preScore, postScore, by = "Username")  # combine the data

PrePost <- PrePost %>%                   # de-identify
	arrange(desc(Post))

# Create a rubric scores based on the test results
PrePost$preRubric <- ifelse(PrePost$Pre>=0.85*numPoints,4,
			     ifelse(PrePost$Pre>=0.70*numPoints,3,
			            ifelse(PrePost$Pre>=0.60*numPoints,2,
			                   ifelse(PrePost$Pre>=0.50*numPoints,1,0))))

PrePost$postRubric <- ifelse(PrePost$Post>=0.85*numPoints,4,
			     ifelse(PrePost$Post>=0.70*numPoints,3,
			            ifelse(PrePost$Post>=0.60*numPoints,2,
			                   ifelse(PrePost$Post>=0.50*numPoints,1,0))))

PrePost$Username <- NULL
write.csv(PrePost, file = "201701_PrePostScores.csv", row.names = FALSE) # Write out file



PreQuestions <- preData %>%              # Pre-test scores by question
	group_by(Question) %>%
	summarise(Pre = sum(Auto.Score)/length(Auto.Score), Pre.N = length(Auto.Score))

PostQuestions <- postData %>%            # Post-test scores by question
	group_by(Question) %>%
	summarise(Post = sum(Auto.Score)/length(Auto.Score), Post.N = length(Auto.Score))

PrePostQuestions <- merge(PreQuestions,PostQuestions, by = "Question")  # Combining scores

PrePostQuestions <- PrePostQuestions %>% # Determining differences by question
	mutate(Diff = Post - Pre) %>%
	arrange(desc(Diff))

write.csv(PrePostQuestions, file = "201701_PrePostQuestions.csv", row.names = FALSE) # Write out file
