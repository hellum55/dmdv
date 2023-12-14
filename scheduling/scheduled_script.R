# Get the current datetime
date_time <- format(Sys.time(), digits = 0) 
# Check if "increment_one.rds" exists
if(file.exists("~/dmdv/scheduling/scheduled_script.rds")){
  # If "increment_one.rds exists then we read it into memory
  increment_one <- readRDS(file = "~/dmdv/scheduling/scheduled_script.rds")
  # We add one to the R object
  increment_one <- increment_one + 1
  # The R object is saved to the disk
  saveRDS(increment_one, file = "~/dmdv/scheduling/scheduled_script.rds")  
  # We print the datetime and the value of increment_one.
  # This will be captured by the cronR logger and written to the .log file
  print(paste0("Process complete at: ", date_time))
}else{
  # If "increment_one.rds" does not exist we begin by 1
  increment_one <- 1
  # The R object is saved to the disk
  saveRDS(increment_one, file = "~/dmdv/scheduling/scheduled_script.rds")  
  # We print the datetime and the value of increment_one.
  # This will be captured by the cronR logger and written to the .log file
  print(paste0("Process complete at: ", date_time))
}



