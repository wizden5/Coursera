pollutantmean <- function(directory, pollutant, id = 1:332) {

  
  data <- data.frame()
  
  for (file in list.files()[id]) {
    data <- rbind(data, read.csv(file))
  }

  vec <- unlist(data[, pollutant])
  return(mean(vec, na.rm = TRUE))
}

pollutantmean("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
              Repositories/Coursera-Data-Science/R Programming/specdata", "sulfate", 1:10)

pollutantmean("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
              Repositories/Coursera-Data-Science/R Programming/specdata", "nitrate", 70:72)

pollutantmean("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
              Repositories/Coursera-Data-Science/R Programming/specdata", "sulfate", 34)

pollutantmean("C:/Users/wiktor.zdzienicki/OneDrive - ITMAGINATION Sp. z o.o/Moje/
              Repositories/Coursera-Data-Science/R Programming/specdata", "nitrate")
