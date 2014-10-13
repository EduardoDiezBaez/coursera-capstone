library(shiny)
library(data.table)

load(file="shiny.Rdata")
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
biWord  <- ""
triWord <- ""

shinyServer(function(input, output){
            suggestion  <- reactive({
                inputStr        <- trim(tolower(input$text1))
                strLen          <- nchar(inputStr)
                strIndex        <- unlist(gregexpr(' ', inputStr))
                biWord  <- ifelse(length(strIndex)>0, substr(inputStr, strIndex[length(strIndex)]+1, strLen))
                if(length(strIndex)>1){triWord  <- substr(inputStr, strIndex[length(strIndex)-1]+1, strLen)}
                if(length(strIndex) == 1){triWord   <- inputStr}
                test1   <- subset(biResult, bigramKey==biWord, select=bigramValue)
                test2   <- subset(triResult, trigramKey==triWord, select=trigramValue)
                paste(paste(unlist(test1), collapse="<br/>"), paste(unlist(test2),collapse="<br/>"), sep="<br/>")
            })

            output$text1    <- renderUI({
            outputData  <- suggestion()
            HTML(outputData)
            })
            #output$text1 <- renderText({
            #    suggestion()
            #})
})

