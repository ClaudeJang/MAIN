library(shiny)
library(shinydashboard)
library(rvest)
library(tidyverse)

url <- read_html("https://coinmarketcap.com/gainers-losers/")
myurl <- html_table(url)

myurl[[1]]
# %를 제거하고, numeric으로 바꾸기. (convert to numeric)
# Symbol <- factor

data <- myurl[[1]]
data$`% 1h` <-gsub("%", "", data$`% 1h`)
data$`% 1h` <- as.numeric(data$`% 1h`)
data$Symbol <- as.factor(data$`% 1h`)
str(data)
View(data)

# shiny mode로 띄우기 

ui <- dashboardPage(
  # header
  dashboardHeader(title = "코인정보"),
  dashboardSidebar(
    h5("방가워요."),
    br()
    
  )
  
) 