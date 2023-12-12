library(RPostgres)
library(DBI)
# Put the credentials in this script
# Never push credentials to git!! --> use .gitignore on .credentials.R
source("credentials.R")
# Function to send queries to Postgres
source("psql_queries.R")
# Create a new schema in Postgres on docker
psql_manipulate(cred = cred_psql_docker, 
                query_string = "CREATE SCHEMA intg1;")
# Create a table in the new schema 
psql_manipulate(cred = cred_psql_docker, 
                query_string = 
"create table intg1.students (
	student_id serial primary key,
	student_name varchar(255),
	department_code int
);")
# Write rows in the new table
psql_manipulate(cred = cred_psql_docker, 
                query_string = 
"insert into intg1.students
	values (default, 'Hugo', 1)
		  ,(default, 'Timo', 2);")
# Create an R dataframe
df <- data.frame(student_name = c("Nemo", "Ulla"),
                 department_code = c(2, 1))
# Write the dataframe to a postgres table (columns with default values are skipped)
students <- psql_append_df(cred = cred_psql_docker, 
                             schema_name = "intg1", 
                             tab_name = "students", 
                             df = df)
# Fetching rows into R
psql_select(cred = cred_psql_docker, 
            query_string = "select * from intg1.students;")

# Delete schema
psql_manipulate(cred = cred_psql_docker, 
                query_string = "drop SCHEMA intg1 cascade;")








