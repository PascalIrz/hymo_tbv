#' Split a Grist list-column (multi-values columns such as reference lists) into logical variables.
#' 
#' The multiple choice reference lists in a Grist database are stored as list-variables including a "L" prefix.  
#' The split_list_col() function splits such variables into a set of Boolean variables. 
#'
#' @param df The dataframe with at least one variable that uniquely identifies each row
#'   and one variable that has to be split (see below).
#' @param var_id The variable that uniquely identifies the rows of the df.
#' @param var_split The list-column variable to split.
#' 
#' @importFrom dplyr select filter enquo mutate across left_join
#' @importFrom tidyr function unnest_longer
#' @importFrom tibble rownames_to_column
#'
#' @return The dataframe completed by the new logical variables.
#' @export
#'
#' @examples
#' data <-
#' structure(
#'   list(
#'     site = c(1L, 7L, 34L),
#'     strates = list(
#'       list("L", "Herbacée", "Arbustive", "Arborée"),
#'       list("L", "Arbustive"),
#'       list("L", "Arbustive", "Arborée")
#'     )
#'   ),
#'   row.names = c(NA,-3L),
#'   class = c("tbl_df", "tbl", "data.frame")
#' )
#' 
#' data
#' 
#' data %>% 
#'   split_list_col(var_id = site, var_split = strates) 
#' 
#' 
split_list_col <- function(df, var_id, var_split) {
  
# manage quotation
  var_id <- dplyr::enquo(var_id)
  var_split <- dplyr::enquo(var_split)

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
    mutate(!!var_id := as.character(!!var_id)) %>% # necessary to homogenize variable classes before joining
    left_join(y = data)
  
}



