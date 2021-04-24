library(shiny)
library(ggplot2)

vg <- read.csv("vgsales.csv")
names(vg)[names(vg) == "Rank"] <- "Unique_ID" 

Y <- fluidPage(
  
  titlePanel("Video Games Explorer"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(vg),
                value=min(20, nrow(vg)), step=40, round = 0),
    
    selectInput('x', 'X', names(vg)),
    selectInput('y', 'Y', names(vg), names(vg)[[2]]),
    
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),
    
  ),
  
  mainPanel(
    plotOutput('plot')
  )
)

X <-function(input, output) {
  
  dataset <- reactive({
    vg[sample(nrow(vg), input$sampleSize),]
  })
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point() + 
      theme(axis.text.x = element_text(angle = 60, vjust = 0.5, hjust=0.5))
    
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=1000)
  
}

shinyApp(ui = Y, server = X)
