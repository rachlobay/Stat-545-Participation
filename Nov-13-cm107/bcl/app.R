#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

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
    sidebarPanel("This text is in the sidebar."),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("bcl_data")
    )
  )
)
  



# Server function is a function of input and output
# Define server logic required to draw a histogram
server <- function(input, output) {
   output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
   output$bcl_data <- renderTable(bcl)

}

# Run the application 
shinyApp(ui = ui, server = server)

