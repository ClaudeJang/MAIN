# 주사위 (1,2,3,4,5,6)를 4번 던져서 나오는 숫자의
# 합 x에 대한 확률 
library(prob)
#rolldie(1) # 주사위 한 번 던지기 6^1
#rolldie(2) # 주사위 두 번 던지기 6^2
s <- rolldie(4) # 6^4
dim(s)
#temp <- matrix(c(1,2,3,4),nrow=2)
#temp
#apply(temp, 1, sum) # 행 기준 합
#apply(s,1,sum) 

# 빈도 확인(발생 건수) 
str(s) 
x <- apply(s,1,sum) # 각 행의 합을 더해서 4번 던졌을 때 나오는 주사위 수의 합을 구함. 
x
x.freq <- table(x)
# 각 확률 구하기 
x.freq <- x.freq / length(x.freq) # 비율 
length(x.freq)
x.freq  
# 1/6 + 1/6 + 1/6 + 1/6 + 1/6 + 1/6 = 1
plot(x.freq,type = "h")

# 이산확률변수 -> 이산확률분포 
# 50개의 제품 중 8개가 불량품이 있는 
# 상자로 부터 10개의 제품을 랜덤 샘플링
# 발견되는 불량 개수 X의 확률분포 
npop <- 50
nsampl <- 10
ndef <- 8
d <- choose(npop,nsampl)
freq <- choose(ndef,0:nsampl) *
  choose(npop-ndef,nsampl-(0:nsampl)) # 나올 수 있는 조합조건 
fx <- freq/d
fx
plot(0:10, fx, type="h")
options(scipen=9999) 

# 여덟명의 신사가 각각의 모자를 들고 모였는데
# 갑자기 정전이 돼서 아무 모자나 들고 집으로 돌아갔습니다.
# 자기 자신의 우산을 들고 간 신사의 수를 x라고 할 때, 
# 확률 변수 x의 확률은?
# 8모자, 8신사

hats <- LETTERS[1:8]
s <- urnsamples(hats,size = 8,ordered=T) # 인위적으로  샘플링 해주는 함수. 
s # ordered=T 를 통해 각각의 순서를 구별하여 나오는 경우의 수 전부 출력 
dim(s)
str(s) # factor로 되어 있어서 factor를 없애야 함. 
options(stringAsFactors = F)
rowN <- nrow(s)
checkFunc <- function(x){
  sum(x==hats)
}
X <- apply(s,1,checkFunc)
X.freq2 <- table(X)
X.freq2
X.prob2 <- table(X) /rowN
sum(X.prob2)
X.probs_6<- round(X.prob2,6)
sum(X.probs_6)
plot(X.probs_6,type = "h")

# 주사위 세 개를 던지는 시행에서 
# 짝수의 개수 
#d <- rolldie(3)
#k <- apply(d,1,sum) 
#checkFunc2 <- function(x){
#  k%%2==0
#}
#k2 <- apply(d,1,checkFunc2)
#k2
#X.freq3 <- table(k2)
#plot(X.freq3) 

S <- rolldie(3)
rowN <- nrow(S)
S
rowN
checkFunc3 <- function(x) sum(1-x%%2)
Y <- apply(S,1,checkFunc3)
table(Y)

# 주사위를 두 번 던지는 시행에서
# 눈의 최대치를 X라고 하고,
# 눈의 최소치를 Y라고 할 때 Z=XY의 
# 기대값을 구하시오.

S1 <- rolldie(2)
S1 
str(S1)
X1 <- apply(S1, 1, max)
table(X1)
Y1 <- apply(S1, 1, min)
table(Y1)
temp <- table(X1,Y1) / nrow(S1)
temp

XY <- (1:6 %o% 1:6)
(as.vector(XY)) %*% 
# E(XY) = 12.25

library(ggplot2)
mtcars
cars$speed
cars$dist
plot(cars$speed, cars$dist) # 산점도 형태 
# coins
S3 <- tosscoin(4)
S3
nrow(S3)
# 앞, 뒷면 개수를 세는 함수 
countH <- function(x) sum(x=='H')
countF <- function(x) sum(x=='T')
# 확률 변수 만들기 
X3 <- apply(S3, 1, countH)
Y3 <- apply(S3, 1, countF)
V3 <- Y3 - X3
w3 <- abs(V3)
par(mfrow=c(2,3))
plot(X3, Y3); abline(lm(Y3~X3), col=2) # H, T  # 회귀식
plot(X3, V3, type = "l") # H, V
plot(X3, w3)
plot(Y3, V3)

