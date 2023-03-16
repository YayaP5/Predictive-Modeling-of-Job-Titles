# load library and results ----

## library ----
library(tidyverse)
library(tidymodels)
library(janitor)
library(yardstick)
library(ggplot2)

## results ----
load("results/data_ml_split.rda")
load("results/info_null.rda")
tunned_knn_1 <- read_rds("results/knn_fit_folds_1.rds")
tunned_bt_1 <- read_rds("results/bt_fit_folds_1.rds")
tunned_rf_1 <- read_rds("results/rf_fit_folds_1.rds")
tunned_en_1 <- read_rds("results/elastic_fit_folds_1.rds")
fitted_mn_1 <- read_rds("results/multi_fit_folds_1.rds")

tunned_knn_2 <- read_rds("results/knn_fit_folds_2.rds")
tunned_bt_2 <- read_rds("results/bt_fit_folds_2.rds")
tunned_rf_2 <- read_rds("results/rf_fit_folds_2.rds")
tunned_en_2 <- read_rds("results/elastic_fit_folds_2.rds")
fitted_mn_2 <- read_rds("results/multi_fit_folds_2.rds")

# Model Result Analysis ----

## autoplot results ----
autoplot(tunned_knn_1, metric = "roc_auc")
autoplot(tunned_bt_1, metric = "roc_auc")
autoplot(tunned_knn_1, metric = "roc_auc")
autoplot(tunned_rf_1, metric = "roc_auc")
autoplot(tunned_en_1, metric = "roc_auc")
autoplot(tunned_knn_2, metric = "roc_auc")
autoplot(tunned_bt_2, metric = "roc_auc")
autoplot(tunned_knn_2, metric = "roc_auc")
autoplot(tunned_rf_2, metric = "roc_auc")
autoplot(tunned_en_2, metric = "roc_auc")


## show best parameters for each model ----
knn_1_best <- show_best(tunned_knn_1, metric = "roc_auc") [1,]
knn_2_best <- show_best(tunned_knn_2, metric = "roc_auc") [1,]

bt_1_best <- show_best(tunned_bt_1, metric = "roc_auc") [1,]
bt_2_best <- show_best(tunned_bt_2, metric = "roc_auc") [1,]

rf_1_best <- show_best(tunned_rf_1, metric = "roc_auc") [1,]
rf_2_best <- show_best(tunned_rf_2, metric = "roc_auc") [1,]

en_1_best <- show_best(tunned_en_1, metric = "roc_auc") [1,]
en_2_best <- show_best(tunned_en_2, metric = "roc_auc") [1,]

# doesnt work
#mn_1_best <- show_best(fitted_mn_1, metric = "roc_auc") [1,]
mn_2_best <- show_best(fitted_mn_2, metric = "roc_auc") [1,]

## table of results ----
results <- en_1_best %>%
  mutate(model = "en_kitchen") %>%
  bind_rows(knn_1_best %>% mutate(model = "knn_kitchen")) %>%
  bind_rows(knn_2_best %>% mutate(model = "knn_alternative")) %>%
  bind_rows(bt_1_best %>% mutate(model = "bt_kitchen")) %>%
  bind_rows(bt_2_best %>% mutate(model = "bt_alternative")) %>%
  bind_rows(rf_1_best %>% mutate(model = "rf_kitchen")) %>%
  bind_rows(rf_2_best %>% mutate(model = "rf_alternative")) %>%
  bind_rows(en_2_best %>% mutate(model = "en_alternative")) %>%
  bind_rows(mn_2_best %>% mutate(model = "mn_alternative")) %>%
  bind_rows(baseline %>% mutate(model = "null")) %>%
  arrange(desc(mean))

# Finalized data ----
load("results/info_en.rda")

## finalizing workflow ----
en_workflow <- en_workflow_1 %>%
  finalize_workflow((select_best(tunned_en_1, metric = "roc_auc")))

## fit entire training dataset to workflow ----
fit_final <- fit(en_workflow, data_ml_train)

## finding classifications ----
en_results <- predict(fit_final, data_ml_test, type = "class") %>%
  bind_cols(data_ml_test %>% select(q5)) %>%
  mutate(q5 = as.factor(q5))

# Accuracy and Confusion matrix -----

## accuracy ----
baseline_accuracy <- null_fit %>%
  collect_metrics() %>%
  filter(.metric == "accuracy") 

en_accuracy <- accuracy(en_results, truth = q5, estimate = .pred_class) 




## confusion matrix ----
conf_mat(en_results, q5, .pred_class)

en_conf_matrix <- en_results %>%
  conf_mat(q5, .pred_class) %>%
  autoplot(type = "heatmap")

## roc_curve ----
prob_en <- data_ml_test %>%
  bind_cols(predict(fit_final, data_ml_test, type = "prob")) %>%
  select(q5, starts_with(".pred_"))

roc_curve_seperate <- prob_en %>%
  mutate(q5 = as.factor(q5)) %>%
  roc_curve(q5, starts_with(".pred_")) %>%
  autoplot()

roc_curve_together <- prob_en %>%
  mutate(q5 = as.factor(q5)) %>%
  roc_curve(q5, starts_with(".pred_")) %>%
  ggplot(aes(x = 1-specificity, y = sensitivity, color = .level)) +
  geom_abline(lty = 2, color = "gray80", size = 0.9) +
  geom_path(show.legend = T, alpha = 0.6, size = 1.2) +
  theme_minimal() +
  coord_equal()

save(roc_curve_seperate, baseline_accuracy, roc_curve_together, prob_en, en_conf_matrix,en_accuracy, results, file = "graphics/graphs.rda" )



