library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Did you get enough sleep?"),
  sidebarPanel(
    numericInput('age', 'Your Age (Round Up)', 21, min = 1, max = 100, step = 1),
    numericInput('sleepLastNight', 'Amount of Sleep from Last Night', 8, min = 0, max = 24, step = 1),
    checkboxGroupInput('problemCheckBox', 'Do you have these common problems?',
                       c("Falling asleep?" = "1",
                         "Getting out of bed?" = "2",
                         "Staying awake?" = "3",
                         "Sleeping too much?" = "4")),
    checkboxInput('moreLinks', 'Do you want extra information?', value = FALSE)
  ),
  mainPanel(
    h2('Recommendation based on your input'),
    h3('Your Age is:'),
    verbatimTextOutput("outAge"),
    h3('Amount of sleep last night is'),
    verbatimTextOutput("outLastNightSleep"),
    h3('Recommended Amount of sleep'),
    verbatimTextOutput("outRecSleep"),
    h3('You sleep debt is:'),
    verbatimTextOutput('outSleepDebt'),
    h3("Recommendation based on your sleeping inputs"),
    verbatimTextOutput('outSleepTips'),
    h3("Useful website:"),
    verbatimTextOutput('outLinks')
  )
))