

fetch_grist_db <- function(api) {
  
  fetch_grist_table <- function(api, table) {
    
    df <- fetch_table(api, table)
    assign(x = table, value = df, envir = globalenv())
    
  }
  
  tables <- listtables(api) %>% pull(id)
  
  map(.x = tables,
      .f = fetch_grist_table,
      api = api)
  
}
  
