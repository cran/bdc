## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%",
  echo = TRUE,
  warning = FALSE,
  eval = TRUE
)

## ---- echo = FALSE, eval = TRUE, include = FALSE, messages = FALSE------------
library(bdc)
# if (!requireNamespace("rnaturalearthhires", quietly = TRUE))
#   remotes::install_github("ropensci/rnaturalearthhires")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  database <-
#    readr::read_csv(here::here("Output/Intermediate/00_merged_database.csv"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
database <-
  readr::read_csv(
    system.file("extdata/outpus_vignettes/00_merged_database.csv", package = "bdc"),
    show_col_types = FALSE
  )

## ----echo=FALSE, message=FALSE, warning=FALSE, eval=TRUE----------------------
DT::datatable(
  database[1:15,], class = 'stripe', extensions = 'FixedColumns',
  rownames = FALSE,
  options = list(
    pageLength = 5,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <-
#    bdc_scientificName_empty(
#    data = database,
#    sci_name = "scientificName")
#  
#  #> bdc_scientificName_empty:
#  #> Flagged 5 records.
#  #> One column was added to the database.

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <- bdc_coordinates_empty(
#    data = check_pf,
#    lat = "decimalLatitude",
#    lon = "decimalLongitude")
#  
#  #> bdc_coordinates_empty:
#  #> Flagged 44 records.
#  #> One column was added to the database.

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <- bdc_coordinates_outOfRange(
#    data = check_pf,
#    lat = "decimalLatitude",
#    lon = "decimalLongitude")
#  
#  #> bdc_coordinates_outOfRange:
#  #> Flagged 1 records.
#  #> One column was added to the database.

## ----eval=FALSE---------------------------------------------------------------
#  # Check record sources of your dataset using:
#  # check_pf %>%
#  #   dplyr::group_by(basisOfRecord) %>%
#  #   dplyr::summarise(n = dplyr::n())
#  
#  check_pf <- bdc_basisOfRecords_notStandard(
#    data = check_pf,
#    basisOfRecord = "basisOfRecord",
#    names_to_keep = "all")
#  
#  #> bdc_basisOfRecords_notStandard:
#  #> Flagged 0 of the following specific nature:
#  #>  character(0)
#  #> One column was added to the database.

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <- bdc_country_from_coordinates(
#    data = check_pf,
#    lat = "decimalLatitude",
#    lon = "decimalLongitude",
#    country = "country")
#  
#  #> bdc_country_from_coordinates:
#  #> Country names were added to 27 records.

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <- bdc_country_standardized(
#    data = check_pf,
#    country = "country"
#  )
#  
#  #> Standardizing country names
#  #>
#  #> country found: Bolivia
#  #> country found: Brazil
#  #>   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed=00s
#  #>   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed=00s
#  #>   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed=00s
#  #>
#  #> bdc_country_standardized:
#  #> The country names of 65 records were standardized.
#  #> Two columns ('country_suggested' and 'countryCode') were added to the database.

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <-
#    bdc_coordinates_transposed(
#      data = check_pf,
#      id = "database_id",
#      sci_names = "scientificName",
#      lat = "decimalLatitude",
#      lon = "decimalLongitude",
#      country = "country_suggested",
#      countryCode = "countryCode",
#      border_buffer = 0.2, # in decimal degrees (~22 km at the equator)
#      save_outputs = FALSE
#    )
#  
#  #> Correcting latitude and longitude transposed
#  #>
#  #> 15 occurrences will be tested
#  #> Processing occurrences from: BR (15)
#  #> No latitude and longitude were transposed

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <-
#    bdc_coordinates_country_inconsistent(
#      data = check_pf,
#      country_name = "Brazil",
#      country = "country_suggested",
#      lon = "decimalLongitude",
#      lat = "decimalLatitude",
#      dist = 0.1 # in decimal degrees (~11 km at the equator)
#    )
#  
#  #> dist is assumed to be in decimal degrees (arc_degrees).
#  #> although coordinates are longitude/latitude, st_intersection assumes that they are planar
#  #>
#  #> bdc_coordinates_country_inconsistent:
#  #> Flagged 15 records.
#  #> One column was added to the database.

## ----eval=FALSE---------------------------------------------------------------
#  xyFromLocality <- bdc_coordinates_from_locality(
#    data = check_pf,
#    locality = "locality",
#    lon = "decimalLongitude",
#    lat = "decimalLatitude",
#    save_outputs = FALSE
#  )
#  
#  #> bdc_coordinates_from_locality
#  #> Found 38 records missing or with invalid coordinates but with potentially useful information on locality

## ----eval=FALSE---------------------------------------------------------------
#  check_pf <- bdc_summary_col(data = check_pf)
#  
#  #> bdc_summary_col:
#  #> Flagged 65 records.
#  #> One column was added to the database.

## ----echo=FALSE, message=FALSE, warning=FALSE, eval=TRUE----------------------
# DT::datatable(
#   check_pf, class = 'stripe', extensions = 'FixedColumns',
#   rownames = FALSE,
#   options = list(
#     pageLength = 3,
#     dom = 'Bfrtip',
#     scrollX = TRUE,
#     fixedColumns = list(leftColumns = 2)
#   )
# )

## ----eval=FALSE---------------------------------------------------------------
#  report <-
#    bdc_create_report(data = check_pf,
#                      database_id = "database_id",
#                      workflow_step = "prefilter",
#                      save_report = FALSE)
#  
#  report

## ----eval=TRUE, echo=FALSE----------------------------------------------------
report <-
  readr::read_csv(
    system.file("extdata/outpus_vignettes/01_Report_Prefilter.csv",
                package = "bdc"),
    show_col_types = FALSE
  )

## ----echo=FALSE, message=FALSE, warning=FALSE, eval=TRUE----------------------
DT::datatable(
  report, class = 'stripe', extensions = 'FixedColumns',
  rownames = FALSE,
  options = list(
    # pageLength = 5,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## ----eval=FALSE---------------------------------------------------------------
#  figures <-
#  bdc_create_figures(data = check_pf,
#                     database_id = "database_id",
#                     workflow_step = "prefilter",
#                     save_figures = FALSE)
#  
#  # Check figures using
#  figures$.coordinates_country_inconsistent

## ----eval=FALSE---------------------------------------------------------------
#  output <-
#    check_pf %>%
#    dplyr::filter(.summary == TRUE) %>%
#    bdc_filter_out_flags(data = ., col_to_remove = "all")
#  
#  #> bdc_fiter_out_flags:
#  #> The following columns were removed from the database:
#  #> .scientificName_empty, .coordinates_empty, .coordinates_outOfRange, .basisOfRecords_notStandard, .coordinates_country_inconsistent, .summary

## ----eval=FALSE---------------------------------------------------------------
#  # use qs::qsave() to save the database in a compressed format and then qs:qread() to load the database
#  output %>%
#    readr::write_csv(.,
#              here::here("Output", "Intermediate", "01_prefilter_database.csv"))

