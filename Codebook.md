## Codebook

This file describes the structure of the two processed datasets in the project.

### PrePostScores.csv
* Pre --- The number of correct responses on the pre-test
* Post --- The number of correct responses on the post-test
* preRubric --- A rubric score based upon the percent correct on the pre-test
* postRubric --- A rubric score based upon the percent correct on the post-test

### PrePostQuestions.csv
* Question --- The prompt text for each question
* Pre --- The fraction of students that correctly answered the question on the pre-test
* Pre.N --- The number of students that attempted the question on the pre-test
* Post --- The fraction of students that correctly answered the question on the post-test
* Post.N --- The number of students that attempted the question on the post-test
* Diff --- The difference obtained by taking Post minus Pre
