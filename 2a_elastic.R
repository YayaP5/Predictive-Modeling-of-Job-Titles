library(tidyverse)
library(tidymodels)
library(glmnet)

#load workflows, folds, and controls
load("results/info_elastic.rda")

elastic_fit_folds_1 <- tune_grid(en_workflow_1, resamples =  data_folds, grid = elastic_grid)

write_rds(elastic_fit_folds_1, file = "results/elastic_fit_folds_1.rds")