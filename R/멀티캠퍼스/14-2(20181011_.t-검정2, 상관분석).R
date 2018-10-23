data2 <- data.frame(
  name = paste0(rep("M-", 10), 1:10),
  weight = round(rnorm(10,20,2),1)
)
# paste0(rep("M-", 10), 1:10) 
#round(rnorm(10,20,2),1)

data2
summary(data2)
# 시각화 하기
boxplot(data2$weight)
# Shapiro-wilk, 정규성 테스트 
# Null 가설 : 데이터가 정상적으로 분산되어 있음.
# Alternative 가설 : 데이터가 정상적으로 분산되어 있지 않음. 
shapiro.test(data2$weight) # p-value : 0.615 > 0.05이므로 귀무가설을 채택. 
# 두 데이터가 정상적으로 분산되어 있다. 

# install.packages("ggpubr")
library(ggpubr)
ggqqplot(data2$weight,
         ylab="Test",
         ggtheme = theme_minimal()
         )

t.test(data2$weight,
       mu=25 # 평균 체중
       ) 
# 평균체중이 25인지 아닌지 체크; 귀무 : 25다, 대립 : 25 아니다. 
# p-value : 0.0001453이므로 귀무가설 기각. (25 아니다)

# 평균 체중이 25kg 미만인지 여부 테스트
t.test(data2$weight, alternative = "less")
# p-value =1 이므로 귀무 채택. 25kg 미만이다. 

# 평균 체중이 25kg보다 큰지 여부 테스트 
t.test(data2$weight, alternative = "greater")
# p-value = 1.26e-10 이므로 특정 이상치에 해당. 귀무 기각할 충분한 근거가 있다. 


## 상관분석, Correlation Analysis
install.packages("corrplot")
install.packages("RColorBrewer")
library(RColorBrewer)
library(corrplot)
data3 <- cor(mtcars)
corrplot(data3, type="upper",
         order="hclust",
         col=brewer.pal(n=8,
                        name="RdYlBu")) # 각 요소별 상관관계를 시각화 색상으로 보여준다. 
# -1<...<0, 0<...<1 
# rquery.cormat()
dim(mtcars)
source("rquery_cormat.r")
data4 <- mtcars[,c(1,3,4,5,6,7)]
require("corrplot")
rquery.cormat(data4)



## 두개 이상의 그룹의 평균을 비교
# 분산 분석(Analysis of variance:ANOVA)
# - 일원분산 분석(One-way ANOVA Test)

# ANOVA 테스트 가설
# NULL hypothesis => 다른 그룹의 평균과 같음
# Alternative hypothesis => 하나 이상의 표본이 다른 평균과 동일하지 않음 
data4 <- PlantGrowth
str(PlantGrowth)
names(PlantGrowth)

# grouping
library(magrittr)
library(dplyr)
data4 %>% group_by(group) %>% summarise(
  count = n(),
  mean=mean(weight,na.rm=T),
  sd=sd(weight,na.rm=T)
)
library(ggpubr) 
ggboxplot(data4, x="group", y="weight",
          color = "group",
          palette = c("#00AFBB",
                      "#E7B800",
                      "#FC4E07"))
# ggline으로 그릴 수 있음. 
ggline(data4, x="group", y="weight",
       add = c("mean_se","jitter"))
      
boxplot(weight ~group, data = data4, col=c("#00AFBB",
                                            "#E7B800",
                                            "#FC4E07"))
data5 <- aov(weight ~ group, data=data4) # 분산분석
# 자유도 = 파라미터 변수가 들어왔을 때, n-1을 의미. 하나를 뽑았을 때 남은 n-1개의 자유도가 있다. 
summary(aov(data5))


## 
library(reshape2)
library(plyr)

tipAnova <- aov(tip ~ day-1, tips) # 절편값 없이.
names(tipAnova)

