library(shiny)
source("Data_Prep.R")


StateRes<-function(selc1, selc2, selc3, selc4){
  if (selc1 != "" & selc4 != "") { 
    temp<-subset(sData,(sData$State==selc1 & sData$County==selc4 & sData$Meanincome >= selc2 & sData$Meanincome <= selc3))
  }
  else if (selc1 != "") {
    temp<-subset(sData,(sData$State==selc1 & sData$Meanincome >= selc2 & sData$Meanincome <= selc3))
  }
  else  {
    temp<-subset(sData,(sData$County==selc4 & sData$Meanincome >= selc2 & sData$Meanincome <= selc3))
  }
  names(temp) <- c('Year', 'Rank', 'County', 'State', 'Mean Household Income ($)')
  return(temp)
}
 
shinyServer(
  function(input,output) { 
    output$oCounty <- renderPrint({input$county1})
    output$oState <- renderPrint({input$state1})
    output$oIncome <- renderPrint({input$income1})
    
      output$oResult = renderDataTable({
      input$goButton
      isolate(StateRes(input$state1, input$income1[1], input$income1[2], input$county1))
      #  StateRes(input$state1)
    })

    
    # Render sample data set
    output$oTable <- renderDataTable({
      sData
    } #, options = list(bFilter = FALSE, iDisplayLength = 50)
    )
  }
)