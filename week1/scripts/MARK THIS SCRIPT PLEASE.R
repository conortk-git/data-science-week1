# FIX 1: multiple copies of the same row within the data set ====

# Show the problem:
mosquito_egg_raw |>
  get_dupes()

# Fix it:
mosquito_new <- mosquito_egg_raw |>
  filter(!duplicated(across(everything())))
  
  
  # Verify it worked:
mosquito_new |>
  get_dupes()
  
  
  # What changed and why it matters:
  # duplicates got removed from the data, this then means the data analysis wont be skewwed by multiple copies of he same data
  #
  
  
  # FIX 2: removing NAs from the data set  ====

# Show the problem:
mosquito_new |> 
  filter(if_any(everything(), is.na))

# Fix it:
mosquito_new <- mosquito_new |>
  drop_na()
  
  
  # Verify it worked:
mosquito_new |> 
  filter(if_any(everything(), is.na))
  
  # What changed and why it matters:
  # all NA have been removed
  # this means that all NAs from all columns have been deleted, if i knew the variables we need it could be filtered to keep more rows
  
  
  # FIX 3: impossible values were in the body mass variables   ====

# Show the problem:
 mosquito_new |> 
summarise(across(where(is.numeric), 
                 list(min = ~min(., na.rm = TRUE),
                      max = ~max(., na.rm = TRUE))))

mosquito_new |> ## tells me the same info for more specific columns rather than the whole data set 
  summarise(
    min_mass = min(body_mass_mg, na.rn = TRUE),
    max_mass = max(body_mass_mg, na.rn = TRUE))

# Fix it:
mosquito_new <- mosquito_new |> # mosquito_new |> will only show it, not remove the values
  filter(body_mass_mg >= 10) # displays all +ve values
  
  
  
  # Verify it worked:
mosquito_new |> 
  summarise(
    min_mass = min(body_mass_mg, na.rn = TRUE),
    max_mass = max(body_mass_mg, na.rn = TRUE))
  
  # What changed and why it matters:
  # this has removed all -ve values in the body mass aswell as values that stood out to me as outliers (those below 10)
  # doing this will prevent the analysis from being skewed by -ve values, which would lower averages and other important info 
  
  
  # FIX 4: ammending spelling mistakes within variables using text  ====

# Show the problem:
mosquito_new |> distinct(collector,site,treatment)
mosquito_new |> distinct(site)
mosquito_new |> distinct(treatment)

# Fix it:
mosquito_new <- mosquito_new |>
  mutate(collector = case_when(collector == "Smyth" ~ "Smith", collector == "Garci" ~ "Garcia",.default = as.character(collector)),
         site = case_when(site == "Site C" ~ "Site_C", site == "Site-C" ~ "Site_C", site == "site_c" ~ "Site_C",
                          site == "site_a" ~ "Site_A",site == "Site-A" ~ "Site_A",site == "Site A" ~ "Site_A",
                          site == "site_b" ~ "Site_B",site == "Site-B" ~ "Site_B",site == "Site B" ~ "Site_B",.default = as.character(site)))
  
mosquito_new <- mosquito_new |>
  mutate(treatment = str_to_lower(treatment))

  # Verify it worked:
mosquito_new |> distinct(collector)
mosquito_new |> distinct(site)
mosquito_new |> distinct(treatment)
  
  # What changed and why it matters:
  # all the text has been made into uniform format within their category
  # this means when specific names are used within the script all the related individuals will be used

## i realised after i shouldnt have used mosquito_ new each time as that over writes what has been done before
## next time i will make sure the scripts become new itterations of the previous rather than updating them all to the same script.
## this was all written on the initial_exploration.R script but i transferred it over after as i didnt realise there was a format to follow.