tipAnova$coefficients
tipIntercept$coefficients
tipIntercept <- aov(tip ~ day, tips) # 절편값 보여줌
summary(tipAnova) # 분산분석은 그룹 간의 차이의 유무만을 따지지 어떤 그룹 간 차이가 있는지는 따지지 않는다. 
# 그래서 하나의 p값만 출력. 
# p값이 2e-16으로 통계적으로 유의. 그룹간의 차이가 있다(대립가설)
# 그룹 평균과 신뢰 구간을 플롯팅해서 겹치는 것을 찾아보자. 
tipsByDay <- ddply(tips, "day", plyr::summarise,
                   tip.mean = mean(tip), tip.sd = sd(tip),
                   Length = NROW(tip),
                   tfrac= qt(p=0.90,df=Length-1),
                   Lower = tip.mean - tfrac*tip.sd/sqrt(Length),
                   Upper = tip.mean + tfrac*tip.sd/sqrt(Length))
ggplot(tipsByDay, aes(x=tip.mean,y=day)) + geom_point() + geom_errorbarh(aes(xmin=Lower,xmax = Upper),
                                                                         height=0.3)
# 일요일 팁이 목, 금요일과는 다른 것을 알려준다, p =0.9, 90퍼센트 신뢰구간. 
# nrow 대신 NROW를 사용한 것은 계산의 확실성을 보장하기 위해서. 
# nrow는 df나 matrix에만 사용가능한데, NROW는 1차원을 갖는 객체의 경우 모두 그 개수를 반환한다. 
nrow(tips) # 데이터 프레임이라서 함수 사용가능. 
NROW(tips)
nrow(tips$tip) # num이라는 각 컬럼에서 사용불가. 
NROW(tips$tip) # 1차원 객체라도 사용 가능. 
str(tips)
class(tips)
tips
mean(tips$tip)


# 정수기 AS 기사는 몇 명이 적당할까?
# 1열 : 총 정수기 대여 대수(월)
# 2열 : 10년 이상... 대수()
# 3열 : AS시간(당월) 
data <- read.csv("example_data01.csv")
str(data)
par(mfrow = c(1,2))
plot(data$purifier, data$as_time)
plot(data$old_purifier, data$as_time)
cor(data$purifier,data$as_time) # 0.9면 상당한 연관성이 있다.
cor(data$old_purifier,data$as_time) # 0.87
# y = ax + b <- 회귀 선.  

cars
# speed : 차 속도, dist : 제공거리
lm_result <- lm(formula = dist ~ speed, cars) 
summary(lm_result)
# 회귀분석 
# 어떤 현상을 발생시키는 원인들(독립변수)
# 그 원인들로 인한 결과(종속변수)에 영향을 미치는 지를 
# 간략화된 "회귀방정식"
# 을 통해서 분석/예측하는 방법 
# OLS를 이용한 회귀선 예측 

coef(lm_result)
par(mfrow =c(2,2))
plot(lm_result)
##### 
plot(cars$speed, cars$dist)
abline(lm_result)


x <- c(151,174,160,186,150,179,153)
y <- c(63,81,56,91,47,76,62)
data10 <- data.frame(x,y)
lm_data10<- lm(formula = y ~ x, data10)
summary(lm_data10)  
par(mfrow=c(2,2))
plot(lm_data10)
plot(x,y)
abline(lm_data10)
h <- data.frame(c(155,172,156,181,151,175,159)) # 가상의 데이터 셋을 데이터프레임화 시킴.
w <- round(predict(lm_data10,h),1) # 이 키에 대한 데이터와 기존 회귀식에 부합하는 예측 몸무게 값을 나타내준다.
w

# faithful를 이용한 그래프 그리기.
p <- ggplot(faithful, aes(waiting, eruptions))
pl <- p + geom_point() + geom_smooth(method = "lm")
pl
cor(faithful$waiting, faithful$eruptions) # 0.9 강한 상관관계 

# lm .. 
lm_data11 <- lm(waiting ~ eruptions, data=faithful)
lm_data11
summary(lm_data11)
par(mfrow=c(2,2))
plot(lm_data11)
