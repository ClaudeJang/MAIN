rm(list=ls())

dt <- fread("example_bank_data.csv")
#dt1 <- read.csv("example_bank_data.csv", header =T, na.strings = "NA",
               #stringsAsFactors = T)
colnames(dt)
str(dt1)
str(dt)
library(stringr)
library(data.table)
library(plyr)
#str_replace(dt$job,"admin.","Employed")
#str_replace(dt$job,"housemaid","Employed")
# 팩터 레벨이 너무 많아 종류를 줄이기 위해 군집
dt$job<-gsub("admin.","Employed",dt$job)
dt$job<-gsub("entrepreneur","Employed",dt$job)
dt$job<-gsub("management","Employed",dt$job)
dt$job<-gsub("blue-collar","Employed",dt$job)
dt$job<-gsub("technician","Employed",dt$job)
dt$job<-gsub("services","Employed",dt$job)
dt$job<-gsub("housemaid","Unemployed",dt$job)
dt$job<-gsub("retired","Unemployed",dt$job)
dt$job<-gsub("self-employed","Unemployed",dt$job)
dt$job<-gsub("student","Unemployed",dt$job)
dt$job<-gsub("unemployed","Unemployed",dt$job)
dt$job<-gsub("unknown","Unemployed",dt$job)
table(dt$job)  
dt$education
dt$education <- gsub("illiterate", "elementry", dt$education)
dt$education <- gsub("basic.4y", "elementry", dt$education)
dt$education <- gsub("basic.6y", "elementry", dt$education)
dt$education <- gsub("basic.9y", "middle", dt$education)
dt$education <- gsub("high.school", "middle", dt$education)
dt$education <- gsub("professional.course", "highly", dt$education)
dt$education <- gsub("university.degree", "highly", dt$education)
table(dt$education)
dt$month <- gsub("mar", "FirstHalf", dt$month)
dt$month <- gsub("apr", "FirstHalf", dt$month)
dt$month <- gsub("may", "FirstHalf", dt$month)
dt$month <- gsub("jun", "FirstHalf", dt$month)
dt$month <- gsub("aug", "SecondHalf", dt$month)
dt$month <- gsub("dec", "SecondHalf", dt$month)
dt$month <- gsub("jul", "SecondHalf", dt$month)
dt$month <- gsub("nov", "SecondHalf", dt$month)
dt$month <- gsub("oct", "SecondHalf", dt$month)
dt$month <- gsub("sep", "SecondHalf", dt$month)
table(dt$month)
str(dt)
dt[,marital := as.factor(marital)]
dt[,job := as.factor(job)]
dt[,education := as.factor(education)]
dt[,default := as.factor(default)]
dt[,housing := as.factor(housing)]
dt[,loan := as.factor(loan)]
dt[,contact := as.factor(contact)]
dt[,day_of_week := as.factor(day_of_week)]
dt[,poutcome := as.factor(poutcome)]
dt[,y := as.factor(y)]
dt[,month := as.factor(month)]

glm_data <- glm(y ~., data=dt, family="binomial")
glm_data
glm_data2 <- glm(y ~ age + job + education + default + contact + month + duration +
                   campaign + pdays + poutcome + emp.var.rate + cons.price.idx + cons.conf.idx + euribor3m,
                 data = dt, family = "binomial")
summary(glm_data2)
summary(glm_data)
glm_data3 <- glm(y ~ job + education + default + contact + month + duration +
                   campaign + pdays + poutcome + emp.var.rate + cons.price.idx + cons.conf.idx,
                 data = dt, family = "binomial")
summary(glm_data3)

step(glm_data3) 
stepAIC(glm_data3) 
result <- predict(glm_data3, type="response",
                  dt) # 0~ 1사이 값, 이걸로 판단.y의 예상값.
df2 <- data.frame(result)
class(df2)
df3 <- cbind(dt, df2) # 데이터를 나눠서 할 때 7:3 
View(df3)
result2 <- table(df2 > 0.5, dt$y)
result2

#1. bank_data.csv 
#y <- 고객 정기 예금 가입 유무
#myModel <- glm(y ~ age + job + m....) 
#y = ,,,,,,,,,,,,,,,,,,
#stepAIC(myModel)

##################################################
# 예제 정답
library(data.table)
library(dplyr)
df <- read.csv("example_bank_data.csv", 
               stringsAsFactors = T, 
               na.strings = "NA")
library(MASS) # stepAIC를 위한 라이브러리 설치 
step
#stepAIC()
str(df)
df$y <- ifelse(df$y == "yes", 1, 0)
myModel <- glm(y ~ age + job + marital + education,
               data= df)

summary(myModel)
step(myModel)
stepAIC(myModel)
result <- predict(myModel, type="response",
                  df)
df2 <- data.frame(result)
class(df2)
df3 <- cbind(df, df2)
View(df3)
result2 <- table(df2 > 0.5, df$y)
result2


