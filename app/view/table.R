# app/view/table.R

box::use(
  reactable,
  shiny[h3, moduleServer, NS, observeEvent, reactive, req, tagList],
  shiny.router[change_page, get_query_param],
)

box::use(
  app/logic/data_transformation[transform_data],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    h3("Table"),
    reactable$reactableOutput(ns("table"))
  )
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    page_size <- reactive({
      page_size <- get_query_param("pageSize")

      if (is.null(page_size)) {
        page_size <- 10
      }

      as.numeric(page_size)
    })

    output$table <- reactable$renderReactable({
      data |>
        transform_data() |>
        reactable$reactable(
          defaultPageSize = page_size(),
          showPageSizeOptions = TRUE,
          pageSizeOptions = c(5, 10, 15, 20, page_size()) |>
            unique() |>
            sort()
        )
    })

    observeEvent(reactable$getReactableState("table", "pageSize"), {
      table_page_size <- reactable$getReactableState("table", "pageSize")

      if (table_page_size != page_size()) {
        change_page(paste0("table?pageSize=", table_page_size))
      }
    })
  })
}
