library(shiny)

shinyServer(
    function(input, output, session) {
       
        set.seed(42)
        library(caret)
        library(e1071)
        library(caretEnsemble)
        library(gbm)
 
        model_list <- reactive({
            
            withProgress({
                
                myFolds <- createFolds(iris$Species, 
                                       k = input$num_folds, 
                                       list = T, 
                                       returnTrain = T) 
                trControl <- trainControl(method = "repeatedcv", 
                                          classProbs = T, 
                                          repeats = input$num_reps, 
                                          index = myFolds, 
                                          verboseIter = F, 
                                          savePredictions = T)
                
                library(caretEnsemble)
                library(ranger) # alternative to base rf model
                model_list <- caretList(Species ~ .,
                                        data = iris,
                                        methodList = c(lda = "lda", 
                                                       gbm = "gbm", 
                                                       rf = "ranger"),
                                        trControl = trControl,
                                        tuneLength = 3)
                
            }, 
            message = 'Running model...', 
            value = 0.5)
            })
       
        output$plot1 <- renderPlot({
        resamps <- resamples(model_list())
         dotplot(resamps)
        })
    }
    )