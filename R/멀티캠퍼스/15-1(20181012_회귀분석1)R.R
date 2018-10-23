install.packages("UsingR")
# library or require
library(UsingR)
# galton : UsingR의 데이터, 부모 키/자식 키 값
str(galton)
head
par(mfrow=c(1,2)) # 두 개의 플롯을 한 화면에 보여주기 위해 쓰는 함수.
hist(galton$child)
hist(galton$parent)
cor(galton$child, galton$parent) # 0.458, 어느 정도 상관성이 존재. 
cor.test(galton$child, galton$parent) # 상관관계 분석. 피어슨 상관계수 
# p-value 0.00000000000000022, 상당히 유의한 값. 
# 소수점 값 상세히 보여주는 옵션
options(scipen=999)
xtabs(~child + parent, data = galton) # 두 개의 변수를 표로 해서 한 눈에 볼 수 있는 함수. 
lm_data <- lm(formula = child ~ parent, data= galton)
# 절편은 약 24, 기울기는 0.6463, y = 0.6463x + 23.9415 
summary(lm_data)
plot(child ~ parent, data=galton)
par(mfrow=c(2,2))
plot(lm_data)
# OR 
plot(child ~ parent, data=galton)
abline(lm_data, col="blue")
library(ggplot2) # 시각적 강조를 더 하고 싶다면
g <- ggplot(data=galton, aes(x=parent, y=child))
g1 <- g + geom_smooth(method = "lm")
g2 <- g1 + geom_point()


# Exercise 
# example_kbo2015.csv
data <- read.csv("example_kbo2015.csv")
# 안타(H)와 홈런(HR) 변수를 활용한 회귀분석을 하시오. 
str(data)
data2 <- data.frame(data$H, data$HR)
plot(data2) # Basic Plot Func
cor(data2$data.H, data2$data.HR)
cor.test(data2$data.H, data2$data.HR)
str(data2)
lm_data2 <-lm(formula = data.H ~ data.HR, data=data2) # y=2.448x + 709.652
summary(lm_data2)
ggplot(data=data2, aes(x=data.H, y=data.HR)) + geom_smooth(method = "lm") +
  geom_point()
par(mfrow=c(2,2))
plot(lm_data2)
abline(lm_data2, col="red")

## residual VS Fitted, Normal Q-Q, Scale-Location, Residuals Vs Leverage

#residuals vs. fitted values is a simple scatterplot between residuals and predicted values. It should look more or less random.
#normal Q-Q is a normal probability plot.  It will give a straight line if the errors are distributed normally, 
#Scale-Locationshould look random. No patterns. Ours does not–we have a strange V-shaped pattern.
#Cook’s distance tells us which points have the greatest influence on the regression (leverage points).


# Linear regression, 선형 회귀 
# 목표변수(종속변수)와 연속변수(독립변수)와의 관계를 찾는 방법. 
# 요건 : 변수는 연속적이어야 한다. 즉 숫자값.
# residual => 종속변수의 관측된 값과 회귀에서 예측된 종속변수 값 사이의 차이.(잔차) 

# 단순회귀(Simpler Linear)
# 다항회귀(Polynomial)
# 다중회귀(Multiple linear)
# 다수준, 다변량... 로지스틱 회귀

# y = ax + b 
# weight = a * height + b

# 다항 회귀 
weight <- c(58,59,60,61,62,63)
height <- c(115,117,120,123,126,129)
data2 <- data.frame(weight, height)
data3 <- lm(weight ~ height + I(height^2), data=data2)
data3
plot(weight ~ height, data= data2)
lines(data2$height, fitted(data3))
# weight = a + bx + x^2 식의 다항형태로 만들어지는 회귀식 


# 책 코드 따라하기(chapter 19. 선형모형)
# 19.1 simple linear regression 

# 아버지와 아들의 키 데이터 관계를 단순 선형회귀 모형을 사용해 플롯팅
data(father.son, package="UsingR")
library(ggplot2)
head(father.son)
ggplot(father.son, aes(x=fheight,y=sheight)) + geom_point() + geom_smooth(method = "lm") 
# geom_smooth(method = "lm")를 이용해 회귀선을 후가. 점 외곽의 회색은 이 적합에 대한 불확실성을 의미. 
# 회귀 값을 알고 싶다면,
heightLM <- lm(sheight~fheight, data= father.son)
heightLM  # y = 0.5141x + 33.8866, 아버지의 키가 1이 커지면 , 아들의 키는 0.5141+ 33.8866정도 커진다는 이야기 
# 계수에 대한 점 추정 이외에 표준오차도 확인해야함.
# 표준 오차는 추정에 대한 불확실 정도를 보여주기 때문. <- summary() 
summary(heightLM)


