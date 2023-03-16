# load libraries -----
library(tidyverse)
library(readr)
library(skimr)
library(stringr)
library(tidymodels)
library(recipes)
library(yardstick)
library(janitor)
library(ggplot2)

# set seed ----
set.seed(555)

# read in data ----
data_ml <- read_csv("Data/Processed/data_science_ml_cleaned.csv")

# split and train data ----
# split
data_ml_split <- initial_split(data_ml, prop = 0.7, strata = q5)

#train/test
data_ml_train <- training(data_ml_split)
data_ml_test <- testing(data_ml_split)

# folds ----
data_folds <- vfold_cv(data_ml_train, v = 5, repeats = 3, strata = q5)

# data exploration ----

## outcome variable ----
ggplot(data_ml, aes(x = q5)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 10))

ggplot(data_ml_train, aes(x = q1)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 10))

ggplot(data_ml_train, aes(x = q2)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 10))

ggplot(data_ml_train, aes(x = q3)) +
  geom_bar() +
  coord_flip()

ggplot(data_ml_train, aes(x = q4)) +
  geom_bar() +
  coord_flip()

ggplot(data_ml_train, aes(x = q8)) +
  geom_bar() +
  coord_flip()

ggplot(data_ml_train, aes(x = q13)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 10)) +
  coord_flip()
# TPUs are googles custom developed circuits used to accelerate machine learning workloads 

ggplot(data_ml_train, aes(x = q15)) +
  geom_bar() +
  coord_flip()

#theme angle text thing
ggplot(data_ml_train, aes(x = q22)) +
  geom_bar() +
  coord_flip()

# compensation
ggplot(data_ml_train, aes(x = q24)) +
  geom_bar() +
  coord_flip()

ggplot(data_ml_train, aes(x = q25)) +
  geom_bar() +
  coord_flip()

skim(data_ml_train)

save(data_ml_train, data_ml_test, file = "results/data_ml_split.rda")
# recipes ----

## kitchen sink recipe ----
data_ml_kitchen <- recipe(q5 ~., data = data_ml_train) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_impute_mode(all_nominal_predictors()) %>%
  step_dummy(all_nominal_predictors(), one_hot = TRUE) %>%
  step_nzv(all_predictors()) 

prep(data_ml_kitchen) %>%
  bake(new_data = NULL)

## alternative recipe ----

alternative_recipe <- recipe(q5 ~ q25 + q24 + q22 + q15 + q13 + q8, data = data_ml_train) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_impute_mode(all_nominal_predictors()) %>%
  step_dummy(all_nominal_predictors(), one_hot = TRUE) %>%
  step_nzv(all_predictors()) 

prep(alternative_recipe) %>%
  bake(new_data = NULL)

## null recipe ----

null_spec <- null_model() %>%
  set_engine("parsnip") %>%
  set_mode("classification")

null_workflow <- workflow() %>%
  add_model(null_spec) %>%
  add_recipe(data_ml_kitchen)

null_fit <- fit_resamples(null_workflow,
                          resamples = data_folds,
                          control = control_resamples(save_pred = TRUE))

baseline <- null_fit %>%
  collect_metrics() %>%
  filter(.metric == "roc_auc") %>%
  mutate(wflow_id = "null")


save(baseline, null_fit, file = "results/info_null.rda")

# models ----

## nearest neighbors ----
knn_model <- nearest_neighbor(mode = "classification", neighbors = tune()) %>%
  set_engine("kknn")

neighbors()

knn_params <- parameters(knn_model)

knn_grid <- grid_regular(knn_params, levels = 5)

knn_workflow_1 <- workflow() %>%
  add_model(knn_model) %>%
  add_recipe(data_ml_kitchen)

knn_workflow_2 <- workflow() %>%
  add_model(knn_model) %>%
  add_recipe(alternative_recipe)

save(knn_workflow_1, knn_workflow_2, knn_grid, data_folds, file = "results/info_knn.rda")


## boosted tree ----
bt_model <- boost_tree(mode = "classification", 
                       min_n = tune(),
                       mtry = tune(),
                       learn_rate = tune()) %>%
  set_engine("xgboost")

learn_rate()
mtry()
bt_parameters <- parameters(bt_model) %>%
  update(mtry = mtry(range = c(1,15)))

bt_grid <- grid_regular(bt_parameters, levels = 5)

bt_workflow_1 <- workflow() %>%
  add_model(bt_model) %>%
  add_recipe(data_ml_kitchen)

bt_workflow_2 <- workflow() %>%
  add_model(bt_model) %>%
  add_recipe(alternative_recipe)

save(bt_workflow_1, bt_workflow_2, bt_grid, data_folds, file = "results/info_bt.rda")


## random forest ----
rf_model <- rand_forest(mode = "classification",
                        min_n = tune(),
                        mtry = tune()) %>% 
  set_engine("ranger")

rf_params <- parameters(rf_model) %>%
  update(mtry = mtry(c(1, 15)))

rf_grid <- grid_regular(rf_params, levels = 5)

rf_workflow_1 <- workflow() %>%
  add_model(rf_model) %>%
  add_recipe(data_ml_kitchen)

rf_workflow_2 <- workflow() %>%
  add_model(rf_model) %>%
  add_recipe(alternative_recipe)

save(rf_workflow_1, rf_workflow_2, rf_grid, data_folds, file = "results/info_rf.rda")

## elastic net ----
elastic_model <- multinom_reg(penalty = tune(), mixture = tune()) %>%
  set_engine('glmnet')


elastic_param <- extract_parameter_set_dials(elastic_model)
elastic_grid <- grid_regular(elastic_param, levels = 5)

en_workflow_1 <- workflow() %>%
  add_model(elastic_model) %>%
  add_recipe(data_ml_kitchen)

en_workflow_2 <- workflow() %>%
  add_model(elastic_model) %>%
  add_recipe(alternative_recipe)

save(en_workflow_1, en_workflow_2, elastic_grid, data_folds, file = "results/info_en.rda")

## multinom ----

multinom_model <- multinom_reg(penalty = 0) %>%
  set_engine('nnet')

mn_workflow_1 <- workflow() %>%
  add_model(multinom_model) %>%
  add_recipe(data_ml_kitchen)

mn_workflow_2 <- workflow() %>%
  add_model(multinom_model) %>%
  add_recipe(alternative_recipe)

# fit to resamples 
save(mn_workflow_1, mn_workflow_2, data_folds, file = "results/info_multi.rda")





