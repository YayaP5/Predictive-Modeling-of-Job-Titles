library(tidyverse)
library(tidymodels)
library(xgboost)

#load workflows, folds, and controls

load("results/info_bt.rda")

bt_fit_folds_1 <- tune_grid(bt_workflow_1, resamples =  data_folds, grid = bt_grid)

write_rds(bt_fit_folds_1, file = "results/bt_fit_folds_1.rds")