# 주사위 4번 던졌을 때
# 합,평균, 중앙값 (mean, median), 최대, 최소치 
# list <- 평균, 중앙값 넣어주기 

rolls<- rolldie(4)
rolls
table1 <- table(apply(rolls, 1, sum))
ratio1 <- round(table1/nrow(rolls),6)

mean1<- mean(apply1)
ratio2 <- round(mean1/nrow(rolls),6)
median1 <- median(apply1)
ratio3 <- round(median1/nrow(rolls),6)
table1<- table(apply1)
max1 <- max(apply1)
ratio4 <- round(max1/nrow(rolls),6)
min1 <- min(apply1)
ratio5 <- round(min1/nrow(rolls),6)
list(table1,mean1, median1, max1, min1)


# 성공확률이 각각 0.2, 0.5, 0.8인 무한모집단 10개씩 표본을 취하였을때,
# 나타나는 성공 회수의 확률분포는? 

n <- 10 # 시행횟수
p <- c(0.2,0.5,0.8) # 성공확률
x <- 0:n # 확률변수 X의 범위 
# 11행 3열
fx <- array(NA, dim=c(11,3))
fx
dim(fx)
for (i in 1:3){
  fx[,i] <- dbinom(x, n, p[i])
}
fx[,1]
fx[,2]
fx[,3]
colnames(fx) <- p
colnames(fx) 
rownames(fx) <- x
d <- round(t(fx),4)
# table(fx)
par(mfrow=c(2,2)) # plot 화면에 2*2 형식으로 보여주는 함수 
apply(d,1,sum) # 1이 나와야 정상  
plot(x, fx[,1]) # 0.2일 떄(1번 플롯)  
plot(x, fx[,2]) # 0.5    
plot(x, fx[,3]) # 0.8  
# 불량률이 0.03인 공정에서 20개의 표본을 추출하여 검사하고 
# 발견한 불량개수를 x라 할 때, 
# x의 확률분포함수, 2개의 불량률이 발견될 확률
dbinom(0:2, 20, 0.03)


# 정규분포와 관련 분포
# 1. 기댓값 중심으로 대칭이며, 중심위치는 엎어놓은 종 모양의 분포 
# dnorm, pnorm, qnorm, rnorm
# 표준정규분포 기대값 = 0, 표준편차 = 1
# x 축 -7~7
x <- (-140:140) / 20 

data <- matrix(c(
  dnorm(x, 0, 1),
  dnorm(x, 0, 2),
  dnorm(x, 2, 1),
  dnorm(x, 2, 2)),
  ncol = 4,
  byrow=F)
data
par(mfrow = c(2,2))
plot(x, data[,1], type= "l")
plot(x, data[,2], type= "l")
plot(x, data[,3], type= "l")
plot(x, data[,4], type= "l")
segments(0,0,0, max(data[,1]),
        lty=2,col=4)
# 확률변수 X가 N(2,2^2)을 따를 때, 구간 P(-1<X<4)를 구하시오. 
x3 <- (-140:140)/70
mu3 <- 2
sig3 <- 2
a3 <- 1;b3 <- 4
fx3 <- matrix(c(dnorm(x3,0,1),dnorm(x3,mu3,sig3)), ncol = 2, byrow=F)
fx3
px3 <- pnorm(4,mu3,sig3);px3
px4 <- pnorm(-1,mu3,sig3);px4
px3 - px4
plot(x3,fx3[,2],type="l")
x5 <- c(a3,seq(a3,b3,0.01), b3)
x5
# -1<X<4 => 0.7745.. -1부터 4까지 면적이 전체의 77퍼센트를 차지한다는 의미. 


# exerciese 1. dbinom
# 성공확률이 0.2인 n회의 시행에서 나온 성공횟수 Xn이라고 할 때, 
# n=10, 20, 50 각각에 대하여 Xn의 확률분포함수를 그래프로 출력하시오. 


# exercise 2. dhyper
# 성공확률이 0.2이고 200개의 단위로 구성된 모집단에서 비복원추출한 
# n개의 표본에서 나온 성공횟수 Xn이라고 할 때, 
# n=10, 20, 50 각각에 대하여 Xn의 확률분포함수를 그래프로 출력하시오.

# exercise 3. dpois
# 단위 제품 당 평균 결점수가 3개인 n개의 단위 제품에서 나온 결점수를 Xn이라고 할 때,
# n=2,5,10 각각에 대하여 Xn의 확률 분포 함수를 그래프로 작성하시오. 