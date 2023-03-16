library(tidyverse)
library(tidymodels)
library(ranger)

#load workflows, folds, and controls
load("results/info_rf.rda")

rf_fit_folds_2 <- tune_grid(rf_workflow_2, resamples =  data_folds, grid = rf_grid)

write_rds(rf_fit_folds_2, file = "results/rf_fit_folds_2.rds")