library(shiny)

recSleep <- function(age){
  result <- NA
  if(age >= 65){
    result <- "7-8"
  } else if (age >= 18){
    result <- "7-9"
  } else if (age >= 17){
    result <- "8-10"
  } else if (age >= 6){
    result <- "9-11"
  } else if (age >= 3){
    result <- "10-13"
  } else {
    result <- "14-17"
  }
  paste(result, "is the recommended hours of sleep per night")
}

sleepDebt <- function(age, sleep){
  result <- NA
  if(age >= 18){
    result <- sleep - 8
  } else if (age >= 17){
    result <- sleep - 9
  } else if (age >= 6){
    result <- sleep - 10
  } else if (age >= 3){
    result <- sleep - 12
  } else {
    result <- sleep - 16
  }
  return(result)
}

tips <- function(sleepDebt, checkBoxs){
  sleep <- "Unable to determine your sleep habit"
  if (sleepDebt < 0){
    sleep <- 'You lack sleep. Try to sleep some more, you deserved it.'
  } else if (sleepDebt > 2){
    sleep <- 'You are sleeping a little too much, it might be bad to sleep to much.'
  } else {
    sleep <- 'You are doing great!'
  }
  result <- list(sleepHabit = sleep)
  
  if(length(checkBoxs) != 0){
    temp <- c()
    if ('1' %in% checkBoxs){
      temp <- c(temp, "Things not to do before sleeping: use your gadget at least 1 hour before, drink coffee, tea, or alcohol a few hours before, eat spicy or fatty foods, work out intensely, or turn up the heat")
    } 
    if ('2' %in% checkBoxs){
      temp <- c(temp, "Things to help get out of bed: automate your morning routine, reward yourself (or make getting up worth your while), or get better sleep")
    } 
    if ('3' %in% checkBoxs){
      temp <- c(temp, "Things to help stay awake: take a walk before your shift, nap strategically, try caffeine, or keep moving")
    } 
    if ('4' %in% checkBoxs){
      temp <- c(temp, "Sleeping too much might cause health problems: can raise depression risk, impair the brain, can lead to weight gain, hurt the heart, or lead to an earlier death")
    }
    result$tips <- as.list(temp)
  }
  return(result)
}

mLinks <- function(value){
  if(value){
    return(list(
      "https://goo.gl/h4uth0",
      "http://goo.gl/JUZEAu",
      "http://goo.gl/y54TmT",
      "https://goo.gl/9FBfGE",
      "http://goo.gl/OGTnsM"
    ))
  }
  return("No links were requested.")
}

shinyServer(
  function(input, output){
    output$outAge <- renderPrint({input$age})
    output$outLastNightSleep <- renderPrint({input$sleepLastNight})
    output$outRecSleep <- renderPrint({recSleep(input$age)})
    output$outSleepDebt <- renderPrint({sleepDebt(input$age, input$sleepLastNight)})
    output$outSleepTips <- renderPrint({tips(sleepDebt(input$age, input$sleepLastNight), input$problemCheckBox)})
    output$outLinks <- renderPrint({mLinks(input$moreLinks)})
    
  }
)