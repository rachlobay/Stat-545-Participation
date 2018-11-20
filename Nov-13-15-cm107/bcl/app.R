#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(colourpicker)
library(tidyverse)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

# Anything before UI will be run too!
#a <- 5
# print(a^2)


# UI (User Interface) output of fluid page function 
# Define UI for application that draws a histogram
ui <- fluidPage(
  # "This is some text",
  # p("This is more text."),
  # h1 is level 1 header
  # tags$h1("Level 1 header"),
  # h1(em("Level 1 header")),
  # HTML("<h1>Level 1 header, part 3 </h1>"),
  # "Some text following a break",
  # code("This text will be displayed as computer code."),
  # br(),
  # a(href="www.rstudio.com", "Click here!"),
  # br(),
  # print(a)
  
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(sliderInput(
      "priceInput", "Select your desired price range.",
      min = 0, max = 100, value = c(15, 30), pre="$"),
      radioButtons("typeInput", "Select your alcoholic beverage type.",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE")
    ),
    mainPanel(
      colourInput("colourBar", "Select colour", "blue"),
      plotOutput("price_hist"),
      downloadButton('downloadBut',"Download the bcl data"),
      fluidRow(column(7,dataTableOutput('dto'))),
      DT::dataTableOutput("bcl_data")
    )
  )
)




# Server function is a function of input and output
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  bcl_filtered <- reactive(bcl %>% 
    filter(Price < input$priceInput[2],
           Price > input$priceInput[1],
           Type == input$typeInput))
  output$price_hist <- renderPlot({
      bcl_filtered() %>% 
      ggplot(aes(Price)) + geom_histogram(fill = input$colourBar) 
  })
  
  output$bcl_data <- DT::renderDataTable({bcl_filtered()})
  output$downloadBut <- downloadHandler(
    filename = function(){"bclData.csv"},
    content = function(filename){
      write.csv(bcl_filtered(), filename)
    }
  )

}
  

# Run the application 
shinyApp(ui = ui, server = server)

