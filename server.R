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
