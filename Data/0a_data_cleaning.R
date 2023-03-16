# read data -----
library(tidyverse)
library(readr)
library(skimr)
library(stringr)
library(dplyr)
library(janitor)

data_science_ml <- read_csv("Data/Raw/kaggle-survey-2020/kaggle_survey_2020_responses.csv") %>%
  clean_names()

  
# removing unnecessary questions ----

data_science_ml <- data_science_ml %>%
  select(-contains("q35")) %>%
  select(-contains("time")) %>%
  select(-contains("q34")) %>%
  select(-contains("q33")) %>%
  select(-contains("q32")) %>%
  select(-contains("q39")) %>%
  select(-contains("q31")) %>%
  select(-contains("q30")) %>%
  select(-contains("q29")) %>%
  select(-contains("q28")) %>%
  select(-contains("q26")) %>%
  select(-contains("q12")) %>% # only 3 choices and a lot of people put other
  select(-contains("q20")) %>% # size of company wouldnt really impact predicting title
  select(-contains("time")) 

# create code book ----
code_book <- data_science_ml[1,]

write.csv(code_book, "data/Processed/Code_Book.csv")

# Skimming to see completion rate per question ----
data_science_ml %>%
  skim()

# Q5 (outcome variable distribution) ----
data_science_ml %>%
  count(q5)

# Dummy incoding questions ----

## Q7 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q7_part_1 = ifelse(is.na(q7_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q7_part_2 = ifelse(is.na(q7_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q7_part_3 = ifelse(is.na(q7_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q7_part_4 = ifelse(is.na(q7_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q7_part_5 = ifelse(is.na(q7_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q7_part_6 = ifelse(is.na(q7_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q7_part_7 = ifelse(is.na(q7_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q7_part_8 = ifelse(is.na(q7_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q7_part_9 = ifelse(is.na(q7_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q7_part_10 = ifelse(is.na(q7_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q7_part_11 = ifelse(is.na(q7_part_11), 0, 1))

