# call library tidyverse

library(tidyverse)

#import the diabetes data and store it in an object called danalysis
danalysis <- read_csv("diabetes.csv") |>
  mutate(Outcome = recode(Outcome, "1" = "Diabetic", "0" = "Not_Diabetic"))
  

# the rest
view(danalysis)
head(danalysis)
dim(danalysis)  #This gives the dimensions of the table
str(danalysis) #gives the internal structure of the object



 
  

  
  



  



  

ggplot(dpresc, aes(x = Features, y = Outcome)) +geom_col()


  
  
