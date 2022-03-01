## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%",
  echo = TRUE,
  warning = FALSE,
  eval = T
)

## ---- echo = FALSE, eval = TRUE, include = FALSE, messages = FALSE------------
library(bdc)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  database <-
#    readr::read_csv(here::here("Output/Intermediate/03_space_database.csv"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
database <-
  readr::read_csv(system.file("extdata/outpus_vignettes/03_space_database.csv", package = "bdc"), show_col_types = FALSE)

## ----echo=F, message=FALSE, warning=FALSE-------------------------------------
DT::datatable(
  database, class = 'stripe', extensions = 'FixedColumns',
  options = list(
    pageLength = 3,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## -----------------------------------------------------------------------------
check_time <-
  bdc_eventDate_empty(data = database, eventDate = "verbatimEventDate")

## -----------------------------------------------------------------------------
check_time <-
  bdc_year_from_eventDate(data = check_time, eventDate = "verbatimEventDate")

## -----------------------------------------------------------------------------
check_time <-
  bdc_year_outOfRange(data = check_time,
                      eventDate = "year",
                      year_threshold = 1900)

## -----------------------------------------------------------------------------
check_time <- bdc_summary_col(data = check_time)

## ----eval=FALSE---------------------------------------------------------------
#  report <-
#    bdc_create_report(data = check_time,
#                      database_id = "database_id",
#                      workflow_step = "time",
#                      save_report = FALSE)
#  
#  report

## ----echo=FALSE, eval=TRUE----------------------------------------------------
report <-
  readr::read_csv(
    system.file("extdata/outpus_vignettes/04_Report_time.csv",
                package = "bdc"),
    show_col_types = FALSE
  )

## ----echo=FALSE, message=FALSE, warning=FALSE, eval=TRUE----------------------
DT::datatable(
  report, class = 'stripe', extensions = 'FixedColumns',
  options = list(
    # pageLength = 5,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## ----eval=FALSE---------------------------------------------------------------
#  bdc_create_figures(data = check_time,
#                     database_id = "database_id",
#                     workflow_step = "time",
#                     save_figures = FALSE)
#  
#  # Check figures using
#  figures$time_year_BAR

## ----eval=FALSE---------------------------------------------------------------
#  check_time %>%
#    readr::write_csv(.,
#              here::here("Output", "Intermediate", "04_time_raw_database.csv"))

## -----------------------------------------------------------------------------
output <-
  check_time %>%
  dplyr::filter(.summary == TRUE) %>%
  bdc_filter_out_flags(data = ., col_to_remove = "all")

## ----eval=FALSE---------------------------------------------------------------
#  output %>%
#    readr::write_csv(.,
#              here::here("Output", "Intermediate", "04_time_clean_database.csv"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
output <-
  readr::read_csv(
    system.file(
      "extdata/outpus_vignettes/04_time_clean_database.csv",
      package = "bdc"
    ),
    show_col_types = FALSE
  )

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
DT::datatable(
  output, class = 'stripe', extensions = 'FixedColumns',
  options = list(
    pageLength = 3,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

