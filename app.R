library(shiny)
library(toastui)
library(dplyr)


ui <- fluidPage(
  tags$h2("Exemple calendari"),
  fluidRow(
    column(
      width = 8,
      calendarOutput("my_calendar")
    ),
    column(
      width = 4,
      tags$b("Seleccion:"),
      checkboxGroupInput(inputId = 'linea_sel',
                         label = NULL,
                         choiceNames = c('Hamburgesas', 'Empanizados'),
                         choiceValues = c(1, 2),
                         selected = c(1, 2)
                         )
    )
  )
)

server <- function(input, output, session) {
  # Lectura de dades de les prediccions
  file_in <- './data/calendari_prediccions.csv'
  calendari <- read.csv2(file_in)

  output$my_calendar <- renderCalendar({
    calendar(calendari %>% filter(calendarId %in% input$linea_sel), navigation = TRUE) %>%
      cal_props(
        list(
          id = 1,
          name = "Hamburgesas",
          color = "black",
          bgColor = "#34dbeb",
          borderColor = "#34dbeb"
        ),
        list(
          id = 2,
          name = "Empanizados",
          color = "black",
          bgColor = "#34eb7a",
          borderColor = "#34eb7a"
        )
      )
  })
  
}

if (interactive())
  shinyApp(ui, server)
