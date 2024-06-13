# Mathematical calculations

#Division
25/9

# Addition
25+9

# subtraction
25-9


# create objects
obj1 <- 24

obj2 <- 9 

# redo calculations
obj1 / obj2 
obj1 + obj2
obj1 * obj2

# Install packages
install.packages("tidyverse")
require(tidyverse) 

# set working directory
setwd("C:/Users/ADMIN/Desktop/Intro to R")


# import data
ideal1 <- read_csv("ideal1.csv")
ideal2 <- read_csv("ideal2.csv")

# Display the first 6 data
head(ideal1)
tail(ideal2)

# data wrangling(lubridate <- package containing recode)
# $ to show the different columns in the data set
# recode to change datatypes : Tell it the column you are changing and to what value

ideal1$CalfSex <- recode(ideal1$CalfSex, "1"="Male" , "2"="Female")
ideal1$ReasonsLoss <- recode(ideal1$ReasonsLoss, "6"="Sold" , "7"="Death", "12"="Relocation", "18"="Refusal")
head(ideal1)

# convert the date to the ideal date type in R dmy
ideal1$CADOB <- dmy(ideal1$CADOB)


# Visualize data (ggPlot2)
ggplot(ideal1, aes(x = CalfSex)) + geom_bar(fill = "Brown") +theme_bw() + 
  labs(x = "Calf Sex", y = " Fequency", title = "Calves Study", caption = "A histogram showing the frequency of calves")


# Re- import the data 
# import data
ideal1 <- read_csv("ideal1.csv")
ideal2 <- read_csv("ideal2.csv")

# Use piping to run the recode functions
#Create a new object called ideal1 a
ideal1a <- ideal1 |> 
  mutate(CalfSex = recode(CalfSex, "1"="Male" , "2"="Female")) |> 
  mutate(ReasonsLoss = recode (ReasonsLoss, "6"="Sold" , "7"="Death", "12"="Relocation", "18"="Refusal")) |>
  mutate(CADOB = dmy(CADOB))

# Stacking
ggplot(ideal1a, aes(x = ReasonsLoss, fill = CalfSex)) + geom_bar()

# Specify the position other than stacking
ggplot(ideal1a, aes(x = ReasonsLoss, fill = CalfSex)) + geom_bar(position = "dodge")

# Merge Data
ideal3 <- full_join(ideal1, ideal2, by = "CalfID") |>
  mutate(CalfSex = recode(CalfSex, "1"="Male" , "2"="Female")) |> 
  mutate(ReasonsLoss = recode (ReasonsLoss, "6"="Sold" , "7"="Death", "12"="Relocation", "18"="Refusal")) |>
  mutate(CADOB = dmy(CADOB)) |>
  mutate(VisitDate = dmy(VisitDate)) |>
  
  # Create a new column called visitNo, the divides the VisitID to extract the unique character to give the visit time which is the 4th index
  mutate(visitNo = str_sub (VisitID, 4, 5))|>
  
  # group the data by calfID
  group_by(CalfID) |>
  
  # Create a new column to display the max and min weights of the calf
  mutate(max_weight = max(Weight, na.rm = TRUE)) |># Maximum Weight
  mutate(min_weight = min(Weight, na.rm = TRUE)) |># Minimum Weight
  
  # Good practice
  ungroup() |>
  
  # Grouping the test using if else
  mutate(ManualPCV = ifelse(ManualPCV < 30, "Negative", "Positive")) |>
  mutate(Theileria.spp.= ifelse(Theileria.spp. == 1, "Positive", "Negative")) |>
  mutate(ELISA_mutans = ifelse(ELISA_mutans == 1, "Positive", "Negative")) |>
  mutate(ELISA_parva = ifelse(ELISA_parva == 1, "Positive", "Negative")) |>
 #mutate_all(vars(Theileria.spp., ELISA_mutans,ELISA_parva), funs(ifelse(.==1,"Positive, "Negative")))|>
  mutate(Q.Strongyle.eggs = ifelse(Q.Strongyle.eggs < 700, "Negative", "Positive"))

  # create a new object with 2 rows and remove the duplicates leaving only 30 calf IDs
  max_weight <- ideal3 |>
    select(CalfID, max_weight) |>
    distinct()
  
ggplot(max_weight, aes(x = max_weight)) + geom_histogram()


# Transpose data : to long column
calf_tests <- ideal3 |>
  select(CalfID, ManualPCV, Theileria.spp., ELISA_mutans, ELISA_parva, Q.Strongyle.eggs) |>
  pivot_longer(c( ManualPCV, Theileria.spp., ELISA_mutans, ELISA_parva, Q.Strongyle.eggs),names_to = "Tests", values_to = "Results") |>
  group_by(Tests, Results)|>
  summarise(count = n()) |>
  na.omit()|>
  ungroup()|>
  
  # find the percentages of the counts with reference to the total number of +ves and  -ves
  group_by(Tests)|>
  
  #create a new column called total to get the sum of the counts
  mutate(Total = sum(count))|>
  ungroup() |>
  
  # we divide the count and total. To find the percentage and put it in a new column called Proportion
  #Add round to the nearest whole number
  mutate(Proportion = round(count / Total * 100))
  
  #Plot the frequency graph

  ggplot(calf_tests, aes(x = Tests, y=count, fill = Results)) + geom_col()
  
  #Plot the propotion graph
  
  ggplot(calf_tests, aes(x = Proportion, y=Tests, fill = Results)) + geom_col()

  
  
  
  
  
  
  # TASK 1
  install.packages("AMR")
  library("AMR")
  
  #Import data
  data("WHONET") 
  
  #Create a new object and filter(country == "The Netherlands")
  amr_data <- WHONET |>
    filter(Country == "The Netherlands") |>
    select(`Specimen type`, AMP_ND10, AMC_ED20,TZP_ED30, PEN_ND1, CIP_ED5)|>
    rename("ampicillin" = "AMP_ND10", "amoxicillin" = "AMC_ED20","piperacillin" = "TZP_ED30", "benzylpenicillin" = "PEN_ND1", "ciprofloxacin vi" = "CIP_ED5")
 
  #create an object called spec_tests and do a long format on it
  spec_tests <- amr_data |>
    select(`Specimen type`,ampicillin, amoxicillin,piperacillin, benzylpenicillin, `ciprofloxacin vi`)|>
    pivot_longer(c(ampicillin, amoxicillin,piperacillin, benzylpenicillin, `ciprofloxacin vi`), names_to = "biotics", values_to = "sensitivity")|>
    na.omit()|>
    group_by(biotics, sensitivity)|>
    summarise(count = n()) |>
    ungroup()|>
    
    
    
    # find the percentages of the counts with reference to the total number of +ves and  -ves
    group_by(biotics)|>
    
    #create a new column called total to get the sum of the counts
    mutate(Total = sum(count))|>
    ungroup() |>
    
    # we divide the count and total. To find the percentage and put it in a new column called Proportion
    #Add round to the nearest whole number
    mutate(Proportion = round(count / Total * 100)) 
  
  #Plot the proportion graph
  
  ggplot(spec_tests, aes(x = biotics, y=Proportion, fill = sensitivity)) + geom_col()
  # ggsave("name of the map")  
  
  
  
    
  
  
  
  






