library(cronR)
# First cronR job -------------
cmd <- cron_rscript(rscript = "increment_one.R")
cron_add(cmd, frequency = 'minutely', id = 'job1', description = 'Our first cronR job')
cron_ls()
# cronR schedule examples ---------
# Example 1
cron_add(cmd, frequency = 'hourly', id = 'job2')
# Example 2
cron_add(cmd, frequency = 'hourly', id = 'job3', 
         days_of_week = c(1, 2))
# Example 3
cron_add(cmd, frequency = 'hourly', id = 'job4', 
         at = '00:20', days_of_week = c(1, 2))
# Example 4
cron_add(cmd, frequency = 'daily', id = 'job5', 
         at = '14:20')
# Example 5
cron_add(cmd, frequency = 'daily', id = 'job6', 
         at = '23:59', days_of_month = c(1, 30))

# Save and load crontab, and removing cronR jobs ---------------------------
# Save the current crontab (holding active cronR jobs)
cron_save(file = "example_crontab")
# Remove cronR job with id job6
cron_rm(id = "job6")
# Remove all cronR jobs in crontab
cron_clear()
cron_ls() # Confirm no active jobs
# Load the saved crontab (making all saved cronR jobs active)
cron_load(file = "example_crontab")
cron_ls() # Confirm we have active jobs
# Remove all cronR jobs in crontab 
# (so you do not have any jobs active after finishing the examples)
cron_clear()

#In-class exercises:
# We will execute the increment_one.R script in the following cron jobs
cmd <- cron_rscript(rscript = "increment_one.R")
# Exercise 10
# Assuming the current day is Saturday
cron_add(cmd, frequency = 'minutely', id = 'job7', days_of_week = c(6))
# Exercise 11
cron_add(cmd, frequency = 'daily', id = 'job8', days_of_month = c(15),
         at = "04:00")
# Exercise 12
cron_save(file = "my_BI_schedule")
cron_clear()
cron_load(file = "my_BI_schedule")
cron_ls()
cron_clear()


