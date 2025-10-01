library(gristapi)
library(tidyverse)

my_functions <- list.files(path = "R", pattern = ".R", full.names = TRUE)
map(.x = my_functions,
    .f = source)

# api_key <- Sys.getenv("GRIST_KEY")
# doc_id <- Sys.getenv("GRIST_DOC_TEST")

api <- grist_api$new(
  server = 'https://grist.numerique.gouv.fr', 
  api_key = Sys.getenv("GRIST_KEY"), 
  doc_id = Sys.getenv("GRIST_DOC_ID")
)

fetch_grist_db(api)

operation <- operation %>% 
  mutate(Date_operation = Date_operation / 86400,
         Date_operation = as.Date(Date_operation))

operation <- operation %>% 
  split_list_col(var_id = Operation, var_split = Strates_ripisylve_RG) %>% 
  split_list_col(var_id = Operation, var_split = Strates_ripisylve_RD) %>% 
  select(-Strates_ripisylve_RG, -Strates_ripisylve_RD) %>% 
  mutate(Nb_petits_bois = ifelse(Nb_petits_bois == "nan", NA, Nb_petits_bois),
         Nb_petits_bois = as.numeric(Nb_petits_bois),
         Nb_blocs = ifelse(Nb_blocs == "nan", NA, Nb_blocs),
         Nb_blocs = as.numeric(Nb_blocs))

my_dfs <- Filter(function(x) is.data.frame(get(x)) , ls())

save(list = my_dfs, file = "processed_data/grist_dfs.rda")







