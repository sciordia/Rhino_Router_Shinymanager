# app/home.R

box::use(
  shiny[a, fluidPage, moduleServer, tags, NS],
  shiny.router[router_ui, router_server, route, route_link],
)

# Modules
box::use(
  app/view/intro,
  app/view/chart,
  app/view/table,
  app/view/page_404,
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  fluidPage(
    tags$nav(
      class = "navbar",
      tags$ul(
        class = "nav navbar-nav",
        tags$li(
          a("Home", href = route_link("/"))
        ),
        tags$li(
          a("Table", href = route_link("table"))
        ),
        tags$li(
          a("Chart", href = route_link("chart"))
        )
      )
    ),
    router_ui(
      route("/", intro$ui(ns("intro"))),
      route("table", table$ui(ns("table"))),
      route("chart", chart$ui(ns("chart"))),
      page_404 = page_404$ui(ns("page_404"))
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    router_server("/")

    # Datasets are the only case when you need to use :: in `box`.
    # This issue should be solved in the next `box` release.
    data <- rhino::rhinos

    intro$server("intro")
    table$server("table", data = data)
    chart$server("chart", data = data)
  })
}
