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

## ----echo=TRUE,eval=FALSE-----------------------------------------------------
#  database <-
#    readr::read_csv(here::here("Output/Intermediate/01_prefilter_database.csv"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
database <-
  readr::read_csv(
    system.file(
      "extdata/outpus_vignettes/01_prefilter_database.csv",
      package = "bdc"
    ),
    show_col_types = FALSE
  )

## ----echo=F, message=FALSE, warning=FALSE, eval=TRUE--------------------------
DT::datatable(
  database[1:15,], class = 'stripe', extensions = 'FixedColumns',
  rownames = FALSE,
  options = list(
    pageLength = 3,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## ----eval=F, echo=T-----------------------------------------------------------
#  parse_names <-
#    bdc_clean_names(sci_names = database$scientificName, save_outputs = FALSE)
#  
#  #> >> Family names prepended to scientific names were flagged and removed from 0 records.
#  #> >> Terms denoting taxonomic uncertainty were flagged and removed from 1 records.
#  #> >> Other issues, capitalizing the first letter of the generic name, replacing empty names by NA, and removing extra spaces, were flagged and corrected or removed from 0 records.
#  #> >> Infraspecific terms were flagged and removed from 1 records.
#  #>
#  #> >> Scientific names were cleaned and parsed. Check the results in 'Output/Check/02_clean_names.csv'.

## ----echo=FALSE, eval=TRUE----------------------------------------------------
parse_names <-
  readr::read_csv(
    system.file(
      "extdata/outpus_vignettes/example_clean_names.csv",
      package = "bdc"
    ),
    show_col_types = FALSE
  )

## ----echo=F, message=FALSE, warning=FALSE, eval=TRUE--------------------------
DT::datatable(
  parse_names[60:75,],
  rownames = FALSE,
  class = 'stripe',
  extensions = 'FixedColumns',
  options = list(
    pageLength = 5,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## -----------------------------------------------------------------------------
parse_names <-
  parse_names %>%
  dplyr::select(.uncer_terms, names_clean)

database <- dplyr::bind_cols(database, parse_names)

## ----eval=F-------------------------------------------------------------------
#  query_names <- bdc_query_names_taxadb(
#    sci_name            = database$names_clean,
#    replace_synonyms    = TRUE, # replace synonyms by accepted names?
#    suggest_names       = TRUE, # try to found a candidate name for misspelled names?
#    suggestion_distance = 0.9, # distance between the searched and suggested names
#    db                  = "gbif", # taxonomic database
#    rank_name           = "Plantae", # a taxonomic rank
#    rank                = "kingdom", # name of the taxonomic rank
#    parallel            = FALSE, # should parallel processing be used?
#    ncores              = 2, # number of cores to be used in the parallelization process
#    export_accepted     = FALSE # save names linked to multiple accepted names
#  )
#  
#  #> A total of 0 NA was/were found in sci_name.
#  #>
#  #> 115 names queried in 3.1 minutes

## ----echo=F, eval=T-----------------------------------------------------------
query_names <-
  readr::read_csv(
    system.file(
      "extdata/outpus_vignettes/example_query_names.csv",
      package = "bdc"
    ), show_col_types = F
  )

DT::datatable(
  query_names[1:20,], class = 'stripe', extensions = 'FixedColumns',
  rownames = FALSE,
  options = list(
    pageLength = 5,
    dom = 'Bfrtip',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## -----------------------------------------------------------------------------
database <-
  database %>%
  dplyr::rename(verbatim_scientificName = scientificName) %>%
  dplyr::select(-names_clean) %>%
  dplyr::bind_cols(., query_names)

## ----eval = FALSE-------------------------------------------------------------
#  report <-
#    bdc_create_report(data = database,
#                      database_id = "database_id",
#                      workflow_step = "taxonomy",
#                      save_report = FALSE)
#  
#  report

## ----echo=FALSE, eval=TRUE----------------------------------------------------
report <-
  readr::read_csv(
    system.file("extdata/outpus_vignettes/02_Report_taxonomy.csv", package = "bdc"),
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
#  unresolved_names <-
#    bdc_filter_out_names(data = database,
#                         col_name = "notes",
#                         taxonomic_status = "accepted",
#                         opposite = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  unresolved_names %>%
#    readr::write_csv(., here::here("Output/Check/02_unresolved_names.csv"))

## -----------------------------------------------------------------------------
# output <-
#   bdc_filter_out_names(
#     data = database,
#     taxonomic_notes = "accepted",
#     opposite = FALSE
#   )

## ----eval=FALSE---------------------------------------------------------------
#  # use qs::qsave() to save the database in a compressed format and then qs:qread() to load the database
#  database %>%
#    readr::write_csv(.,
#              here::here("Output", "Intermediate", "02_taxonomy_database.csv"))

