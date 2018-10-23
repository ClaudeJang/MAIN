install.packages("tidyverse")
library(tidyverse)
library(ggpubr)
theme_set(theme_pubr)
install.packages("devtools")
library(devtools)
devtools::install_github("kassambara/datarium")
data("marketing", package = "datarium")
head(marketing,3)
# youtube에서 1년에 지출한 광고 예산에 따른 판매를 예측하고 싶다. 
str(marketing)
library(ggplot2)
g <- ggplot(marketing, aes(x=youtube, y=sales))
g + geom_point() + geom_smooth(method="lm")

# 단순 선형 회귀 분석을 하시오. 
# 상관관계를 확인 해서 각 계수별 음 양의 관계를 파악한다. 
cor(marketing$youtube, marketing$sales)
m <- lm(sales ~ youtube , data=marketing)
# y = -40.14 + 12.87* x 

m
g1 <-ggplot(data=m, aes(x=youtube, y= sales)) + geom_point() + stat_smooth(method="lm")

summary(m)

# Multiple Regression 
library(car)
library(corrplot)
library(visreg)
library(rgl)
library(knitr)
library(scatterplot3d)

summary(Prestige)
colnames(Prestige)
newdata <- Prestige[,c(1:4)]
newdata
plot(newdata, pch=16, col="blue") # pch = 4*4 
education.c <- 
  scale(newdata$education,center = T,scale=T)
education.c # matrix 형태로 만들어 주기 위해서 이렇게 한다. 
prestige.c <- scale(newdata$prestige,center=T,scale=T)
women.c <- scale(newdata$women, center = T, scale=T)
# 매트릭스 형태라서 cbind로 붙이고 타이틀 붙여서 구조를 본다. 

new.vars <- cbind(education.c, prestige.c,women.c)
newdata <- cbind(newdata, new.vars)
colnames(newdata)
names(newdata)[5:7] <- c('education.c','prestige.c','women.c')
summary(newdata)

# linear mode 
# education.c, prestige.c, women.c -> income
model2 <- lm(income ~ education.c + prestige.c + women.c, data= newdata)
model2
summary(model2)
newdatacor = cor(newdata[1:4])

corrplot(newdatacor, method = "number")
par(mfrow=c(2,2))
plot(mode12)
# 3D 형태로 나타내기 
model3 <- lm(income ~ prestige.c + women.c, data=newdata)
newdat <- expand.grid(
  prestige.c = seq(-35,45,by=5),
  women.c =seq(-25,70,by=5))
newdat
newdat$pp <- 
  predict(model3, newdata =  newdat)
newdat
colnames(newdat)
head(newdat)
with(newdata, plot3d(
  prestige.c,
  women.c,
  income,
  col="blue",
  size=1,
  type="s")) # with 목적은 앞에 $써서 붙이기 싫어서, 간단히 하려고, 

with(newdat, surface3d(
  unique(prestige.c),
  unique(women.c),
  pp,alpha=0.3,
  front="line",
  back="line"
))

# 키 몸무게 회귀 example_studentlist.csv
# summary
# 잔차(Residuals)
df <- read.csv("example_studentlist.csv")
head(df, 3)
lm_data <- lm(height ~ weight, data=df)
lm_data
par(mfrow=c(1,1))
plot(height ~ weight, data=df)
abline(lm_data, col="red")
summary(lm_data)
par(mfrow=c(2,2))
plot(lm_data)