# 19.2 multiple linear regression , 단순회귀를 논리적으로 확장한 것이 다중회귀. 
# 복수의 예측 인자를 다룬다. 다중회귀를 기술하기 위해 행렬연산을 사용하는 것이 편하다. 
# Y = Bx + e에서 Y는 n개 항이 있는 벡터 
# x는 n*p 매트릭스.b는 p개의 벡터, e는 정규분포를 따르는 오차값. 
housing <- read.table("https://www.jaredlander.com/data/housing.csv",
                      sep=",", header = T, stringsAsFactors = F)
# 값 구분을 콤마로 하고, 첫 행이 열이름으로 쓰임. 문자열이 자동 팩터화되는 것을 막음. 
colnames(housing) <- c("Neighborhood", "Class", " Units","YearBuilt","SqFt","Income","IncomeperSqFt",
                       "Expense","ExpenseperSqFt","NetIncome","Value","ValueperSqFt","Boro")
head(housing)
# 반응변수 : ValueperSqFt, 나머지는 예측 변수. 수입과 지출변수는 무시. 

# 반응변수에 대한 히스토그램.
ggplot(housing, aes(x=ValueperSqFt)) + geom_histogram(binwidth = 10) + labs(x = "Value per Square Foot")
# 히스토그램이 2개의 봉우리를 보이는 것은 좀 더 조사할 여지 존재. 
ggplot(housing, aes(x=ValueperSqFt, fill=Boro)) + geom_histogram(binwidth = 10) + labs(x = "Value per Square Foot")
# 위 색깔 별 플롯팅
ggplot(housing, aes(x=ValueperSqFt, fill=Boro)) + geom_histogram(binwidth = 10) + labs(x = "Value per Square Foot")+
  facet_wrap(~Boro)
# 위 지역구별로 패시팅한 것. 

# 다중회귀(Multiple linear regression)
data5 <- mtcars[,c("mpg","disp","hp","wt")]
data5
model <- lm(mpg ~ disp + hp + wt, data=data5)  
model # mpg를 목표변수, disp, hp, wt를 상황변수 

# coef 회귀 계수.
# (Intercept) 
coef(model)[1]
coef(model)[2]
coef(model)[3]
coef(model)[4]
model
# y = 37.10551 + disp * (-0.0009370091) + hp * (-0.03115655) + wt * (-3.800891)
# fitted() : 적합된 값
fitted(model) [1:4] # 적합된 값 4개를 뽑아내겠다. 
# residuals() : 오차(error)
residuals(model)[1:4] 
# confint() : 회귀 계수의 신뢰구간 출력
confint(model)
par(mfrow=c(2,2))
plot(model,pch=16, col="red") 

# 피어슨 상관계수
# 선형적 상관계 있는지 확인할때 [-1 ~ 1]
cov(1:10, 2:11)
cov(1:5, 2:6)
cov(1:5, c(4,4,4,4,4))
# 스피어만 상관계수
# 두 데이터의 실제 값의 순위를 사용해 상관 
# 계수를 계산하는 방식
s <- c(2,3,4,3,2,1,5)
rank(sort(s))

x <- matrix(c(1:10, (1:10)^2), ncol=2)
cor(x, method = "spearman")
cor(x, method = "pearson")

# multiple Regression
install.packages("car")
library(car)
library(corrplot)
install.packages("visreg")
library(visreg)
install.packages("rgl")
library(rgl)
library(knitr)
install.packages("scatterplot3d")
library(scatterplot3d)

head(Prestige,5)
str(Prestige)
summary(Prestige)
colnames(Prestige)
# data <- Prestige[, c(1:4)]
# data
# plot(data, pch=16)
# # Income = B0 + B1*Education
# #       + B2 * Prestige 
# #       + B3 * Women
# educ <- scale(data$education, center = T,
#       scale=F)
colnames(Prestige)
data <- Prestige[,-6]
cor(data)
par(mfrow = c(1,1))
corrplot(cor(Prestige[,-6]), 
         method="number")
library(ggplot2)
par(mfrow=c(2,2))
# income * prestige
p <- ggplot(data=Prestige,
            aes(x=prestige,y=income, col=type)) 
p1 <- p + geom_point()
p1
# education * prestige
p <- ggplot(data=Prestige,
            aes(x=prestige,y=education, col=type)) 
