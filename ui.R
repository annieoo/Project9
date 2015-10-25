library(shiny)
library(datasets)

shinyUI(pageWithSidebar(
  headerPanel("U.S. 2014 State/County Ranked by Median Household Income"),
  sidebarPanel(
    h4('Enter County, State, and Income Range.'),
    p('Press Go! button to see the results.'),
    selectInput(inputId="county1",label="Choose County:", choices=c("",sort(as.character(unique(sData$County)))), multiple = FALSE, selected = NULL),
  
    p('or'),
    selectInput(inputId="state1",label="Choose State:", choices=c("",state.name), multiple = FALSE, selected = NULL),
    
    sliderInput("income1", "Income Range: ", min=25000, max=150000, value=c(50000,100000)),
    actionButton('goButton', 'Go!'),
    
    h5("'No data available in table' is displayed on Result panel when:  "),
    p("- no values for both County and State, i.e. when first display the page"),
    p("- entered values for both County and State; please enter value only for County OR State"),
    p("- entered out of range for Income group; readjust the income range and press Go! to see the result")
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel('Results',
               h4('You have Entered: '),
               verbatimTextOutput('oCounty'),
               verbatimTextOutput('oState'),
               verbatimTextOutput('oIncome'),
               
               h4("Selection Result"),
               dataTableOutput(outputId='oResult')
        ),
      tabPanel(p(icon('table'), 'Sample Data Set'),
               p('data source: ', a("U.S.Census Bureau", href="https://www.census.gov/acs/www/data/data-tables-and-tools/ranking-tables")),
               dataTableOutput(outputId='oTable')
        )
      )

  )
))