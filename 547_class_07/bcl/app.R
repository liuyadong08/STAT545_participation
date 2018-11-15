library(shiny)
library(tidyverse)

bcl <- read.csv("/Users/Yadong/Downloads/STAT545/STAT545_participation/547_class_07/bcl/bcl-data.csv", stringsAsFactors = FALSE)
# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      radioButtons("typeInput", "Select the type of liquor.",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE")
    ),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("price_table")
    )
    #"This is some example text,",
    #br(),
    #"next line",
    #p("and more text."),
    #tags$h1("Level 1 header"),
    #h1(em("another level 1 header")),
    #HTML("<h1>Level 1 header, part 3</h1>"),
    #tags$b("to make texts bold"),
    #br(),
    #a(href="https://google.ca", "Link to google")
    
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  observe(print(input$priceInput))
  bcl_filtered <- reactive({
    bcl %>% 
    filter(Price < input$priceInput[2],
             Price > input$priceInput[1],
             Type == input$typeInput)})
  output$price_hist <- renderPlot({
      bcl_filtered() %>% 
      ggplot(aes(Price))+
      geom_histogram()
  })
  #output$price_table <- renderTable(data.frame(name = bcl$Name, price=bcl$Price))
  output$price_table <- renderTable({
    bcl_filtered() 
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

