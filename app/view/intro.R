# app/view/intro.R

box::use(
  shiny[actionButton, column, div, fluidRow, h2, moduleServer, NS, observeEvent],
  shiny.router[change_page],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidRow(
    column(
      width = 6,
      div(
        class = "jumbotron",
        h2("Click this button to check out the table:"),
        actionButton(
          inputId = ns("go_to_table"),
          label = "Table",
          class = "btn-primary btn-lg"
        )
      )
    ),
    column(
      width = 6,
      div(
        class = "jumbotron",
        h2("Click this button to check out the chart:"),
        actionButton(
          inputId = ns("go_to_chart"),
          label = "Chart",
          class = "btn-primary btn-lg"
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$go_to_table, {
      change_page("table")
    })

    observeEvent(input$go_to_chart, {
      change_page("chart")
    })
  })
}
