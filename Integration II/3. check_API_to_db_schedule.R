library(RPostgres)
library(DBI)
library(tidyverse)
library(httr2)
library(lubridate)
# Load credentials
source("~/dmdv/Integration 1/.credentials.R")
# Load functions to communicate with Postgres
source("psql_queries.R")
# Check updating Microsoft ------------------------------------------------
# Delete some observations from the table
psql_manipulate(cred = cred_psql_docker,
                query_string = 
                  "delete 
                   from stock.prices
                   where
                   price_sk = (select price_sk 
                              from stock.prices
                              where symbol_fk = 1
                              order by timestamp_utc desc
                              limit 1);")
# Check most recent prices
psql_select(cred = cred_psql_docker, 
            query_string = 
              "select timestamp_utc 
               from stock.prices
               where symbol_fk = 1
               order by timestamp_utc desc
               limit 5;")
# Run the scheduled function 1 time
source("~/dmdv/Integration II/2. API_to_db_scheduled.R")
# Check that things has been reinserted
psql_select(cred = cred_psql_docker, 
            query_string = 
              "select * 
               from stock.prices
               where symbol_fk = 1
               order by timestamp_utc desc
               limit 5;")
# Check updating Tesla ------------------------------------------------
# Delete some observations from the table
psql_manipulate(cred = cred_psql_docker,
                query_string = 
                  "delete 
                   from stock.prices
                   where
                   price_sk = (select price_sk 
                              from stock.prices
                              where symbol_fk = 2
                              order by timestamp_utc desc
                              limit 1);")
# Check most recent prices
psql_select(cred = cred_psql_docker, 
            query_string = 
              "select * 
               from stock.prices
               where symbol_fk = 2
               order by timestamp_utc desc
               limit 5;")
# Run the scheduled function 1 time
source("~/dmdv/Integration II/2. API_to_db_scheduled.R")
# Check that things has been reinserted
psql_select(cred = cred_psql_docker, 
            query_string = 
              "select * 
               from stock.prices
               where symbol_fk = 2
               order by timestamp_utc desc
               limit 5;")
