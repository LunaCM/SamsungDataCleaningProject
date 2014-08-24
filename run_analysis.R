run_analysis <- function() {
   library(stringr)
   # merge X_test and X_train with labels
   t1 <- read.table("UCI HAR Dataset/features.txt")
   temp2 <- read.table("UCI HAR Dataset/train/X_train.txt")
   temp3 <- read.table("UCI HAR Dataset/test/X_test.txt")
   y1 <- read.table("UCI HAR Dataset/train/y_train.txt") # need to add these activity labels
   y2 <- read.table("UCI HAR Dataset/test/y_test.txt") # need to add these activity labels
   
   subject1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
   subject2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
   
   t2 <- cbind(temp2, y1, subject1)
   t3 <- cbind(temp3, y2, subject2)
   
   c1 <- rbind(t2, t3)                                 #merge the data
   colnames(c1) <- t1[,2]                              #add labels
   names(c1)[562] <- "ActivityNumber"
   names(c1)[563] <- "Subject"
   
   write.csv(c1, file="UCI HAR Dataset/merged.csv")    #save to new file
   
   #extract mean and std dev info
   thenames<-names(c1)
   tfmean <- str_detect(thenames,ignore.case("mean"))
   tfstd <- str_detect(thenames,ignore.case("std"))
   totaltf <- (tfmean | tfstd)   
   totaltf[562] = TRUE
   totaltf[563] = TRUE
   c2 <- c1[totaltf]    #the mean and stdev data with activity number and subject
      
   c3 <- aggregate(c2, by = list(c2[,87], c2[,88]), FUN = "mean")
   
   for (i in 1:180){
      if (c3[i,89] == 1) {
         c3[i,91] = "Walking"
      }
      if (c3[i,89] == 2) {
         c3[i,91] = "WalkingUpstairs"
      }
      if (c3[i,89] == 3) {
         c3[i,91] = "WalkingDownstairs"
      }
      if (c3[i,89] == 4) {
         c3[i,91] = "Sitting"
      }
      if (c3[i,89] == 5) {
         c3[i,91] = "Standing"
      }
      if (c3[i,89] == 6) {
         c3[i,91] = "Laying"
      }
   }
   names(c3)[91] <- "ActivityLabel" 
   
   tempnames <- names(c3)
   tempnames <- gsub("[^a-zA-Z0-9]","",tempnames)  #stripping odd characters out of the names
   names(c3) <-tempnames
   write.table(c3, file="UCI HAR Dataset/final.txt", row.name=FALSE)
}  