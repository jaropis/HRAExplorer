#' alternative for null
#'
#' @param x value being checked for null
#' @param y default expression value
#' @return x if not null, y otherwise
#'
#' @export
`%||%` <- function(x, y) {
  if (is.null(x))
    return(y)
  x
}


#' function to get initial data addresses
#'
#' @return data frame with info on the initial files
#' @export
calculate_data_addresses <- function() {
  pattern <- paste0("../initial_data/*", glob_init_file_extension)
  initial_files <- Sys.glob(pattern)
  names <- unname(
    vapply(initial_files, function(x) strsplit(x, "/")[[1]][3], FUN.VALUE = c("a"))
  )
  types <- rep("text/plain", length(names))
  dataPaths <- data.frame(name = names, size = 0,
                          type = types,
                          datapath = initial_files,
                          stringsAsFactors = FALSE)
  return(dataPaths)
}

#' Function running loader/spinner
#' @param path that to the svg loader
#' @param timeout how long to wait to show spinner after registering shiny-busy
#' @param interval how check check for shinyBusy
#' @param sleep the shortest time spinner shows
#'
#' @export
loader <- function(path,
                   timeout = 1000,
                   interval = 1000,
                   sleep = 1000) {
  if (isTruthy(path)) {
    tagList(
      tags$div(
        class = "spinnerLoading overlay",
        id = "loader",
        tags$p(
          id = "pWithLoader",
          tags$img(src = path)
        )
      ),
      tags$script(
        sprintf("waitForEl('div.wrapper', startSpinner, [%d, %d, %d])", timeout, sleep, interval)
      )
    )
  } else {
    NULL
  }
}

#' Function checking if the uploaded files are Excel files
#' @param files_list
#' @return boolean
#'
#' @export
check_for_format <- function(files_list) {
  first_file_split <- files_list[1, ]$datapath %>%
    strsplit(split = "\\.")
  if (first_file_split[[1]][length(first_file_split[[1]])] %in% c('xlsx', 'xls')) {
    return ('excel')
  }
  if (first_file_split[[1]][length(first_file_split[[1]])] %in% 'mat') {
    return ('matlab')
  }
  return('csv')
}

#' Function producing sample table for preview
#' @param samp_table data frame
#' @return data frame
#'
#' @export
sample_table <- function(samp_table) {
  values <- lapply(samp_table, as.character) %>%
    as.data.frame()
  samp_names <- names(samp_table)
  result <- rbind(samp_names, values)
  names(result) <- as.character(seq_len(ncol(samp_table)))
  result
}
