# =============================================================================
# Is the spike in reporting significant?
# Version 3.3.1
# Updated: 2016-10-24
# =============================================================================

library(tidyverse)
library(readxl)
library(lubridate)
library(ez)
library(multcomp)
library(nlme)

# Read in data
col_info <- c(
  # "col_name",     "col_type"
  "agency",       "text",
  "confim_num",   "text",
  "created",      "date",
  "reported",     "date",
  "electronic",   "text",
  "phone",        "text",
  "response_num", "text")

# Import data
medstar_aps <- read_excel(
  path = "/Users/bradcannell/Desktop/APS Report Data_UNTHSC_IRB.xlsx",
  sheet = "owssvr",
  col_names = col_info[seq(1, length(col_info), 2)],
  col_types = col_info[seq(2, length(col_info), 2)],
  skip = 1)

# Remove all the CPS cases
medstar_aps <- filter(medstar_aps, agency == "APS")

# Remove 2016 cases
medstar_aps <- filter(medstar_aps, reported <= as.POSIXct("2016-01-01"))

# Select the reported date
reports <- dplyr::select(medstar_aps, reported)

# Add a month column to the reports_date data
reports <- reports %>%
  mutate(
    month = month(reported),
    week  = week(reported))

# Add dummy variable for pilot condition (exact)
# Add dummy variable for pilot condition (carried forward)
start <- as.POSIXct("2015-09-17")
end   <- as.POSIXct("2015-10-27")
reports <- reports %>%
  mutate(
    pilot_ext = ifelse(reported >= start & reported <= end, 1, 0),
    pilot_cf  = ifelse(reported >= start, 1, 0))

# View distribution of reports
ggplot(reports, aes(x = week)) +
  geom_histogram()

ggplot(reports, aes(x = month)) +
  geom_histogram()

# This data is from medstar_reports_to_aps_2015.Rmd
ggplot(reports_month, aes(x = count_month)) +
  geom_histogram()
# Actually sort of normal'ish

# Just do the repeated measures ANOVA, then ask Doug about the count data.

# Groups are before and after pilot test
# Dependent variable = number of reports
# Independent variable = DETECT tool
# I just have repeated measures of one "person" - MedStar

# Plot the mean number of monthly reports by group (carried forward)
reports_mnth <- reports %>%
  group_by(pilot_cf, month) %>%
  count %>%
  ungroup %>%
  mutate(
    pilot_cf = factor(pilot_cf),
    month    = factor(month))

# Save data as csv
write_csv(reports_mnth, "/Users/bradcannell/Desktop/aps_reports.csv")

ggplot(reports_mnth, aes(x = pilot_cf, y = n, fill = pilot_cf)) +
  geom_boxplot() +
  geom_jitter()

stats <- function(x) {
  count <- function(x) length(na.omit(x))
  c(
    n = count(x),
    missing = sum(is.na(x)),
    mean = mean(x, na.rm=TRUE),
    median = median(x, na.rm=TRUE),
    var = var(x, na.rm = TRUE),
    sd = sd(x, na.rm=TRUE),
    sem = sqrt(var(x, na.rm=TRUE)/length(na.omit(x))),
    lcl = mean(x, na.rm=TRUE) - qt(.975, count(x) - 1)*sd(x, na.rm = TRUE) /
      sqrt(count(x)),
    ucl = mean(x, na.rm=TRUE) + qt(.975, count(x) - 1)*sd(x, na.rm = TRUE) /
      sqrt(count(x)),
    min = min(x, na.rm=TRUE),
    max = max(x, na.rm=TRUE)
  )
}

with(reports_mnth, by(n, pilot_cf, stats))

# Run repeated measures ANOVA (p. 568, loc 16600)
model_anova <- ezANOVA(data = reports_mnth, dv = n, within = pilot_cf)

























