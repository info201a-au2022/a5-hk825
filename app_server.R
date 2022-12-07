# Load libraries so they are available
# library("shiny")
# library("stringr")
library("dplyr")
# library("ggplot2")
library("plotly")

#source("app_ui.R")

# read the dataset
global_emissions <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

#three relevant values for intro
avg_co2_emissions <- global_emissions %>%
  filter(country == "United States") %>%
  summarize(co2 = mean(co2))
#View(avg_co2_emissions)

highest_co2_capita <- global_emissions %>%
  filter(country == "United States") %>%
  filter(co2_per_capita == max(co2_per_capita, na.rm = F)) %>% #contribution of the average citizen
  select(co2_per_capita)

lowest_co2_capita <- global_emissions %>%
  filter(country == "United States") %>%
  filter(co2_per_capita == min(co2_per_capita, na.rm = F)) %>% #contribution of the average citizen
  select(co2_per_capita)

#Visualizations

server <- function(input, output) {
  output$scatter <- renderPlotly({
    
    plotData <- global_emissions %>%
      filter(country == "United States")
    
    title <- paste0( input$x_var, " v.s. ", input$y_var)
    
    p <- ggplot(plotData) +
      geom_point(mapping = aes_string(x = input$x_var, y = input$y_var), 
                 size = input$size, 
                 color = input$color) +
      labs(x = input$x_var, y = input$y_var, title = title)
    p
  })
}  
