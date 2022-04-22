## ---- include = FALSE---------------------------------------------------------
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

## ----echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE-----------------------
metadata <-
  readr::read_csv(system.file("extdata/Config/DatabaseInfo.csv",
                              package = "bdc"),
                  show_col_types = FALSE)

## ----echo=FALSE, message=FALSE, warning=FALSE, eval=TRUE----------------------
DT::datatable(
metadata, 
class = 'stripe', extensions = c('FixedColumns', 'Buttons'),
rownames = FALSE,
 options = list(
   #dom = 't',
   dom = 'Bfrtip',
   scrollX = TRUE,
   pageLength = 9,
   buttons = c('copy', 'csv', 'print'),
   fixedColumns = list(leftColumns = 2),
   editable = 'cell'
 )
)

## ----eval=FALSE---------------------------------------------------------------
#  # Path to the folder containing the example datasets. For instance:
#  path <- "C:/Users/myname/Documents/myproject/input_files/"
#  
#  # Change in the Configuration table the path to the folder in your computer containing the example datasets
#  metadata$fileName <-
#    gsub(pattern = "https://raw.githubusercontent.com/brunobrr/bdc/master/inst/extdata/input_files/",
#         replacement = path,
#         x = metadata$fileName)

## ----message=FALSE, warning=FALSE, eval=FALSE---------------------------------
#  database <-
#  bdc_standardize_datasets(metadata = metadata,
#                           format = "csv",
#                           overwrite = TRUE,
#                           save_database = TRUE)
#  
#  #>  0sStandardizing AT_EPIPHYTES file
#  #>  0s 0sStandardizing BIEN file
#  #>  0s 0sStandardizing DRYFLOR file
#  #>  0s 0sStandardizing GBIF file
#  #>  0s 0sStandardizing ICMBIO file
#  #>  0s 0sStandardizing IDIGBIO file
#  #>  0s 0sStandardizing NEOTROPTREE file
#  #>  0s 0sStandardizing SIBBR file
#  #>  0s 0sStandardizing SPECIESLINK file
#  #>
#  #> C:/Users/Bruno R. Ribeiro/Desktop/bdc/Output/Intermediate/00_merged_database.csv was created

## ----echo=FALSE, eval=TRUE, message=FALSE, warning=FALSE----------------------
database <-
  readr::read_csv(system.file("extdata/outpus_vignettes/00_merged_database.csv", package = "bdc"), show_col_types = FALSE)

## ----echo=F, message=FALSE, warning=FALSE, eval=TRUE--------------------------
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

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
config_description <-
  readr::read_csv(system.file("extdata/Config/DatabaseInfo_description.csv", package = "bdc"), show_col_types = FALSE)

## ----echo=FALSE, message=FALSE, warning=FALSE, eval=TRUE----------------------
DT::datatable(
  config_description,
  rownames = FALSE,
  class = 'stripe',
  extensions = c('FixedColumns', 'Buttons'),
  options = list(
    #dom = 't',
    dom = 'Bfrtip',
    scrollX = TRUE,
    pageLength = 9,
    buttons = c('copy', 'csv', 'print'),
    fixedColumns = list(leftColumns = 2),
    editable = 'cell'
  )
)

