best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 

  ## Check that state and outcome are valid
  if (!state %in% data$State) {
    stop("invalid state")
  } 
  
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  } 
  
  ## Return hospital name in that state with lowest 30-day death
  if(outcome == "heart attack") {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)) %>%
      filter(State == state) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) %>%
      arrange(attack, Hospital.Name) %>%
      slice(1) %>%
      select(Hospital.Name)
  } else if(outcome == 'heart') {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)) %>%
      filter(State == state) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) %>%
      arrange(attack, Hospital.Name) %>%
      slice(1) %>%
      select(Hospital.Name)
  } else {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)) %>%
      filter(State == state) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
      arrange(attack, Hospital.Name) %>%
      slice(1) %>%
      select(Hospital.Name)
  }
  
  ## rate
  return(ranking)
}


best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")









rankhospital <- function(state, outcome, num = "best") { 
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 
  
  ## Check that state and outcome are valid
  if (!state %in% data$State) {
    stop("invalid state")
  } 
  
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  } 
  
  ## Return hospital name in that state with lowest 30-day death
  if(outcome == "heart attack") {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)) %>%
      filter(State == state) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) %>%
      filter(!is.na(attack)) %>%
      arrange(attack, Hospital.Name)  %>%
      mutate(rown = row_number())
    
  } else if(outcome == 'heart failure') {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)) %>%
      filter(State == state) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) %>%
      filter(!is.na(attack)) %>%
      arrange(attack, Hospital.Name) %>%
      mutate(rown = row_number())
    
  } else {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)) %>%
      filter(State == state) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
      filter(!is.na(attack)) %>%
      arrange(attack, Hospital.Name) %>%
      mutate(rown = row_number())
  }
  
  if(num == "best") {
    
    ranking <- ranking %>%
      filter(rown == 1) %>%
      select(Hospital.Name)
    return(ranking)
    
  } else if (num == "worst") 
    
    {
    ranking <- ranking %>%
      filter(rown == n()) %>%
      select(Hospital.Name) 
    return(ranking)
    
  } else if(num > length(ranking$rown)) 
    {
    NA
    
  } else {
    
    ranking <- ranking %>%
      filter(rown == num) %>%
      select(Hospital.Name)
    return(ranking)
    
  }
}

rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)






rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 
  
  ## Check that state and outcome are valid
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  } 
  
  ## For each state, find the hospital of the given rank
  if(outcome == "heart attack") {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) %>%
      group_by(State) %>%
      arrange(State, attack, Hospital.Name) %>%
      filter(!is.na(attack)) %>%
      mutate(rown = row_number())
    
  } else if(outcome == 'heart failure') {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) %>%
      group_by(State) %>%
      arrange(State, attack, Hospital.Name) %>%
      filter(!is.na(attack)) %>%
      mutate(rown = row_number())
    
  } else {
    ranking <- data %>%
      select(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, State) %>%
      mutate(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia =
               as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)) %>%
      rename(attack = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>%
      group_by(State) %>%
      arrange(State, attack, Hospital.Name) %>%
      filter(!is.na(attack)) %>%
      mutate(rown = row_number())
  }
  
  
  if(num == "best") {
    ranking <- ranking %>%
      filter(rown == 1) %>%
      select(hospital = Hospital.Name, state = State)
    return(ranking)
    
  } else if (num == "worst") 
  {
    ranking <- ranking %>%
      filter(rown == n()) %>%
      select(hospital = Hospital.Name, state = State)
    return(ranking)
  } else {
    
    ranking <- ranking %>%
      filter(rown == num) %>%
      select(hospital = Hospital.Name, state = State)
    return(ranking)
    
  }
}
  

  
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)

