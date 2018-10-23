rm(list=ls())

library(tidyverse) # dplyr, readr, purrr, stringr 등 모든 해당 패키지 통합 
# install.packages("broom")
library(ggplot2)
library(broom)
theme_set(theme_classic())
data("marketing", package = "datarium") # 구글의 세일즈와 관련된 data 
sample_n(marketing, 3) 
# head(marketing,2)
myModel <- lm(sales ~ youtube, data=marketing)
myModel 
# sales = 8.43 + 0.047 * youtube 
# broom 패키지 안에 argument라는 함수 존재. 
myData <- broom::augment(myModel) # 각각의 잔차와 hat값을 알려준다. 
# 이 식을 시각화 해보자. 
g <- ggplot(myData, aes(youtube, sales)) + geom_point()
g1 <- g + stat_smooth(method=lm, se=FALSE)
g2 <- g1 + geom_segment(
  aes(xend = youtube, yend=.fitted),color = "red",size = 0.3
)
g2
par(mfrow=c(2,2)) # 한 면에 4개의 그래프 보여줌
plot(myModel)
# residual VS Fitted : 잔차 적합도, 0에 가까운 직선이 나오면 괜찮은 데이터. 
# 세부적으로 그릴거면 
par(mfrow=c(1,1))
plot(myModel, 3) # 이렇게 하면 해당되는 그래프만 크게 볼 수 있다. 
 