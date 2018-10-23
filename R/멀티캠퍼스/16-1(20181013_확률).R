# Probability(확률) 
# 1. 어떤 실험을 통해서 나타나는 결과를 알지 못하는 경우 
# 2. 결과를 알지 못하지만, 결과로 나타날 가능성이 있는 경우
# 3. 동일한 실험을 몇 번하고, 반복할 수 있다. 
# 표본공간, 사건
# 사건 ~ 합사건(합집합), 곱사건(교집합), 여사건(해당 케이스 제외하는 사건)
# 배반사건(겹치지 않는, 동시에 발생하지 않는 사건), 독립사건 etc..


# ex) 동전
# 확률실험, 표본공간, 사건 
# 동전을 두 번 던져 나오는 면을 확인. 
# 표본공간 => HH,HT,TH,TT 
# 사건 => 첫 번째 동전이 앞면 나올 확률 
#         HH, HT 

# ex) 인터넷 사용 시간 
# 하루 중 인터넷 사용시간을 관찰 
# 표본공간 => 0 <- t = 24
# 사건 => 사용시간이 1시간 이하인 사건 
#         0 <= t <= 1

# 실험 수 : N (N번의 반복) 
# A사건 발생 : n 
# A사건 발생 확률 : 사건 A에 대한 발생확률 P(A) = n/N
library(prob)
tosscoin(2)
rolldie(10)
urnsamples(1:3, size=2) # 비복원 추출 
urnsamples(1:3, size=2,replace=T) # 복원 추출
# 문자 R 3개, 문자 B 2개 구성. 비복원추출
urnsamples(c(rep("R",3),
             rep("B",2)),
           size=1)
# 동전을 두 번 던졌을 때 나올 확률 
tosscoin(2, makespace=T)
tosscoin(3, makespace=T) 

tosscoin(2)
# HH 2 1/4 
# TH 1 1/4 => HT, TH 
# HT 1 1/4
# TT 0 1/4

x <- c(0,1,2)
px <- c(1/4,2/4,1/4)
# 평균이라고 나오는 수치가 실제 데이터에 속하지 않을 수 있기 때문에
# '기대값'이라고 부른다.
Ex <- sum(x*px) # 확률과 각 해당 값 곱의 합 = 기대값 
Ex

# 공분산 


# 동전을 25번 던졌을 때 앞면이 19번이 나올 확률은? 0.0052
probability_value <- .5
wins <- 19# 앞면이 나오면 이긴 것으로 설정
flips <-25
dbinom(wins,flips,probability_value) # 이산확률변수, 셀수 있는 숫자의 경우. 셀 수 없을 때는 연속확률변수 
# 0.052 
dbinom(1:18, flips, probability_value) # 1번이 나올 확률 ~ 18번이 나올 확률 
options(scipen = 999) # 소수점 다 볼려고 하면 

pbinom(wins-1,flips,probability_value) # 18번까지 나올 확률의 누적합 
1-pbinom(wins-1,flips,probability_value) # 19번 ~ 25번 나올 확률의 누적. 

# 0:25
library(ggplot2)
wins <- c(0:25)
totalFlips <- 25
probability_value <- .5

x1 <- 1-pbinom(wins-1, totalFlips, 
               probability_value)
x1
x2 <- dbinom(wins, totalFlips, 
             probability_value)
data <-
  data.frame(wins1 = x1, prob_value = x2)
data
library(ggplot2)
ggplot(data, aes(x=wins, y=x2)) + geom_point() + geom_line()


# 이산확률변수, 연속확률변수, 
# 이상분포..
# 연속확률분포..

# 확률변수 X의 시행 횟수가 6이고
# 확률이 1/3인 이상분포를 따를 때
n <- 6
p <- 1/3
x <- 0:n # n+1개 
data2 <- data.frame(x=x,y=y)
data3 <- data.frame(x=x,y=y1)
# dbinom(x, size, prob)
# x : 이항분포의 성공 횟수의 벡터 
# size : 시행의 횟수 
# prob : 성공의 확률 
px <- dbinom(x, size = n, prob = p)
# 성공횟수, 확률 
px1 <- pbinom(x, size = n, prob = p)
# plot
plot(x, px, type='s', 
     xlab = "성공횟수",
     ylab = "확률(P(X=x))",
     main = "B(6,1/3)")
