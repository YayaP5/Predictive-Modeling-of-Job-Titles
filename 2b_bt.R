library(tidyverse)
library(tidymodels)
library(xgboost)

#load workflows, folds, and controls

load("results/info_bt.rda")

bt_fit_folds_2 <- tune_grid(bt_workflow_2, resamples =  data_folds, grid = bt_grid)

write_rds(bt_fit_folds_2, file = "results/bt_fit_folds_2.rds")