# ============================================================
# META-ANALYSIS IN R
# Author: Titus Robert Leeyio
# Purpose: Reproducible workflow for pairwise meta-analysis
# ============================================================

# 1. CLEAR THE WORKSPACE --------------------------------------
rm(list = ls())

# 2. LOAD REQUIRED PACKAGES -----------------------------------
pacman::p_load(tidyverse, meta, metafor, ggplot2, devtools, robvis, readxl)

# 3. CHECK WORKING DIRECTORY ----------------------------------
getwd()

# 4. IMPORT DATA ----------------------------------------------
Maerobic <- read_excel("data/aerobic.xlsx")
names(Maerobic)
str(Maerobic)
dim(Maerobic)

# 6. META-ANALYSIS: SYSTOLIC BLOOD PRESSURE -------------------
sytometa <- metacont(n.e = total1, mean.e = Ms1, sd.e = Sds1, n.c = total0, mean.c = Ms0, sd.c = Sds0, studlab = paste(trial, Year), data = Maerobic, sm = "MD", method.tau = "REML", random = TRUE, common = T)

# Display results
summary(sytometa)

# FOREST PLOT: SYSTOLIC BLOOD PRESSURE ---------------------
forest(sytometa, common = FALSE, random = TRUE, prediction = TRUE, leftcols = c("studlab", "n.e", "n.c"), leftlabs = c("Study", "Aerobic", "Control"), rightcols = c("effect", "ci", "w.random"), rightlabs = c("MD", "95% CI", "Weight"), xlab = "Mean Difference in Systolic Blood Pressure (mmHg)", smlab = "", print.I2 = TRUE, print.tau2 = TRUE, print.pval.Q = TRUE, digits = 2)

# 7. META-ANALYSIS: DIASTOLIC BLOOD PRESSURE ------------------
diastometa <- metacont(n.e = total1, mean.e = Md1, sd.e = Sdd1, n.c = total0, mean.c = Md0, sd.c = Sdd0, studlab = paste(trial, Year), data = Maerobic, sm = "MD", method.tau = "REML", random = TRUE, common = TRUE)

# Display results
summary(diastometa)

# FOREST PLOT: DIASTOLIC BLOOD PRESSURE --------------------
forest(diastometa, common = FALSE, random = TRUE, prediction = TRUE, leftcols = c("studlab", "n.e", "n.c"), leftlabs = c("Study", "Aerobic", "Control"), rightcols = c("effect", "ci", "w.random"), rightlabs = c("MD", "95% CI", "Weight"), xlab = "Mean Difference in Diastolic Blood Pressure (mmHg)", smlab = "", print.I2 = TRUE, print.tau2 = TRUE, print.pval.Q = TRUE, digits = 2)
