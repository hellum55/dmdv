library(httr)
library(jsonlite)
library(tidyverse)

install.packages("httr2")
library(httr2)

# GET dry run examples ------------------------------------------------------------
local_url <- example_url()
local_url
req <- request(local_url)
req %>% 
  req_dry_run()

# GET with parameter and header -------------------------------------------------------
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("fib") %>%
  req_url_query(n = 7) %>%
  req_headers(authorization = "DM_DV_123#!")
req %>% req_dry_run() 
resp <- req %>% 
  req_perform()
resp %>%
  resp_body_string()
# GET with parameters and header API key -----------------------------------------
#Use your own API key for “Planets by API-Ninjas”, and make a
#request with the parameter “name” set to “Venus”.
req <- request("https://planets-by-api-ninjas.p.rapidapi.com") %>%
  req_url_path("v1/planets") %>%
  req_url_query(name = "Venus") %>%
  req_headers('X-RapidAPI-Key' = '76e03ed26fmsh346fa818a10a5c4p1cdcc2jsne6f21bf17ab8',
              'X-RapidAPI-Host' = 'planets-by-api-ninjas.p.rapidapi.com') 
resp <- req %>% 
  req_perform() 
resp %>%
  resp_body_json()
#Above you can change in which format you want

# GET with string response --------------------------------------------
# json
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("responses") %>%
  req_url_query(format = "json") %>%
  req_headers(authorization = "DM_DV_123#!")

response <- req %>% 
  req_perform()
response # Inspect content type
response %>%
  resp_body_json()

#html
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("responses") %>%
  req_url_query(format = "html") %>%
  req_headers(authorization = "DM_DV_123#!")

response <- req %>% 
  req_perform()
response # Inspect content type
response %>%
  resp_body_html()

# POST dry run example ------------------------------------------------------------
# Body as an R list
req_body <- list(x = c(1, 2, 3), y = c("a", "b", "c"))
req_body
# Body transformed to JSON in the request
request(example_url()) %>%
  req_body_json(req_body) %>% 
  req_dry_run()

# POST with data ----------------------------------------------------------
# Simulate data
n <- 100
x1 <- rnorm(n = n)
x2 <- rnorm(n = n)
x3 <- rnorm(n = n)
y <- 2*x1 + 3*x2 + 2*x3 + rnorm(n = n)
df <- round(data.frame(y = y, x1 = x1, x2 = x2, x3 = x3))
# Construct a request including the data
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("lm") %>%
  req_body_json(as.list(df)) %>%
  req_headers(authorization = "DM_DV_123#!")
# Send the request to the API
resp <- req %>% 
  req_perform()
# View the result
resp %>%
  resp_body_json()

# POST with rapid API -----------------------------------------------------
req <- request("https://google-translate1.p.rapidapi.com/language/translate/v2") %>% 
  req_headers('X-RapidAPI-Key' = "76e03ed26fmsh346fa818a10a5c4p1cdcc2jsne6f21bf17ab8",
              'X-RapidAPI-Host' = 'google-translate1.p.rapidapi.com' ) %>%
  req_body_form(q = "Hello, world!",
                target = "da")

resp <- req %>% 
  req_perform()
result <- resp %>%
  resp_body_json()

result$data$
