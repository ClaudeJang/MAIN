rm(list = ls())
library(data.table)
library(plyr)
library(stringr)
train.data2 <- fread("train.csv", na.strings = c("", " ", "NA"))
head(train.data2,1)
test.data2 <- fread("test.csv", na.strings = c("", " ", "NA"))

names(train.data2)
# survived : 0(No), 1(Yes)
# Pclass : 1,2,3 
# SibSp : 형제/배우자 같이 탑승 
# Parch : 부모/자녀수 
class(train.data2)
str(train.data2)
colSums(is.na(train.data2)) # 열 별로 결측값이 얼마나 존재하는지 체크. 
colSums(is.na(test.data2))
summary(train.data2$Age)
summary(test.data2$Age)
summary(train.data2)
#train.data2[is.na(train.data2$Age), "Age"] <- 0 # NA값을 0으로 치환. 
#train.data2$Age
#test.data2[is.na(test.data2$Age), "Age"] <- median(test.data2$Age) # NA값을 0으로 치
#test.data2$Age -> 결측값 0으로 두지 말고 중앙값으로 채우기. 


dim(train.data2)
dim(test.data2)
all.data2 <- rbind(train.data2, test.data2, fill=T)
View(all.data2)
# Age : median

for (i in "Age"){
  set(all.data2, i =
        which(is.na(all.data2[[i]])),j
      = i, value = median(all.data2$Age, na.rm=T))
}
# Fare : median 
for (i in "Fare"){
  set(all.data2, i =
        which(is.na(all.data2[[i]])),j
      = i, value = median(all.data2$Age, na.rm=T))
} 
all.data2
all.data2$Pclass
all.data2 <- all.data2[!is.na(Embarked)]
dim(all.data2)
all.data2 <- all.data2[is.na(Cabin),
                       Cabin := "Miss"]  # Cabin의 NA항목에 Miss를 입력  

all.data2$Fare <- log(all.data2$Fare + 1) 
# log값으로 적용해서 값을 떨어뜨린다. 그 후에 다시 원복시켜주면 된다.(값이 크기 때문.)
# View(all.data2$Fare) 
View(all.data2$Parch) # 이상값 확인 
View(all.data2$Fare)
all.data2[Parch  == 9L, Parch:=0] # 이상값을 0으로 바꿈. 
colnames(all.data2) 


train.data3 <- all.data2[!is.na(Survived)] # Survived 항목에 NA없는 것만 확인. 
train.data3[,Survived := as.factor(Survived)] # survived 항목 1,0 을 팩터화 
class(train.data3)
test.data3 <- all.data2[is.na(Survived)]
test.data3[,Survived := NULL] # train,test 데이터를 각 분리 후 테스트 
myModel2 <-
  glm(Survived ~., family =  "binomial", data = train.data3[,-c("PassengerId",
                                                                "Name",
                                                                "Ticket")])
temp <- summary(myModel2)
temp$coefficients 
# 와일드카드가 있는 부분이 매우 중요하므로, 그 외의 것들은 지우고 다시 분석할 수도 있음.
options(scipen=999)

myModel3 <-
  glm(Survived ~ Pclass + Sex + Age + SibSp, family =  "binomial", data = train.data3[,-c("PassengerId",
                                                                "Name",
                                                                "Ticket")])
temp1 <- summary(myModel3)
temp1$coefficients
anova(myModel2,myModel3, test = "Chisq")
# p-value : 0.1323 

library(caret)
split <-createDataPartition(
  y=train.data3$Survived, p=0.6, list=F
) 

split
train.new <- train.data3[split]
test.new <- train.data3[-split]

myModel4 <-
  glm(Survived ~ Pclass + Sex + Age + SibSp, family =  "binomial", data = train.new[,-c("PassengerId",
                                                                                          "Name",
                                                                                          "Ticket")])

myResult <- predict(myModel4, newdata = test.new, type= "response")


myResult2 <- ifelse(myResult > 0.5, 1, 0)
myResult2
summary(myModel4)
step(myModel4)

#install.packages("ROCR")
install.packages("Metrics")
library(ROCR)
library(Metrics)
p <- prediction(myResult2, test.new$Survived)
p1 <- performance(p, measure = "tpr",
                  x.measure = "fpr")
plot(p1)


