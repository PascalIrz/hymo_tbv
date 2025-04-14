load_grist_tbv_data <- function(
    url = "https://grist.numerique.gouv.fr/api/docs/qkEHgz98d6QGkSVX1HF4d4/sql",
    token = Sys.getenv('GRIST_TBV_API_KEY'),
    tables = c("STATION", "OPERATION", "FACIES", "WOLMAN", "PHOTOS", "TRANSECT")) {
  
  dfs <- map(.x = tables,
        .f = get_grist_table,
      url = url,
      token = token)
  
  names(dfs) <- str_to_lower(tables)
  
  clean_dfs <- map(.x = dfs,
      .f = clean_get_grist)
  
  list2env(clean_dfs ,.GlobalEnv)
}


