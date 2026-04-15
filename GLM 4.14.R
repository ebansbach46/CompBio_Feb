# GLM 4.14.26 (general linear model)
# gaustian = regular linear model

library(tidyverse)
library(lubridate)
library(lme4)
library(car)
# into console: install.packages("lme4")
# into colsonle: install.packages("car")
# install.packages("tidyverse")
# install.packages("lubridate")

# reading in data set
bee_dat <- read_csv("Burnham_field_data_pathogens_wide.csv")

# renaming vars
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

# check data
hist(df_filtered$log10_DWV_load)
hist(df_filtered$log10_BQCV_load)

# filter for only pos:
df_filtered <- bee_dat[bee_dat$log10_DWV_load > 0 & bee_dat$log10_BQCV_load > 0, ]

qplot(
  x = log10_BQCV_load,
  y = log10_DWV_load,
  data = df_filtered) +
geom_smooth(method = "lm", se = TRUE)


# continuous y continuous x
# m <-model
# y as a functin of x
m_cont_cont <- lm(data = df_filtered, log10_DWV_load~log10BQCV_load) # data set, y by x variables
summary(m_cont_cont) # how to look for significance quickly

# continuous y catagorical x
# ANOVA
# ~ means "as a function of"
m_cont_cat <- lm(data = df_filtered, log10_BQCV_load~bombus_spp)
summary(m_cont_cat)


# catagorical y continuous x
# glm includes the zeros that gaustian excludes
m_cat_cont <- glm(data = bee_dat, DWV_pathogen_binary~log10_BQCV_load,
family = binomial(link="logit"))

summary(m_cat_cont)

# catagorical y vs catagorical x
m_cat_cat <- glm(data = bee_dat, DWV_pathogen_binary~bee_caste,
family = binomial(link="logit"))

summary(m_cat_cat)


# significance testing
# car package (companion of applied regression)

# build some models
# binomial model
bin_mod <- glm(data = bee_dat, DWV_pathogen_binary ~ bombus_spp * sampling_event + host_plant, family = binomial(link="logit"))

# gaustian model
guas_mod <- lm(data = bee_dat, log10_Nosema_load ~ sampling_event * host_plant)

summary(bin_mod)
summary(guas_mod)

# using the car package for significance
# analysis of devience = binomial  ---> Anova
Anova(bin_mod)
Anova(guas_mod)

# liklihood ratio test
m_dwv_null <- lm(data = df_filtered, log10_DWV_load ~ 1)
m_dwv_full <- lm(data = df_filtered, log10_DWV_load ~ sampling_event + host_plant)

anova(m_dwv_null, m_dwv_full, test = "LRT")
# create null model with a 1 there, has no predictive power to the integer there
# then create model of interest (full), then run anova, test = likliehood ratio test

# reduced model - (some variable)
# removed host plant here
m_dwv_reduced <- lm(data = df_filtered, log10_DWV_load ~ sampling_event)

anova(m_dwv_reduced, m_dwv_full, test = "LRT")
# tells you how important is the host plant

# Random effects:
# accounts for error associated with variables, and removes them so you can focus on other variables
# the reducing var are in ( | )
g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code/time_block),
  data = df_filtered)
# use nesting (the use of  "/" ) if the variables are related to each other

Anova(g_bqcv_site)
# not significant

g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code) + (1 | day),
  data = df_filtered)
# variables are unrelated to each other

# gamma are continuous and non zero positive values, so only want to use positive values
# generally right skewed

# make pos only nosema
nosPos <- bee_dat[bee_dat$Nosema_pathogen_load > 0,]

# gamma
nos_gamma <- glmer(
  Nosema_pathogen_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos, family = Gamma)
Anova(nos_gamma)

# diff
nos_gamma <- glmer(
  Nosema_pathogen_load ~ bombus_spp * sampling_event + (1 | site_code),
  data = nosPos, family = Gamma)

# differences in parameters
nos_gamma <- lmer(
  log10_Nosema_load ~ bombus_spp * sampling_event + (1 | site_code),
  data = nosPos, )

# use the correct distribution before going to try to log transform it
# if can more accurately describe data with a different distribution then use that distribution
