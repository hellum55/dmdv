which_seed <- sample(1:10000, 1)

req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("getrand") %>%
  req_url_query(which_seed = which_seed) %>%
  req_headers(authorization = "123#!_DM_DV")

response <- req %>% 
  req_perform()
response # Inspect content type
response %>%
  resp_body_json()