p1 <- p + geom_point()
p1
# women * prestige
p <- ggplot(data=Prestige,
            aes(x=prestige,y=women, col=type)) 
p1 <- p + geom_point()
p1
# census* prestige
p <- ggplot(data=Prestige,
            aes(x=prestige,y=census, col=type)) 
p1 <- p + geom_point()
p1

lm_data3 <- lm(prestige ~ education +
                 log(income) + women + census,
               data=Prestige)

lm_data4 <- lm(prestige ~ education +
                 log(income),
               data=Prestige)
summary(lm_data4)


plot(Prestige$income)
plot(log(Prestige$income))



# CARS
cars$speed
cars$dist
(m <-lm(dist ~ speed, data=cars))
coef(m)
# plot(cars$speed,cars$dist)
fitted(m)[1:4]
residuals(m)[1:4]
fitted(m)[1:4] + residuals(m)[1:4] 
cars$dist[1:4] # 233번 줄과 값이 같음. 
confint(m) # 신뢰구간 도출 
predict(m, 
        newdata = data.frame(speed=3))
coef(m)

#-17.579095 + 3.932409 * 3
predict(m, 
        newdata = data.frame(speed=3),
        interval = "confidence")

predict(m, 
        newdata = data.frame(speed=3),
        interval = "prediction")
summary(m)
plot(cars$speed, cars$dist)
abline(coef(m))
summary(cars$speed)
predict(m, newdata = data.frame(speed = c(4.0,25.0,0.2)),
        interval = "confidence")
speed <- seq(min(cars$speed), 
             max(cars$speed), 0.1)
speed
ys <- predict(m, 
              newdata = data.frame(speed=speed),
              interval = "confidence")

matplot(speed, ys, type="n")
matlines(speed, ys, lty=c(1,2,2),
         col=1)

# example-kbo2015_player.csv

df <- read.csv("example_kbo2015_player.csv", 
               stringsAsFactors = F, na = "-")
df
str(df)
df$AO <- as.numeric(df$AO)
df$GO.AO <- as.numeric(df$GO.AO)
df$BB.K <- as.numeric(df$BB.K)
df$P.PA <- as.numeric(df$P.PA)
df$ISOP <- as.numeric(df$ISOP)
# 홈런과 다른 변수간의 상관계수를 확인(정렬)
Cors <- cor(df$HR, df[,5:length(df)], 
            use = "pairwise.complete.obs")

# "everything" : 결측값이 있는 경우 NA로 계산 결과 제시  
# "all.obs" : 결측값이 있을 경우 오류 발생
# "complete.obs" : 결측값이 있는 case는 모두 제거된 상태에서 상관계수 계산
# "pairwise.complete.obs" : 상관계수가 계산되는 변수들만을 대상으로 결측값이 있는 
#                           case제거한 상관 계수


Cors <- Cors[, order(Cors)]
Cors

# 홈런과 뜬공 변수에서 값이 0인 관측치
df$HR[df$HR == 0] <- NA

# 회귀모델을 구함
lm_data <- lm(HR ~ AO, data=df)
lm_data
# y = -0.5244 + 0.1541x
summary(lm_data)

par(mfrow=c(2,2))
plot(lm_data) 


# 1. diamonds 데이터로 캐럿에 따른 가격을 예측하시오.
# 회귀 모델을 구하고, 검증하시오. 
# 10캐럿, 20캐럿
diamonds
str(diamonds)
cor.test(diamonds$price, diamonds$carat)
m <- lm(price ~ carat, data=diamonds)
#m
#summary(m)
#coef(m) # price = -2256 + 7756* carat
#fitted(m)[1:4]
#residuals(m)[1:4]
#fitted(m)[1:4] + residuals(m)[1:4] 
#diamonds$price[1:4] # 일치함. 
predict(m, 
       newdata = data.frame(carat=c(10,20),
       interval = "prediction"))

predict(m, 
        newdata = data.frame(carat=c(10,20),
                             interval = "confidence"))
confint(m) # 신뢰구간 도출 
predict(m, 
        newdata = data.frame(carat=10))
# 새로운 데이터 가격 10에 대한 예측값 구하기. 
predict(m, 
        newdata = data.frame(carat=20))
predict(m, 
        newdata = data.frame(carat=20),interval = "confidence")
# 계수에 대한 신뢰구간(confidence)
predict(m, 
        newdata = data.frame(carat=20),interval = "prediction")
# 계수에 대한 예측구간(prediction)
colnames(diamonds)

