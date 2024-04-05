#https://github.com/daattali/shinyforms

install.packages("devtools")
devtools::install_github("daattali/shinyforms")

library(shiny)
library(shinyforms)
# install.packages("googlesheets")
library(googlesheets4)

# Create a new google sheets file 
# df <- data.frame(name = "", age = 0, favourite_pkg = "", terms = TRUE)
# google_df <- gs_new("responses", input = df, trim = TRUE, verbose = FALSE)
google_df <- rio::import("/Users/robwells/Downloads/mob_analysis test - mob_analysis_jan_25.csv")

questions <- list(
  list(id = "name", type = "text", title = "Name", mandatory = TRUE),
  list(id = "age", type = "numeric", title = "Age"),
  list(id = "favourite_pkg", type = "text", title = "Favourite R package"),
  list(id = "terms", type = "checkbox", title = "I agree to the terms")
) 

formInfo <- list(
  id = "basicinfo",
  questions = questions,
  storage = list(
    # Right now, only flat file storage is supported
    type = STORAGE_TYPES$FLATFILE,
    # The path where responses are stored
    path = "responses",
    # Get the Google sheet key 
    key = google_df
  )
)

ui <- fluidPage(
  formUI(formInfo)
)

server <- function(input, output, session) {
  formServer(formInfo)
}

shinyApp(ui = ui, server = server)


