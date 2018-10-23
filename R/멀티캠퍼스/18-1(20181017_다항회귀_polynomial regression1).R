# 1. 스칼라
d1 <- 1
d2 <-c(1)
d3 <- seq(1,2)
d3

# integer, numeric, character, vecter, raw 

#2. 벡터(Vector)
# 구성인자가 1이상(1차원)
d4 <- c("1","2","3",4)

#3. 요인(factor)
# 범주형, 순서형 데이터 구조 
d6 <- c("apple","banana","strawberry")
class(d6) # 벡터에 대한 타입
d6 <- as.factor(d6)
d6 # level 은 팩터 내 존재하는 카테고리. 
d6 <- factor(d6, order = T, 
                levels=c("banana",
                         "strawberry",
                         "apple")) # 순서화 시킬 수 있음. 
d6

# dataframe -> 1
# 1+1 = 2
# 행렬(matrix)
d7 <- matrix(1:20, nrow=2)
d7 # 2행 10열 
dim(d7)
# dataframe 대신 행렬을 쓸 수도 있지만, df로 더욱 쉽게 처리가 가능함.

# 배열(array) 
d9 <- array(1:24, c(2,3,4)) 

# 데이터프레임(dataframe)
# 데이터 유형에 관계없이 2차원 
d10 <- c(1,2,3,4)
d11 <- c("a","b","c","d")
d12 <- data.frame(No = d10, nm = d11)
dim(d12)

# 리스트(list) 
# container 기능 (그룹화)
d13 <- c(1,2,3,4)
d14 <- matrix(1:10, nrow=2)
d15 <- data.frame(c(1,2,3,4), c("a","b","c","d"))
d16 <- list(d13,d14,d15)
d16[[1]]
# vector, matrix, factor, array
# data.frame 
# list 


# p. 376 
# logistic Regression
# 일반화 선형모델(Generalized Linear Model : GLM)
# y = b + ax 
# 독립변수의 선형 결합을 이용하여 사건 발생 가능성을 예측하는 통계 기법 
# glm
# cyl, hp, wt

data <- mtcars[,c("am","cyl","hp","wt")]
head(data,2)
cl <- cor(data)
library(corrplot)
corrplot(cl)
glm_data <- glm(am ~ cyl + hp + wt,
                data = data,
                family = binomial)
summary(glm_data)
# 스팸 확인
# 부정 결제 
# 마케팅에서 사용 

# example_adult.csv 
# age, education, income(부등호)
library(dplyr)
data10 <- read.csv("example_adult.csv")
dim(data10) # 46000여건 
glimpse(data10) # 데이터를 맛보기 할 수 있는 함수. 필드 정보 확인, dplyr의 세부 함수. 
d2 <- select_if(data10,is.numeric) # 숫자열에 대해서만 출력 
head(d2,3) 
summary(d2)
library(ggplot2)
g <- ggplot(d2, aes(x=hours.per.week))
g1 <- g + geom_density(alpha=.2,
                        fill = "red")
g1
top_data <- quantile(data10$hours.per.week, .99)
library(magrittr)
data11<- data10 %>% 
  filter(hours.per.week < top_data) # 45537건, 1~99%

data12 <- data11 %>%
  mutate_if(is.numeric,
            funs(as.numeric(scale(.)))) # 정규화 

head(data12)

factor <- data.frame(
  select_if(data12, is.factor))

dim(factor)
names(factor)
# workclass
ggplot(factor, aes(x=factor$workclass)) + geom_bar()
# education
ggplot(factor, aes(x=education)) + geom_bar()
# martial.status
ggplot(factor, aes(x=marital.status)) + geom_bar()
# race
ggplot(factor, aes(x=race)) + geom_bar()
# gender
ggplot(factor, aes(x=gender)) + geom_bar()
# income
ggplot(factor, aes(x=income)) + geom_bar()

