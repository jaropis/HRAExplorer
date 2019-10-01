#' module to show results for a single recording on the flip side
#' @export
single_resultsUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns("single_table"))
}


#' function to build the table with results for
#' @export
single_results <- function(input, output, session,
                           type_of_plot,
                           line_number,
                           rct_current_pp_values) {
  data_line <- rct_current_pp_values()[line_number, ]
  if (type_of_plot == "poincare") {
    html_description <- poincare_description_string(data_line)
  }

  if (type_of_plot == "runs") {
    html_description <- runs_description_tring(data_line)
  }

  output$single_table <- renderUI(HTML(html_description))
}

# ----
# Functions
#
#' function returning Poincare descriptors
#'
#' @param data_line named vector with Poincare descriptors
#'
#' @return HTML string
#' @export
poincare_description_string <- function(data_line) {
  paste("<div id='poincare_plot'>",
        "<hr>",
        "<h4>HRV</h4>",
        "<hr>",
        "<strong>SDNN</strong>:", data_line["SDNN"], ", <strong>SD1</strong>:", data_line["SD1"], ", <strong>SD2</strong>:", data_line["SD2"],
        "<hr>",
        "<h4>HRA</h4>",
        "<hr>",
        "<strong>SD1<sub>d</sub></strong>:", data_line["SD1d"], ", <strong>SD1<sub>a</sub></strong>:", data_line["SD1a"], "<br />",
        "<strong>SD2<sub>d</sub></strong>:", data_line["SD2d"], ", <strong>SD2<sub>a</sub></strong>:", data_line["SD2a"], "<br />",
        "<hr>",
        "<strong>SDNN<sub>d</sub></strong>:", data_line["SDNNd"], ", <strong>SDNN<sub>a</sub></strong>:", data_line["SDNNa"],
        "</div>",
        collapse="")
}