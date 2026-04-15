# Homework 13
# 4.15.26

library(tidyverse)
library(lubridate)
library(lme4)
library(car)

bee_dat <- read_csv("Burnham_field_data_pathogens_wide.csv")

bee_dat <- bee_dat %>%
  mutate(
    sampling_date = mdy(sampling_date),
    site_code = factor(site_code),
    field_id = factor(field_id),
    bee_caste = factor(bee_caste),
    bombus_spp = factor(bombus_spp),
    host_plant = factor(host_plant),
    sampling_event = factor(sampling_event),
    sampling_event_num = as.numeric(as.character(sampling_event)),
    log10_BQCV_load = log10(BQCV_pathogen_load + 1),
    log10_DWV_load = log10(DWV_pathogen_load + 1),
    log10_Nosema_load = log10(Nosema_pathogen_load + 1)
  )

glimpse(bee_dat)

df_filtered <- bee_dat[bee_dat$log10_DWV_load > 0 & bee_dat$log10_BQCV_load > 0, ]

#At least one non-guassian distribution
#At least one interaction term
#At least one mixed model with a random effect.

# int term: does one variable depend on the value of another variable
# host plant and 


# random: accounts for error associated with variables, and removes them so you can focus on other variables
# host plant has an impact, so if remove it can you just see then how disease varies across bombus


# Question 1
# does different sampling events have an impact on disease abundance?

m_q1 <- glm(data = bee_dat, DWV_pathogen_binary + BQCV_pathogen_load + Nosema_pathogen_binary ~sampling_event,
family = binomial(link="logit"))

summary(m_cat_cont)

# Question 2
# remove sampling events to look at if the type host plants affect disease prevelence?