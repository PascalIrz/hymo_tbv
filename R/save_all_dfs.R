save_all_dfs <- function(file) {
  
  my_dfs <- Filter(function(x) is.data.frame(get(x)) , ls(envir = globalenv()))
  save(list = my_dfs, file = file)
  
}