ggplot(data2, aes(x=x, y=px)) + geom_point() + geom_line()
ggplot(data3, aes(x=x, y=px1)) + geom_point() + geom_line()

# 이항분포 누적함수 
# pbinom(x, size, prob)
# x : 이항분포의 성공횟수
# size : 시행의 횟수 
# prob : 성공의 확률 

pbinom(2, size = n, prob = p)
# 성공횟수가 2이하일 확률
pbinom(4, size = n, prob = p)
# 성공횟수가 4이하일 확률 
pbinom(4, size = n, prob = p) - pbinom(2, size = n, prob = p)
# 확률 (P(2<=X<=4))

# exercise
# 1. 동전 1000번 던져 490번 앞면이 나올 확률은?
prob1 <-.5
flips <-1000
wins <- 490
dbinom(490,1000,.5)

# 2. 흡연율이 25%로 알려진 1020명이 있는 대학에서
# 무작위로 50명을 뽑았을 때 흡연자인 확률은?
prob2 <- .25
size1 <- 1020
people <- 0:50
dbinom(people, size1, prob2) 

library(prob)
S <- rolldie(4)
N <- nrow(S)
S
N

item <- c("합", "범위", "최대치","최소치")
Mt <- paste0("주사위 4개의 눈은",item,"확률분포" )
X <- vector("list", 4) # 벡터로 변환
X[[1]] <- apply(S,1,sum)
X[[3]] <- apply(S,1,max)
X[[4]] <- apply(S,1,min)
X[[2]] <- X[[3]]-X[[4]]
X
library(corrplot)
corrplot(X,Mt,item)

# 성공확률이 각각 0.2, 0.5, 0.8인 무한모집단에 
# 10개씩 표본을 취하였을때 나타나는 성공횟수의 확률 분포표를 구하시오.
n <- 10
p <- c(0.2,0.5,0.8) # 각각 따로 만들어도 상관없음. 
x <- 1:n

# t분포(distribution)
# student-t분포, 자유도 
# 표준 정규분포 
# 1, 5, 10, 30인 t분포의 확률밀도 
# 함수를 작성하시오. 
# (-1,1)(-2,2)(-3,3)의 확률은?
x <- -100 : 100/30
mu <-c(1,5,10,30)
par(mfrow=c(1,1))
plot(x, dnorm(x), type="l")
abline(v=0, lty=2, col=3)
#for (i in 1:4){
# lines(x,dt(x,mu[i]),lty=i+1, lwd=2)
#}
lines(x, lines(x,dt(x,mu[1])), lty = i+1, lwd=2)
lines(x, lines(x,dt(x,mu[3])), lty = i+1, lwd=2)



# F-분포(distribution)
# 카이제곱분포를 따르며 독립적인 두개의
# 확률변수를 각각의 자유도로 나우어 비율을
# 취하면 F-분포를 따름.
# 자유도가8과 5인 독립적인 카이제곱분포
# 모집단에 10,000개씩 표본을 랜덤하게
# 추출하여 (x^2,8)/x^2,5) 히스토그램을 

# 1. 평균 50, 표준편차가 5인 정규분포
# 0 ~ 100, 1 x축기준
# 확률변수 값을 구해서 그래프로 출력
x <- seq(from=0, to=100, by=1)
y <- dnorm(x, mean=50, sd=12)
plot(x, y, type="l")

# 2. 100번 시행는 베루누이 시행이고
# 단일 확률 50%인 이항분포 그래프를 출력
x <- seq(from=0, to=100, by=1)
y <- dbinom(x, size=100, prob=0.5)
plot(x, y, type="l")
# 3. 
# rnorm(300, mean=70, sd=20)
# 확률 밀도함수를 정의하시오.
data <- rnorm(300, mean=70, sd=20)



