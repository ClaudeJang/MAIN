library(ggplot2)
str(cars)
cars
plot(
  cars$speed,
  cars$dist,
  main="Speed/dist",
  xlab = "mph",
  ylab = "ft",
  pch=1,
  col="red"
)
summary(cars$dist)
data <- c(1,2,3,4,152,3,4,2,2,1)
mean(data) 
median(data)

class(Nile)
plot(Nile)

data <- read.csv("cafedata.csv",header=T,na.strings="na",stringsAsFactors=F)
data
str(data)

library(ggplot2)
g <- ggplot(data,aes(
  data$Coffees))
g2 <- g+ geom_bar(fill="gray")
g3 <- g2+xlim(0,50)+xlab("판매량")+ylab("횟수")
g3

data <- na.omit(data) # 문자로 된 NA를 바꿔주는 함수
# 최소값 / 최댓값
data$Coffees
sort(data$coffee)[1]
sort(data$Coffees,decreasing = T)[1]
min(data$Coffees)
max(data$Coffees)


stem(data$Coffees)
data2 <- c(1,2,3,4,5,3,4,2,2,1)
stem(data$Coffees,scale = 2)

rc <- table(cut(data$Coffees,breaks=seq(0,50,by=10),right = F))     
rc <- data$Coffees
stem(rc,scale = 2)
# 평균 
w <- 1/length(data$Coffees)
sum(rc*w)
mean(rc) # 평균 22잔 
rc
# 중앙값 
mean(rc,na.rm=T)
median(rc,na.rm=T)
# 표준편차 
data3 <- c(1,1,2,2,3,3,3,4,4)
mean(data3)
median(data3)
sd(data3)

height <- c(164,166,168,170,172,174,176)
height.mean <- mean(height)
height.v <- var(height)
height.sd <- sd(height)
sqrt(height.v)

# 교재
x <- sample(x=1:100, size=100,replace = T) # 1:100사이의 랜덤 숫자 100개를 뽑는다 .replace는 뽑은 숫자 또 뽑을 수 있음.
x
mean(x)
y <- x # x를 복사 
x[sample(x-1:100,size=20, replace = F)] <- NA # 여기에서 20개의 랜덤샘플을 골라서 NA로 설정
mean(y)
mean(y,na.rm=T)
# weight.mean - 가중평균 
grade <- c(95,72,87,65)
weights<- (c(1/2,1/4,1/8,1/8))
mean(grade)
weighted.mean(x=grade,w=weights) # 확률변수의 기댓값 
var(x)

# 평균/표준
rc <- data$Coffees
rc.m <- mean(rc)
rc.sd <- sd(rc)
rc.sd
cat("커피 판매량",round(rc.m,1),
    "+-",
    round(rc.sd,2),
    "잔")
?cat()
par(mar=c(2,0,0,2)) # 그래프 그려주는 함수 
x <- seq(-3,3,by=0.001)
plot(x,dnorm(x,mean = 0, sd=1),type='l') # dnorm : 정규 분포 함수 

par(mar=c(2,0,0,2))
x <- seq(158,182, by=0.01)
plot(x,dnorm(x,mean=170,sd=4),type='l',ylim=c(0,0.2))
lines(x,dnorm(x,mean=170,sd=2),lty=2,lwd=2) # 표편이 2라서 위 선 보다 더 분산이 작다. 중간에 몰리는 구조 

# 사분위, Quantile
qs <- quantile(rc)
qs
qs[4] - qs[2] # 30 - 12
par(mar=c(2,2,2,2))
bp <- boxplot(rc,axes=F)
axis(2) # 왼쪽 척도 

md <- median(rc)
sd <- sd(rc)
md

# 변동 계수 
# 분산/평균 

# mean, median, Quantile
# Range, Standard Deviation
# Variance
# Covariance, Correlation Coefficent 
cars
cov(cars$speed,cars$dist)
cor(cars$speed,cars$dist)
faithful
colnames(faithful)
cov(faithful$eruptions,faithful$waiting) # 0에 근접할 경우, 무상관 관계 
cor(faithful$eruptions,faithful$waiting) #1, -1로 갈 수록 강한 상관관계 
hist(cars$dist,cars$speed, breaks = seq(0,120,10)) # breaks=seq(시작값, 끝값, by=10)
boxplot(cars$dist) # 위의 점 하나 120에 위치 -> 이상값일 수 있음. 데이터 삭제 혹은 왜 이 값이 나왔는지 확인

# 예제 


data <- read.csv("example_studentlist.csv")
height1 <-data$height
# 1. example_studentlist.csv를 이용하여, 키(height)에 대한
# 평균, 중앙값, 범위, 사분위, 분산, 표준편차를 구하고 
# boxplot로 출력하시오.
height1.mean <- mean(height1)
height1.median <-median(height1)
height1.range <- range(height1)
height1.quantile <- quantile(height1, c(0.25,0.5,0.75,1))
height1.var <- var(height1)
height1.sd <- sqrt(height1.var)
# 2. example_salary.csv를 이용하여, 전국 연렬별 평균 월급을 구하시오.
# 평균, 중앙값, 사분위, 범위를 구하고 4가지 값을 이름이 list.result라는 리스트에 입력하시오.
data1 <- read.csv("example_salary.csv",stringsAsFactors = F,na="-") # '-'값을 NA로 바꿈. 
View(data1)
colnames(data1)
library(magrittr)
library(dplyr)
colnames(data1) <- c('age','salary_mean','bonus','working_hour','people_num','career','sex')
data1$salary_mean<-as.numeric(data1$salary_mean)
str(data1)
data1.mean<- data1 %>% group_by(age) %>% summarise(mean(salary_mean,na.rm=T)) # 연령별 평균 급여
# OR 
data1.mean1 <- aggregate(salary_mean ~ age, data1, mean) 

data1.median <- data1 %>% group_by(age) %>% summarise(median(salary_mean,na.rm=T)) # 연령별 급여 중갑값
# OR 
data1.median1 <- aggregate(salary_mean ~ age, data1, median)
colnames(data1.mean1)[2] <- c('salary_median')
# Quantile 
data1.quantile<- quantile(data1$salary_mean,probs=c(0.25,0.5,0.75,1),na.rm=T) # 1689658 2120345 2519221 4064286 
data1.range<-range(data1$salary_mean,na.rm=T) # 1117605, 4064286
list.result<- list(data1.mean,data1.median,data1.quantile,data1.range) # 값 4개를 리스트안에 넣음 

# 3. example_salary.csv를 이용하여, 그룹별 평균을 구하시오.
data1 <- read.csv("example_salary.csv",stringsAsFactors = F,na="-")

# 성별로 평균월급, 표준편차 및 그래프로 출력하시오.
data2.sex_mean<- aggregate(salary_mean ~ sex, data1, mean)

data2.sex_mean$sex <- c(1,2)

data2.sex_sd <- aggregate(salary_mean ~ sex, data1, sd)
data2.sex_sd$sex <- c(1,2)
g <- ggplot(data2.sex_mean,aes(x=data2.sex_mean$sex,y=data2.sex_mean$salary_mean)) + geom_bar(stat="identity") 
g1 <- ggplot(data2.sex_sd,aes(x=data2.sex_sd$sex,y=data2.sex_sd$salary_mean)) + geom_bar(stat="identity") 


# 경력별 월급, 표준편차 및 그래프로 출력하시오.
data2.career_mean <- aggregate(salary_mean ~ career, data1, mean)
data2.career_sd <- aggregate(salary_mean ~ career, data1, sd)

 