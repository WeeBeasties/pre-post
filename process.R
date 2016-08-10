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


packages<-function(x){                     # Install and load any packages needed
	x<-as.character(match.call()[[2]])
	if (!require(x,character.only=TRUE)){
		install.packages(pkgs=x,repos="http://cran.r-project.org")
		require(x,character.only=TRUE)
	}
}

packages(dplyr)                            # Used to manipulate the data



preData <- read.csv("Pre-Course.csv")      # Read in Blackboard file
preScore <- preData %>%
	group_by(Username) %>%
	summarise(Pre = sum(Auto.Score)) %>%
	filter(Pre > 0)                   # Pre-test score by student

postData <- read.csv("Post-Course.csv")   # Read in Blackboard file
postScore <- postData %>%
	group_by(Username) %>%
	summarise(Post = sum(Auto.Score)) %>%
	filter(Post > 0)                  # Post-test score by student

PrePost <- merge(preScore, postScore, by = "Username")  # combine the data

PrePost <- PrePost %>%                   # de-identify
	arrange(desc(Post))
PrePost$Username <- NULL
write.csv(PrePost, file = "PrePostScores.csv", row.names = FALSE) # Write out file



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

write.csv(PrePostQuestions, file = "PrePostQuestions.csv", row.names = FALSE) # Write out file