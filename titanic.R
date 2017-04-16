# Import excel file
library(readxl)
titanic_original = read_excel("titanic3.xls")
write.csv(titanic_original,"titanic_original.csv")

# install.packages("tidyr")
library(tidyr)
# install.packages("dplyr")
library(dplyr)
library(tibble)

# Add "S" to NA embarked rows
titanic = titanic_original
titanic$embarked = replace(titanic$embarked,which(is.na(titanic$embarked)),"S")

# Add mean age to blank ages
titanic$age = replace(titanic$age,which(is.na(titanic$age)),round(mean(titanic$age,na.rm=TRUE),1))

# Add "none" to NA boat values
titanic$boat = replace(titanic$boat,which(is.na(titanic$boat)),"None")

# Add binary has_cabin_number column
has_cabin_number = as.integer(replace(titanic$cabin,which(!is.na(titanic$cabin)),1))
has_cabin_number = as.integer(replace(has_cabin_number,which(is.na(has_cabin_number)),0))
titanic = add_column(titanic,has_cabin_number = has_cabin_number)

# Save cleaned data as a csv
write.csv(titanic,"titanic_cleaned.csv")