library(shiny)

bcl <- read.csv("/Users/Yadong/Downloads/STAT545/STAT545_participation/547_class_07/bcl/bcl-data.csv", stringsAsFactors = FALSE)
# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel("This text is in the sidebar."),
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
   output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
   output$price_table <- renderTable(data.frame(name = bcl$Name, price=bcl$Price))

}

# Run the application 
shinyApp(ui = ui, server = server)

