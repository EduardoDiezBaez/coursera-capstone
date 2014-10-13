library(shiny)
shinyUI(
        pageWithSidebar
        (
         # Application title
         headerPanel("typing suggestion"),
         sidebarPanel(
                      textInput(inputId="text1", label = "Input Text1")
                      ),
         mainPanel
        (
         h3('word suggestion'), 
         htmlOutput('text1', inline=TRUE)
        )
        )
)
