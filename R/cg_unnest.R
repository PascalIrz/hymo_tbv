cg_unnest <- function(df)
  
{
  
  my_nested_vars_index <- map_lgl(.x = names(df),
                                  .f = ~is.list(df[[.]]))
  
  my_nested_vars <- names(df)[my_nested_vars_index]
  
  out <- df %>% 
    tidyr::unnest_wider(col = my_nested_vars, names_sep = "_") %>% 
    select(-(ends_with("_type"))) %>%
    select(-(ends_with("_data")))
  
}
