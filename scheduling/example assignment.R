library(cronR)
cmd <- cron_rscript(rscript = "scheduled_script.R")
cron_add(cmd, frequency = 'minutely', id = 'job1', 
         days_of_month = c(14), description = 'exam')
cron_ls()
cron_clear()
