
--head(data)
--summary(data)
--?read.csv
--?tolower
--?strsplit
--?sapply
--?substr
--?separate
--n_distinct(data$product_category)
--unique(data$product_category)
setwd("C:/Users/Vasu/data")

data <- read.csv("refine.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)


install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(tidyr)
data <- mutate(data, company_lc = tolower(company))


names(data)[names(data) == 'Product.code...number'] <- 'Product'
data <- separate(data, Product, into = c("product_code","product_number"), sep = "-")
data <- mutate(data, product_category = ifelse(product_code == "p", "Smartphone",
       ifelse(product_code == "v", "TV", 
       ifelse(product_code == "x", "laptop", 
       ifelse(product_code == "q", "Tablet", "NA")))))

data <- mutate(data, full_address = paste(address, city, country, sep = ","))

data <- mutate(data, company_philips = ifelse(company_lc == "phillips", 1, 0))
data <- mutate(data, company_akzo = ifelse(company_lc == "akzo", 1, 0))
data <- mutate(data, company_van_houten = ifelse(company_lc == "van houten", 1, 0))
data <- mutate(data, company_unilever = ifelse(company_lc == "unilever", 1, 0))

data <- mutate(data, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
data <- mutate(data, product_laptop = ifelse(product_category == "laptop", 1, 0))
data <- mutate(data, product_tv = ifelse(product_category == "TV", 1, 0))
data <- mutate(data, product_tablet = ifelse(product_category == "Tablet", 1, 0))

write.csv(data, "refine_clean.csv", na="")


