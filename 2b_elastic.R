library(tidyverse)
library(tidymodels)
library(glmnet)

#load workflows, folds, and controls
load("results/info_elastic.rda")

elastic_fit_folds_2 <- tune_grid(en_workflow_2, resamples =  data_folds, grid = elastic_grid)

write_rds(elastic_fit_folds_2, file = "results/elastic_fit_folds_2.rds")