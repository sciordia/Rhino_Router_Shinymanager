# app/main.R

box::use(
  shiny[actionButton, fluidPage, mainPanel, moduleServer, NS, observeEvent, reactiveValuesToList,
        renderPrint, tags, titlePanel, verbatimTextOutput],
  shinymanager,
)

box::use(
  app/view/home,
)

# Define the `check_credentials` function
check_credentials <- shinymanager$check_credentials(
  data.frame(user = "shiny", password = "1", start = "2019-04-15", expire = NA, admin = FALSE, stringsAsFactors = FALSE)
)


# Customize some labels displayed in application
shinymanager$set_labels(
  language = "es",
  "Please authenticate" = "",
  "Username:" = "Usuario:",
  "Password:" = "Contraseña:"
)

#' @export
ui <- shinymanager$secure_app(

  #Setup Shinymanager
  fab_position = "none", # Hide logout button /Position: "bottom-left"/
  language = "es",
  tags_top =
    tags$div(
      tags$head(tags$title("My First Website - Login") # Webpage Title
      ),
      tags$img(src = "static/images/SVG_Logo.svg", width = "180px"),
    ),

  tags_bottom = tags$div(
    tags$p(tags$strong("User: shiny ; Pass: 1"), align = "center"),
    tags$p(
      "Para cualquier consulta, contactar con el ",
      tags$a(
        href = "mailto:sciordia@cnb.csic.es?Subject=CNB%20Proteomics%20Facility%20-%20Problem",
        target="_top", "administrador"
      ), align = "center"
    )
  ),

  fluidPage(
    tags$head(tags$title("My First Website - Inicio")), # Web Title
    home$ui("home"),
  )
)

#' @export
server <- function(input, output, session) {

    result_auth <- shinymanager$secure_server(check_credentials)

    home$server("home")
}