# 10th Dropout
recast_data <- data12 %>%
  select(-X) %>%
  mutate(education = factor(ifelse(education == "Preschool" | education == "10th" | education == "11th" | education == "12th" | education == "1st-4th" | education == "5th-6th" | education == "7th-8th" | education == "9th", "dropout", ifelse(education == "HS-grad", "HighGrad", ifelse(education == "Some-college" | education == "Assoc-acdm" | education == "Assoc-voc", "Community",
                                                                                                                                                                                                                                                                                            ifelse(education == "Bachelors", "Bachelors",
                                                                                                                                                                                                                                                                                                   ifelse(education == "Masters" | education == "Prof-school", "Master", "PhD")))))))
names(recast_data)
recast_data %>% group_by(education) %>%
  summarise(edu_year = mean(educational.num),
            count = n()) %>%
  arrange(edu_year) # 항목에 대해 카운트하고, 각 education 세부 항목 별 평균수치값 출력. 
# maritial-status
# never-married 

recast_data$gender
ggplot(recast_data, aes(x=gender, fill=income)) + geom_bar(position = "fill") # 성별에 따른 소득 

names(recast_data)
ggplot(recast_data, aes(x=hours.per.week)) + geom_density(aes(color = education)) # 학력 비율 
# 나이기준
g7 <- ggplot(recast_data, aes(x=age, y=hours.per.week)) + geom_point(aes(color=income),size=.5)
g8 <- g7 + stat_smooth(method = 'lm',
                       formula = y ~ poly(x,2), 
                       se=TRUE) # 다항회귀
g8 # 2차 함수 그래프처럼 나옴. 




# Logistics Regression -> 0,1 
# Training Set
# Testing Set 
library(tidyverse) 
#install.packages("caret")
library(caret)
theme_set(theme_bw())
#install.packages("mlbench")
# 당뇨병 임상 데이터 관련. 
data(PimaIndiansDiabetes2, package="mlbench")
str(PimaIndiansDiabetes2) 
table(is.na(PimaIndiansDiabetes2)) # 결측값 x
# OR
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2)
sample_n(PimaIndiansDiabetes2,3) # PimaIndianDiabetes에서 임의의 샘플 3개를 출력 
set.seed(123)
trainingSet <- PimaIndiansDiabetes2$diabetes %>%
  createDataPartition(p=0.8, list = F) # 원 데이터의 80% 정도를 가져온다. 대신 일련변호를 수집. 
class(trainingSet)
trainingSet
train.data <-PimaIndiansDiabetes2[trainingSet,] # 80퍼센트 정도의 실제 데이터 
train.data
test.data <- PimaIndiansDiabetes2[-trainingSet,] # 나머지 20퍼센트의 데이터 셋. 
PimaIndiansDiabetes2$diabetes
model <- glm(diabetes ~ .,data = train.data, family = binomial) # 로지스틱 회귀분석. 
summary(model)
p_result <- model %>% predict(test.data, type = "response")
p_result_classes <-
  ifelse(p_result > 0.5, "pos", "neg")
p_result_classes
mean(p_result_classes == 
       test.data$diabetes)

# diabetes, glucose 
model2 <- glm(diabetes ~ glucose, data = train.data, family = binomial)
newdata <- data.frame(glucose=c(20,180))
p_result2 <- model2 %>%
  predict(newdata, type = "response")
p_result2 # 0.004와 0.8이 나옴. 
p_result2_classes <- ifelse(p_result2 > 0.5, "pos", "neg")
p_result2_classes 

df <- train.data %>% mutate(prob = ifelse(diabetes == "pos", 1, 0)) 

g <- ggplot(data = df, aes(glucose, prob)) 
g1 <- g + geom_point()
g2 <- g1 + geom_smooth(method="glm", method.args = list(family="binomial")) 

g2

# 관계가 선형이 아니거나 데이터 타입에 따라 선형회귀를 사용할 수 없을 때. 
