# Week 1: Initial Data Exploration ====
# Author: conor toms-kelly
# Date: 30/01/26

# Load packages ====
library(tidyverse)
library(here)
library(naniar)
library(janitor)
library(skimr)

# Load data ====
mosquito_egg_raw <- read_csv(here("week1", "data", "mosquito_egg_data.csv"),
                             name_repair = janitor::make_clean_names)

# Basic overview ====
glimpse(mosquito_egg_raw)
summary(mosquito_egg_raw)
skim(mosquito_egg_raw)

# React table====
# view interactive table of data
view(mosquito_egg_raw)


# Counts by site and treatment====

mosquito_egg_raw |> 
  group_by(site, treatment) |> 
  summarise(n = n())

# Observations ====
# Your observations (add as comments below):
# - What biological system is this?
#   observing mosquito reproduction and the effects of pesticides on how many eggs hatch out of those laid
# - What's being measured?
#   how many of the eggs that are laid end up hatching 
# - How many observations?
#   205 observations
# - Anything surprising?
#   one of the rows (female 23) laid less eggs then was hatched 
# - Any obvious problems?
#   N/As, misspelt columns, collector names wrong, and what was mentioned in the thing that surprised me.


### Duplications ###############################################################
mosquito_egg_raw |>
  get_dupes()

# Keep only unduplicated data with !
mosquito_new <- mosquito_egg_raw |> 
  filter(!duplicated(across(everything()))) 

mosquito_new |>
  get_dupes()  # checking the new data set for dupes

## NAs #########################################################################
mosquito_new |> 
  filter(if_any(everything(), is.na)) # selects all columns in order for the NAs

mosquito_new <- mosquito_new |>
  drop_na()

## Numeric values #############################################################
# Check ranges of all numeric variables at once
mosquito_new |> 
  summarise(across(where(is.numeric), 
                   list(min = ~min(., na.rm = TRUE),
                        max = ~max(., na.rm = TRUE))))

mosquito_new |> ## tells me the same info for more specific columns rather than the whole data set 
  summarise(
    min_mass = min(body_mass_mg, na.rn = TRUE),
    max_mass = max(body_mass_mg, na.rn = TRUE))

# this tells me that there is -ve values in a column where there should only be positive values, one of these includes the body mass colum
# next i need to remove the -ve data from these columns

 

mosquito_new <- mosquito_new |> # mosquito_new |> will only show it, not remove the values
  filter(body_mass_mg >= 10) # displays all +ve values

## Spellings ###################################################################


## Dates #######################################################################