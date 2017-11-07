complete <- function(directory, id = 1:332) {
  
  stats <- data.frame()
  
  for (file in list.files()[id]) {
    data <- read.csv(file)
    
    name <- file
    nobs <- sum(complete.cases(data))
  
  stats <- rbind(stats, data.frame(name, nobs))
    
  }
  
  stats
  
}


cc <- complete("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
            Repositories/Coursera-Data-Science/R Programming/specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

cc <- complete("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
            Repositories/Coursera-Data-Science/R Programming/specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
            Repositories/Coursera-Data-Science/R Programming/specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

