library(gristapi)

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

# api

fetch_grist_db(api)



# ma_date <- 1713052800
# as.Date(ma_date, origin = "1970-01-01")


operation <- operation %>% 
  mutate(Date_operation = Date_operation / 86400,
         Date_operation = as.Date(Date_operation))

operation <- operation %>% 
  mutate(Strate_arboree_RG = str_detect(string = Strates_ripisylve_RD, pattern = "Arborée"),
         Strate_arbustive_RG = str_detect(string = Strates_ripisylve_RD, pattern = "Arbustive"),
         Strate_herbacee_RG = str_detect(string = Strates_ripisylve_RD, pattern = "Herbacée"),
         Absence_ripisylve_RG = str_detect(string = Strates_ripisylve_RD, pattern = "Absence"),
         Strate_arboree_RD = str_detect(string = Strates_ripisylve_RD, pattern = "Arborée"),
         Strate_arbustive_RD = str_detect(string = Strates_ripisylve_RD, pattern = "Arbustive"),
         Strate_herbacee_RD = str_detect(string = Strates_ripisylve_RD, pattern = "Herbacée"),
         Absence_ripisylve_RD = str_detect(string = Strates_ripisylve_RD, pattern = "Absence")) %>% 
  select(-Strates_ripisylve_RG,  -Strates_ripisylve_RD) %>% 
  mutate(Nb_petits_bois = ifelse(Nb_petits_bois == "nan", NA, Nb_petits_bois),
         Nb_petits_bois = as.numeric(Nb_petits_bois),
         Nb_blocs = ifelse(Nb_blocs == "nan", NA, Nb_blocs),
         Nb_blocs = as.numeric(Nb_blocs))






# vrac essais
operation3 <- operation %>% 
  cg_unnest()

df <- operation   %>% 
 unnest_wider(pH, names_sep='_')

my_nested_vars_index <- map_lgl(.x = names(df),
                                .f = ~is.list(df[[.]]))
my_nested_vars <- names(df)[my_nested_vars_index]

l <- df$Strates_ripisylve_RG
str_detect(l, pattern = "Herb")

removeL(l)
test <- appendL(l)
test <- as.character(l)

