get_grist_table <-
  function(url = "https://grist.numerique.gouv.fr/api/docs/qkEHgz98d6QGkSVX1HF4d4/sql",
           token = Sys.getenv('GRIST_TBV_API_KEY'),
           table) {
    #paramètre
    query_params <- list(q = paste0("SELECT * FROM ", table))
    
    # En-têtes de la requête
    headers <- c("accept" = "application/json",
                 "Authorization" = paste("Bearer", token))
    
    # Exécution de la requête GET
    response <- httr::GET(url,
                          query = query_params,
                          httr::add_headers(.headers = headers))
    
    # Vérification du statut de la réponse
    if (httr::http_status(response)$category == "Success") {
      # Extraction du contenu JSON de la réponse
      json_content <-
        httr::content(response, as = "text", encoding = "UTF-8")
      
      # Conversion du JSON en dataframe R
      data <- jsonlite::fromJSON(json_content)$records$fields
      
      data
    } else {
      # Affichage d'un message d'erreur si la requête a échoué
      cat("La requête a échoué. Statut :",
          httr::status_code(response),
          "\n")
      print(httr::content(response, as = "text", encoding = "UTF-8"))
    }
    
    
  }
