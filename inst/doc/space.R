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
#    readr::read_csv(here::here("Output/Intermediate/02_taxonomy_database.csv"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
database <-
  readr::read_csv(system.file("extdata/outpus_vignettes/02_taxonomy_database.csv", package = "bdc"), show_col_types = FALSE)

## ----eval=FALSE---------------------------------------------------------------
#  check_space <-
#    bdc_coordinates_precision(
#      data = database,
#      lon = "decimalLongitude",
#      lat = "decimalLatitude",
#      ndec = c(0, 1) # number of decimals to be tested
#    )
#  #> bdc_coordinates_precision:
#  #> Flagged 2 records
#  #> One column was added to the database.

## ----eval=FALSE---------------------------------------------------------------
#  check_space <-
#    CoordinateCleaner::clean_coordinates(
#      x =  check_space,
#      lon = "decimalLongitude",
#      lat = "decimalLatitude",
#      species = "scientificName",
#      countries = ,
#      tests = c(
#        "capitals",     # records within 2km around country and province centroids
#        "centroids",    # records within 1km of capitals centroids
#        "duplicates",   # duplicated records
#        "equal",        # records with equal coordinates
#        "gbif",         # records within 1 degree (~111km) of GBIF headsquare
#        "institutions", # records within 100m of zoo and herbaria
#        "outliers",     # outliers
#        "zeros",        # records with coordinates 0,0
#        "urban"         # records within urban areas
#      ),
#      capitals_rad = 2000,
#      centroids_rad = 1000,
#      centroids_detail = "both", # test both country and province centroids
#      inst_rad = 100, # remove zoo and herbaria within 100m
#      outliers_method = "quantile",
#      outliers_mtp = 5,
#      outliers_td = 1000,
#      outliers_size = 10,
#      range_rad = 0,
#      zeros_rad = 0.5,
#      capitals_ref = NULL,
#      centroids_ref = NULL,
#      country_ref = NULL,
#      country_refcol = "countryCode",
#      inst_ref = NULL,
#      range_ref = NULL,
#      # seas_ref = continent_border,
#      # seas_scale = 110,
#      urban_ref = NULL,
#      value = "spatialvalid" # result of tests are appended in separate columns
#    )
#  #> Testing coordinate validity
#  #> Flagged 0 records.
#  #> Testing equal lat/lon
#  #> Flagged 0 records.
#  #> Testing zero coordinates
#  #> Flagged 0 records.
#  #> Testing country capitals
#  #> Flagged 0 records.
#  #> Testing country centroids
#  #> Flagged 0 records.
#  #> Testing urban areas
#  #> Downloading urban areas via rnaturalearth
#  #> trying URL 'http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_urban_areas.zip'
#  #> Content type 'application/zip' length 452644 bytes (442 KB)
#  #> downloaded 442 KB
#  #>
#  #> OGR data source with driver: ESRI Shapefile
#  #> Source: "C:\Users\Bruno R. Ribeiro\AppData\Local\Temp\RtmpCo3Lyf", layer: "ne_50m_urban_areas"
#  #> with 2143 features
#  #> It has 4 fields
#  #> Integer64 fields read as strings:  scalerank
#  #> Flagged 6 records.
#  #> Testing geographic outliers
#  #> Testing GBIF headquarters, flagging records around Copenhagen
#  #> Flagged 0 records.
#  #> Testing biodiversity institutions
#  #> Flagged 0 records.
#  #> Testing duplicates
#  #> Flagged 0 records.
#  #> Flagged 6 of 115 records, EQ = 0.05.

## ----eval=FALSE---------------------------------------------------------------
#  check_space <- bdc_summary_col(data = check_space)
#  #> Column '.summary' already exist. It will be updated
#  #>
#  #> bdc_summary_col:
#  #> Flagged 9 records.
#  #> One column was added to the database.

## ----echo=FALSE, eval=TRUE----------------------------------------------------
check_space <-
  readr::read_csv(system.file("extdata/outpus_vignettes/03_space_database.csv", package = "bdc"), show_col_types = FALSE)

## ----echo=FALSE, message=FALSE, warning=FALSE, eval=TRUE----------------------
DT::datatable(
  check_space[1:15,], class = 'stripe', extensions = 'FixedColumns',
  rownames = FALSE,
  options = list(
    pageLength = 5,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## ----eval=FALSE---------------------------------------------------------------
#  check_space %>%
#    dplyr::filter(.summary == FALSE) %>% # map only records flagged as FALSE
#    bdc_quickmap(
#      data = .,
#      lon = "decimalLongitude",
#      lat = "decimalLatitude",
#      col_to_map = ".summary",
#      size = 0.9
#    )

## ----eval=FALSE---------------------------------------------------------------
#  report <-
#    bdc_create_report(data = check_space,
#                      database_id = "database_id",
#                      workflow_step = "space",
#                      save_report = FALSE)
#  
#  report

## ----echo=FALSE, eval=TRUE----------------------------------------------------
report <-
  readr::read_csv(
    system.file("extdata/outpus_vignettes/03_Report_space.csv", package = "bdc"),
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

## ---- eval=FALSE--------------------------------------------------------------
#  figures <-
#  bdc_create_figures(data = check_space,
#                     database_id = "database_id",
#                     workflow_step = "space",
#                     save_figures = TRUE)
#  
#  # Check figures using
#  figures$.rou

## -----------------------------------------------------------------------------
# output <-
#   check_space %>%
#   dplyr::filter(.summary == TRUE) %>%
#   bdc_filter_out_flags(data = ., col_to_remove = "all")

## ----eval=FALSE---------------------------------------------------------------
#  # use qs::qsave() to save the database in a compressed format and then qs:qread() to load the database
#  check_space %>%
#   readr::write_csv(.,
#              here::here("Output", "Intermediate", "03_space_database.csv"))

