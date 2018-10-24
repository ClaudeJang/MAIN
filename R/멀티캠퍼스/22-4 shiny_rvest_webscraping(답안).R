library(shiny)
library(tidyverse)
library(shinydashboard)
library(rvest)


get.data <- function(x){
  myurl <- read_html("https://coinmarketcap.com/gainers-losers/")
  myurl <- html_table(myurl)

  to.parse <- myurl[[1]]
  to.parse$`% 1h` <- gsub("%","",to.parse$`% 1h`)
  to.parse$`% 1h`<- as.numeric(to.parse$`% 1h`)
  to.parse$Symbol <- as.factor(to.parse$Symbol)
  to.parse$Symbol <- factor(to.parse$Symbol, levels = to.parse$Symbol[order(to.parse$'% 1h')])
  to.parse
}

get.infobox.val <- function(x){
  df1 <- get.data()
  df1 <- df1$`% 1h`[1]
  df1
}

get.infobox.coin <- function(x){
  df <- get.data()
  df <- df$Name[1]
  df
}

ui <- dashboardPage(
  # H E A D E R
  dashboardHeader(title = "Alt Coin Gainers"),
  # # S I D E B A R
 dashboardSidebar(
   collapsed = T
  ),
  # B O D Y
  dashboardBody(
    fluidRow(
      # InfoBox
      infoBoxOutput("top.coin", width = 3),
      # InfoBox
      infoBoxOutput("top.name", width = 3)
    ),

    fluidRow(
      column(
        # Datatable
        box(
          status = "primary",
          headerPanel("Data Table"),
          solidHeader = T,
          br(),
          DT::dataTableOutput("table", height = "350px"),
          width = 6,
          height = "560px"
        ),

        # Chart
        box(
          status = "primary",
          headerPanel("Chart"),
          solidHeader = T,
          br(),
          plotOutput("plot", height = "400px"),
          width = 6,
          height = "500px"
        ),
        width = 12
      )
    )
  )
)

server <- function(input, output) {

  # R E A C T I V E
  liveish_data <- reactive({
    invalidateLater(60000)    # refresh 60 seconds
    get.data()
  })


  live.infobox.val <- reactive({
    invalidateLater(60000)    # refresh 60 seconds
    get.infobox.val()
  })


  live.infobox.coin <- reactive({
    invalidateLater(60000)    # refresh 60 seconds
    get.infobox.coin()
  })

  output$table <- DT::renderDataTable(DT::datatable({
    data <- liveish_data()}))

  output$plot <- renderPlot({ (ggplot(data=liveish_data(), aes(x=Symbol, y=`% 1h`)) +
                                 geom_bar(stat="identity", fill = "springgreen3") +
                                 theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                                 ggtitle("Gainers from the Last Hour"))
  })


  output$top.coin <- renderInfoBox({
    infoBox(
      "Gain in Last Hour",
      paste0(live.infobox.val(), "%"),
      icon = icon("signal"),
      color = "purple",
      fill = TRUE)
  })

  output$top.name <- renderInfoBox({
    infoBox(
      "Coin Name",
      live.infobox.coin(),
      icon = icon("bitcoin"),
      color = "purple",
      fill = TRUE)
  })

}

shinyApp(ui = ui, server = server)

