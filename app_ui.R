# Load libraries so they are available
# library("shiny")
# library("dplyr")
# library("plotly")

source("app_server.R")

# read the dataset
global_emissions <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Define a variable `intro_panel` for your first page. 
intro_panel <- tabPanel(
  "Introduction",
  
  titlePanel("CO2 Emission in the United States"),
  br(),
  strong("We will mostly focus on data about the United States."),
  br(),
  p("According to the information summarized in the server file, we can tell that the average CO2 emission in the United States is ", 
    round(avg_co2_emissions, digits = 2), ". 
    Moreover, the CO2 emissions in the United States have surpassed the average CO2 since 1941. 
    Besides the average CO2 emission in the United States, we find out that the highest CO2 per capita in the United States was ", 
    round(highest_co2_capita, digits = 2), " in 1973, and 1973's CO2 emission is 4785.
    This finding shows us that the CO2 contribution of the average citizen in the U.S. was the highest during that time.
    On the other hand, the lowest CO2 per capita in the U.S. was ", 
    round(lowest_co2_capita, digits = 2), " in 1800. 
    This information makes a significant difference in comparison to the highest CO2 per capita in the U.S., which the increase in CO2 per capita is massive.")
)

# Define a variable `inter_vis` for your first page.
unique(global_emissions$country)

select_x_values <- colnames(global_emissions)[c(-1,-2,-3)]

select_y_values <- colnames(global_emissions)[c(-1,-2,-3)]

x_input <- selectInput(
  "x_var",
  label = "X Variable",
  choices = select_x_values,
  selected = "population"
)


y_input <- selectInput(
  "y_var",
  label = "Y Variable",
  choices = select_y_values,
  selected = "co2_per_capita"
)


color_input <- selectInput(
  "color",
  label = "Color",
  choices = list("Red" = "red", "Blue" = "blue", "Purple" = "purple", "Black" = "black")
)


size_input <- sliderInput(
  "size",
  label = "Size of point", min = 1, max = 10, value = 3
)

inter_vis <- tabPanel(
  "Interactive visualization",
  
  titlePanel("Variables Correlations"),
  h3("Fousing on the data in the United States"),
  p("Use the following to hover over the variables"),
  sidebarLayout(
    sidebarPanel(
      x_input, 
      y_input,
      color_input,
      size_input,
    ),
    mainPanel(
      plotlyOutput("scatter"),
      p("This interactive visualization is a scaatterplot that shows a positive correlation between the population and the CO2 per capita in the United States.
        By selecting the widgets, we are able to compare different correlations in variables provided in the dataset. However, I want to focus on CO2 per capita in this assignment.
        I find an interesting result when looking at the scatterplot, which the correlation between the population and the CO2 per capita is not as strong as I thought.
        There is actually some downward-sloping trend in some parts of the scatterplot, and I did not expect these to happen."),
    ))
)

#Define a ui variable
ui <- navbarPage(
  "A5: CO2 Emission Analysis",
  intro_panel,
  inter_vis
)