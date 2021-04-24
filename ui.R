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

