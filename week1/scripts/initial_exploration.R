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


mosquito_egg_raw |>
  get_dupes()

# Keep only unduplicated data with !
mosquito_new <- mosquito_egg_raw |> 
  filter(!duplicated(across(everything()))) 

mosquito_new |>
  get_dupes()  # checking the new data set for dupes

# checking for and removing NAs
mosquito_new |> 
  filter(if_any(everything(), is.na))
select(everything()) # selects all columns in order 

mosquito_new <- mosquito_new |>
  drop_na()
