
# swinnotools

<!-- badges: start -->
<!-- badges: end -->

The goal of swinnotools is to ...

## Installation

You can install the development version of swinnotools like so:

``` r
# install.packages("devtools")
devtools::install_github("pjkreutzer/swinnotools")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(swinnotools)

## take collaboration data and turn it into a list of collaborator pairs with sinno ids.

collaboration_data <-
  readxl::read_excel("data/collaboration data.xlsx",
                     .name_repair = janitor::make_clean_names)

pairs <- combine_collaborators(
  collaboration_data,
  id_col = "sinno_id",
  collaborators = c(
    "firm_level_2",
    "collaborator_1",
    "collaborator_2",
    "collaborator_3",
    "collaborator_4",
    "collaborator_5",
    "collaborator_6"
  )
)

```