#12
data_science_ml <- data_science_ml %>%
  mutate(q7_part_12 = ifelse(is.na(q7_part_12), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q7_other = ifelse(is.na(q7_other), 0, 1))

## Q9 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q9_part_1 = ifelse(is.na(q9_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q9_part_2 = ifelse(is.na(q9_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q9_part_3 = ifelse(is.na(q9_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q9_part_4 = ifelse(is.na(q9_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q9_part_5 = ifelse(is.na(q9_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q9_part_6 = ifelse(is.na(q9_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q9_part_7 = ifelse(is.na(q9_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q9_part_8 = ifelse(is.na(q9_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q9_part_9 = ifelse(is.na(q9_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q9_part_10 = ifelse(is.na(q9_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q9_part_11 = ifelse(is.na(q9_part_11), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q9_other = ifelse(is.na(q9_other), 0, 1))


## Q10 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q10_part_1 = ifelse(is.na(q10_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q10_part_2 = ifelse(is.na(q10_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q10_part_3 = ifelse(is.na(q10_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q10_part_4 = ifelse(is.na(q10_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q10_part_5 = ifelse(is.na(q10_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q10_part_6 = ifelse(is.na(q10_part_6), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q10_part_7 = ifelse(is.na(q10_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q10_part_8 = ifelse(is.na(q10_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q10_part_9 = ifelse(is.na(q10_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q10_part_10 = ifelse(is.na(q10_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q10_part_11 = ifelse(is.na(q10_part_11), 0, 1))

#12
data_science_ml <- data_science_ml %>%
  mutate(q10_part_12 = ifelse(is.na(q10_part_12), 0, 1))

#13
data_science_ml <- data_science_ml %>%
  mutate(q10_part_13 = ifelse(is.na(q10_part_13), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q10_other = ifelse(is.na(q10_other), 0, 1))

## Q14 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q14_part_1 = ifelse(is.na(q14_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q14_part_2 = ifelse(is.na(q14_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q14_part_3 = ifelse(is.na(q14_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q14_part_4 = ifelse(is.na(q14_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q14_part_5 = ifelse(is.na(q14_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q14_part_6 = ifelse(is.na(q14_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q14_part_7 = ifelse(is.na(q14_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q14_part_8 = ifelse(is.na(q14_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q14_part_9 = ifelse(is.na(q14_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q14_part_10 = ifelse(is.na(q14_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q14_part_11 = ifelse(is.na(q14_part_11), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q14_other = ifelse(is.na(q14_other), 0, 1))

## Q16 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q16_part_1 = ifelse(is.na(q16_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q16_part_2 = ifelse(is.na(q16_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q16_part_3 = ifelse(is.na(q16_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q16_part_4 = ifelse(is.na(q16_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q16_part_5 = ifelse(is.na(q16_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q16_part_6 = ifelse(is.na(q16_part_6), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q16_part_7 = ifelse(is.na(q16_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q16_part_8 = ifelse(is.na(q16_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q16_part_9 = ifelse(is.na(q16_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q16_part_10 = ifelse(is.na(q16_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q16_part_11 = ifelse(is.na(q16_part_11), 0, 1))

#12
data_science_ml <- data_science_ml %>%
  mutate(q16_part_12 = ifelse(is.na(q16_part_12), 0, 1))

#13
data_science_ml <- data_science_ml %>%
  mutate(q16_part_13 = ifelse(is.na(q16_part_13), 0, 1))

#14
data_science_ml <- data_science_ml %>%
  mutate(q16_part_14 = ifelse(is.na(q16_part_14), 0, 1))

#15
data_science_ml <- data_science_ml %>%
  mutate(q16_part_15 = ifelse(is.na(q16_part_15), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q16_other = ifelse(is.na(q16_other), 0, 1))

## Q17 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q17_part_1 = ifelse(is.na(q17_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q17_part_2 = ifelse(is.na(q17_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q17_part_3 = ifelse(is.na(q17_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q17_part_4 = ifelse(is.na(q17_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q17_part_5 = ifelse(is.na(q17_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q17_part_6 = ifelse(is.na(q17_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q17_part_7 = ifelse(is.na(q17_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q17_part_8 = ifelse(is.na(q17_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q17_part_9 = ifelse(is.na(q17_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q17_part_10 = ifelse(is.na(q17_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q17_part_11 = ifelse(is.na(q17_part_11), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q17_other = ifelse(is.na(q17_other), 0, 1))

## Q18 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q18_part_1 = ifelse(is.na(q18_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q18_part_2 = ifelse(is.na(q18_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q18_part_3 = ifelse(is.na(q18_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q18_part_4 = ifelse(is.na(q18_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q18_part_5 = ifelse(is.na(q18_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q18_part_6 = ifelse(is.na(q18_part_6), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q18_other = ifelse(is.na(q18_other), 0, 1))

## Q19 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q19_part_1 = ifelse(is.na(q19_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q19_part_2 = ifelse(is.na(q19_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q19_part_3 = ifelse(is.na(q19_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q19_part_4 = ifelse(is.na(q19_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q19_part_5 = ifelse(is.na(q19_part_5), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q19_other = ifelse(is.na(q19_other), 0, 1))

## Q23 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q23_part_1 = ifelse(is.na(q23_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q23_part_2 = ifelse(is.na(q23_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q23_part_3 = ifelse(is.na(q23_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q23_part_4 = ifelse(is.na(q23_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q23_part_5 = ifelse(is.na(q23_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q23_part_6 = ifelse(is.na(q23_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q23_part_7 = ifelse(is.na(q23_part_7), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q23_other = ifelse(is.na(q23_other), 0, 1))

## Q27a ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_1 = ifelse(is.na(q27_a_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_2 = ifelse(is.na(q27_a_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_3 = ifelse(is.na(q27_a_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_4 = ifelse(is.na(q27_a_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_5 = ifelse(is.na(q27_a_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_6 = ifelse(is.na(q27_a_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_7 = ifelse(is.na(q27_a_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_8 = ifelse(is.na(q27_a_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_9 = ifelse(is.na(q27_a_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_10 = ifelse(is.na(q27_a_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q27_a_part_11 = ifelse(is.na(q27_a_part_11), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q27_a_other = ifelse(is.na(q27_a_other), 0, 1))

## Q27b ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_1 = ifelse(is.na(q27_b_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_2 = ifelse(is.na(q27_b_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_3 = ifelse(is.na(q27_b_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_4 = ifelse(is.na(q27_b_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_5 = ifelse(is.na(q27_b_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_6 = ifelse(is.na(q27_b_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_7 = ifelse(is.na(q27_b_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_8 = ifelse(is.na(q27_b_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_9 = ifelse(is.na(q27_b_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_10 = ifelse(is.na(q27_b_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q27_b_part_11 = ifelse(is.na(q27_b_part_11), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q27_b_other = ifelse(is.na(q27_b_other), 0, 1))

## Q36 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q36_part_1 = ifelse(is.na(q36_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q36_part_2 = ifelse(is.na(q36_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q36_part_3 = ifelse(is.na(q36_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q36_part_4 = ifelse(is.na(q36_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q36_part_5 = ifelse(is.na(q36_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q36_part_6 = ifelse(is.na(q36_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q36_part_7 = ifelse(is.na(q36_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q36_part_8 = ifelse(is.na(q36_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q36_part_9 = ifelse(is.na(q36_part_9), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q36_other = ifelse(is.na(q36_other), 0, 1))

## Q37 ----

#1
data_science_ml <- data_science_ml %>%
  mutate(q37_part_1 = ifelse(is.na(q37_part_1), 0, 1))

#2
data_science_ml <- data_science_ml %>%
  mutate(q37_part_2 = ifelse(is.na(q37_part_2), 0, 1))

#3
data_science_ml <- data_science_ml %>%
  mutate(q37_part_3 = ifelse(is.na(q37_part_3), 0, 1))

#4
data_science_ml <- data_science_ml %>%
  mutate(q37_part_4 = ifelse(is.na(q37_part_4), 0, 1))

#5
data_science_ml <- data_science_ml %>%
  mutate(q37_part_5 = ifelse(is.na(q37_part_5), 0, 1))

#6
data_science_ml <- data_science_ml %>%
  mutate(q37_part_6 = ifelse(is.na(q37_part_6), 0, 1))

#7
data_science_ml <- data_science_ml %>%
  mutate(q37_part_7 = ifelse(is.na(q37_part_7), 0, 1))

#8
data_science_ml <- data_science_ml %>%
  mutate(q37_part_8 = ifelse(is.na(q37_part_8), 0, 1))

#9
data_science_ml <- data_science_ml %>%
  mutate(q37_part_9 = ifelse(is.na(q37_part_9), 0, 1))

#10
data_science_ml <- data_science_ml %>%
  mutate(q37_part_10 = ifelse(is.na(q37_part_10), 0, 1))

#11
data_science_ml <- data_science_ml %>%
  mutate(q37_part_11 = ifelse(is.na(q37_part_11), 0, 1))

#other
data_science_ml <- data_science_ml %>%
  mutate(q37_other = ifelse(is.na(q37_other), 0, 1))

# Taking off NA/Other/Unnecessary titles ----

data_science_ml <- data_science_ml %>%
  filter(q5 != "NA") %>%
  filter(q5 != "Student") %>%
  filter(q5 != "Other") %>%
  filter(q5 != "Statistician") %>%
  filter(q5 != "Currently not employed") %>%
  filter(q5 != "DBA/Database Engineer")


# Deleting first line of questions ---- 

# first line states what the question is and it is unnecessary so I am going to delete it
# especially because most of them deleted with the cleaning already

data_science_ml <- data_science_ml[-1,]

# Seeing distribution of q5
data_science_ml %>%
  count(q5)

# write/save data

write.csv(data_science_ml, "data/Processed/data_science_ml_cleaned.csv")


























