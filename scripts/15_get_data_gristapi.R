library(gristapi)

my_functions <- list.files(path = "R")

# api_key <- Sys.getenv("GRIST_KEY")
# doc_id <- Sys.getenv("GRIST_DOC_TEST")

api <- grist_api$new(
  server = 'https://grist.numerique.gouv.fr', 
  api_key = Sys.getenv("GRIST_KEY"), 
  doc_id = Sys.getenv("GRIST_DOC_ID")
)

api

fetch_grist_db(api)



ma_date <- 1713052800
as.Date(ma_date, origin = "1970-01-01")

d <- as.Date("2024-04-14")
dput(d)

operation <- OPERATION %>% 
  mutate(date2 = Date_operation / 86400,
         date = as.Date(date2))

operation <- operation %>% 
    