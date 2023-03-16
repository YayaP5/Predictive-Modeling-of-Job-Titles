library(tidyverse)
library(tidymodels)
library(kknn)

#load workflows, folds, and controls

load("results/info_knn.rda")

knn_fit_folds_2 <- tune_grid(knn_workflow_2, resamples =  data_folds, grid = knn_grid)

write_rds(knn_fit_folds_2, file = "results/knn_fit_folds_2.rds")