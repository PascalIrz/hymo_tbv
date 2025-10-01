#' Split a Grist list-column (multi-values columns such as reference lists) into logical variables
#' 
#' It is splitted into one variable per "factor level". 
#'
#' @param df The dataframe with the data
#' @param var_id The variable that uniquely identifies the rows of the df
#' @param var_split The list-column variable to split
#'
#' @return The modified dataframe
#' @export
#'
#' @examples
#' 
#' 
split_list_col <- function(df, var_id, var_split) {
  
# manage quotation
  var_id <- enquo(var_id)
  var_split <- enquo(var_split)

# get variable names as strings 
  var_id_name <- df %>%
     select(!!var_id) %>% 
     names()
  
  var_split_name <- df %>%
    select(!!var_split) %>% 
    names()

# split the variable
  data <- df %>%
    select(!!var_id, !!var_split) %>% 
    unnest_longer(!!var_split) %>%
    filter(!!var_split != 'L') %>%
    table %>%
    as.data.frame.matrix %>%
    mutate(across(, as.logical)) %>%
    rownames_to_column(var = var_id_name)

# concatenate new variable names as "old_var_name:factor_level"
  names(data)[2:length(names(data))] <- paste(var_split_name, names(data)[2:length(names(data))], sep = ':')

# assemble the output 
  df %>%
    left_join(y = data)
  
}



