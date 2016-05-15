library(shiny)
library(RCurl)

dataUrl <- getURL('https://collegescorecard.ed.gov/downloads/Most-Recent-Cohorts-Scorecard-Elements.csv',
                  ssl.verifyhost=FALSE, ssl.verifypeer=FALSE);
mydat <- read.csv(textConnection(dataUrl))

mysubdat <- mydat[,c("STABBR","INSTNM","CITY","INSTURL")]
names(mysubdat)[2] <- "Name of the Institution"
names(mysubdat)[3] <- "City"
names(mysubdat)[4] <- "Institution URL"

shinyServer(
  function(input, output) {
        observeEvent(input$search, {
          output$mytable = renderDataTable({
            mysubdat[mysubdat$STABBR==input$state,2:4]
          }, options = list(orderClasses = TRUE))
        })
        
        observeEvent(input$cost, {
          mystdat <- mydat[mydat$STABBR==input$state,]
          x <- as.vector(mystdat$NPT4_PUB)
          x <- x[!is.na(x)]
          x <- as.numeric(x)
          output$coa <- renderPlot(
            hist(x, breaks=10, col="blue", xlab="Average Cost of Attendence", 
                 main=paste("Cost of Attendence Histogram - ",input$state))
          )
        })
 })
