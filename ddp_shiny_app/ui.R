library(shiny)
shinyUI(fluidPage(
    headerPanel("Modeling Flowers"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(
                'num_folds',
                'Number of cross validation folds',
                min = 2,
                max = 10,
                value = 5,
                step = 1,
                dragRange = F
            ),
            sliderInput(
                'num_reps',
                'Number of cross validation repeats',
                min = 1,
                max = 10,
                value = 3,
                step = 1,
                dragRange = F
            )
        ),
        mainPanel(# h3("Confusion matrix for your model"),
            h3("Relative accuracy of trained models"),
            plotOutput('plot1'))
    ),
    wellPanel(
        h2("Documentation"),
        tags$body(
            "Using the 'iris' data set, this web app allows you to explore the effect of varying folds and repeats when perfoming cross validation during model training. Three common predictive models are considered (see plot):"
        ),
        tags$li("linear discriminant analysis (lda)"),
        tags$li("random forests (rf)"),
        tags$li("gradient boosting machine (gbm)"),
        tags$body(
            "Simply adjust the sliders for the number of folds and repeats left to right and you can observe the impacts on the accuracy of the resulting models."
        )
    )
))
