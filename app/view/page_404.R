# app/view/page_404.R

box::use(
  shiny[a, div, h1, moduleServer, NS],
  shiny.router[route_link],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  div(
    h1("Whoops! Something went wrong!"),
    a("Back to home page", href = route_link("/"), class = "btn btn-primary btn-lg")
  )
}
