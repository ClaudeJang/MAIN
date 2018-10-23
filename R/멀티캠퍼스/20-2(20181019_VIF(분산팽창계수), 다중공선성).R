# P. 402
# simple linear regression
cars$speed
cars$dist
m <- lm(dist ~ speed, data= cars)
m
summary(m)
coef(m)
# fitted value 
fitted(m) # speed(1~50) 에 따른 distance의 '예측값'을 알려준다.
# residual 잔차 
residuals(m)

fitted(m) + residuals(m) # 예측값에 잔차를 더해주면 실측값에 가까워진다. = cars$dist

confint(m) # 신뢰구간
deviance(m) 
predict(m, newdata = data.frame(speed=3))
summary(m)
options(scipen=999)
anova(m) # 잔차 합, 잔차 평균, speed에 대한 유의수준. 
# 유의함을 보여줌. 
m2 <- lm(dist ~ 1, data = cars)
summary(m2) # 이 모형을 만든 이유는 원 모형이랑 비교하기 위해서 
anova(m,m2) # m과 m2의 분산분석(두 모형 간 비교) - F 통계량 확인
# page 404 

par(mfrow=c(2,2))
plot(m) 
# residuals vs fitted  에서 0에 가까울 수록 좋은 데이터 
# Normal Q-Q : 데이터가 정규형태로 증가하는지 확인. 중간에 간격이 있거나 급격히 커지면 문제
# Scale Location : 
par(mfrow=c(1,1))
with(cars, plot(speed, dist))
abline(coef(m))
# page 404 

# VIF(Variance Inflation Factor) 분산 팽창 계수 : 상관계수만 가지고 판단하는 것 보다, 상관계수 분포가 클 때 잘못될 가능성을 줄여준다. 

install.packages("car")
library(car) # vif
# vif() # 분산요인 팽창계수를 확인. 

library(MASS)
library(tidyverse) # 데이터 변환.
library(caret) # 기계학습
library(magrittr)
train.samples <- 
  Boston$medv %>%
  createDataPartition(p= 0.8, list = F)
train.data <- Boston[train.samples,]
test.data <- Boston[-train.samples,]

myModel <- lm(medv~., data=train.data)
predictions <- myModel %>% predict(test.data)
predictions
summary(myModel) 
vif(myModel) # VIF가 10이 넘는 값이 나오면 다중공선성이 있다고 보기 때문에 이 때의 변수값들은 제거하는 것이 좋다. 
# 결정계수 R2값은 높아 회귀식의 설명력은 높지만 식안의 독립변수의 P-value값이 커서 개별 인자들이 유의하지 않는 경우가 있다. 
# 이런 경우 독립변수들 간에 높은 상관관계가 있다고 의심된다.