get_grist_tables <- function(
    url = "https://grist.numerique.gouv.fr/api/docs/qkEHgz98d6QGkSVX1HF4d4/sql",
    token = Sys.getenv('GRIST_TBV_API_KEY'),
    tables = c("STATION", "OPERATION", "FACIES", "WOLMAN", "PHOTOS", "TRANSECT")) {
  
  dfs <- map(.x = tables,
        .f = get_grist_table,
      url = url,
      token = token)
  
  names(dfs) <- str_to_lower(tables)
  
  clean_dfs <- map(.x = dfs,
      .f = cg_unnest)
  
  list2env(clean_dfs ,.GlobalEnv)
}


