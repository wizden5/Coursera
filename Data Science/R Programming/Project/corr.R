corr <- function(directory, threshold = 0) {
  
  stats <- data.frame()
  
  for (file in list.files()) {
    data <- read.csv(file)
    
    name <- file
    nobs <- sum(complete.cases(data))
    
    if(nobs > 0) {
      kor <- cor(data$sulfate, data$nitrate, use = "complete.obs")
    } else {
      kor <- 0
    }
    
    stats <- rbind(stats, data.frame(name, nobs, kor))
  }
  stats <- filter(stats, nobs > threshold)
  stats <- unlist(select(stats, kor))
  stats 
}



cr <- corr("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
            Repositories/Coursera-Data-Science/R Programming/specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)


cr <- corr("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
            Repositories/Coursera-Data-Science/R Programming/specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
            Repositories/Coursera-Data-Science/R Programming/specdata", 2000)                
n <- length(cr)                
cr <- corr("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
            Repositories/Coursera-Data-Science/R Programming/specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))