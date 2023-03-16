library(tidyverse)
library(tidymodels)
library(nnet)

#load workflows, folds, and controls
load("results/info_multi.rda")

multi_fit_folds_1 <- fit_resamples(mn_workflow_1, resamples =  data_folds, control = control_resamples(save_pred = TRUE))

write_rds(multi_fit_folds_1, file = "results/multi_fit_folds_1.rds")