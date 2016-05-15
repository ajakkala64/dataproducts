library(shiny)
# --------------------------------------
library(shiny)

shinyUI(fluidPage(
  headerPanel("College Scorecard"),
  sidebarLayout(
    sidebarPanel(
      selectInput("state", "Select a State", 
          choices = c('AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE','FL','FM','GA',
                  'GU','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MH',
                  'MI','MN','MO','MP','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
                  'OH','OK','OR','PA','PR','PW','RI','SC','SD','TN','TX','UT','VA','VI',
                  'VT','WA','WI','WV','WY')),
      actionButton("search", "Update List"),
      actionButton("cost", "Update Cost")
    ),
    mainPanel(
      tabsetPanel(id="tabs",
        tabPanel('Colleges',value="college",
          dataTableOutput('mytable')
        ),
        tabPanel('Cost of Attendence', value="costofattend",
                 plotOutput('coa') )
      )
    )
  ),
  title = "College Board"
))
#--------------------------------------------