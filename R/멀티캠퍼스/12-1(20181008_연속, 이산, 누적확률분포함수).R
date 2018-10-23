# 동전 던지기, 주사위 굴리기, 주머니에서 공
# 뽑기 들의 확률 실험
# 표본 공간을 만들고 확률을 구해보자. 

install.packages("prob")
library(prob)
tosscoin(1)
rolldie(1)
urnsamples(1:3, size = 2) 
# 1부터 3까지 두개의 항목을 뽑는 것. 
# x1, x2 두번의 시행. 
tosscoin(2, makespace = T)
# prob 확률
urnsamples(1:3, size = 2, replace = T)
urnsamples(1:3, size = 2, replace = T,ordered=T)

# 확률 변수
x <- c(0,1,2)
y <- c(1/4,2/4,1/4)
barplot(y,
        names=x,
        xlab="앞면횟수(x)",
        ylab="확률(p[X=x]")
sum(x*y)
x * 2
x * (1:6)
x * (1:4)

runif(10) # 10개의 임의의 확률변수 기본으로는 0~1까지 
runif(20, min = 10 , max= 20) # 10부터 20까지의 랜덤하게 확률변수를 뽑음. 
rnorm(10, mean=100 , sd=15 ) # 평균이 100이고 표준편차가 15인 확률변수 10개 
# 평균 100을 기준으로 +- 15 
# 정규 분포 랜덤하게 생성
rnorm(50, mean=100 , sd=15)
rnorm(1000, mean=800, sd = 90)
pnorm() # 주어진 숫자에서 해당 숫자까지의 누적확률을 반환한다. 

# 이항분포 랜덤하게 생성, binomial distribution
rbinom(100, size = 1, prob = 0.5) # n 관찰횟수, size 시행횟수, prob = 성공확률 
rbinom(100, size = 1, prob = 0.8) 
rbinom(10, size=1, prob= 1/4)
a <- rbinom(10, size=1, prob= 1/6) # 내가 원하는 확률과 사이즈를 설정할 수 있다. 
a[a==1] <- "성공"
a[a==0] <- "실패"
a

# 정규분포 dnorm() - 점일 경우, pnorm() - 구간일 경우
# 이항분포 rbinom() - 점일 경우,, pbinom() - 구간일 경우
dnorm(15, mean = 30, sd= 7)
dnorm(50, mean= 550, sd = 80) # 확률변수들의 기대값이 550이고 편차가 80일때, 450을 집어넣으면 그 때의 확률 값. 
dbinom(490, size =1000, prob= 0.5)
pbinom(490, size= 1000, prob= 0.5)
dbinom(50, size =1020, prob= 0.25)

x <- seq(-5, 5, length= 200)
y <- dnorm(x, mean =0, sd= 1 )
plot(x, y, type= "l")
dnorm(4, mean= 0, sd= 1)


x1 <- 0:20
x1
y1 <- dbinom(x1, size= 20, prob = 0.5) # 임의적으로 데이터 x1 넣음
plot(x1, y1, type="h")
#P(X=12)
dbinom(12,size=20, prob=0.5) # 값자체를 랜덤하게 뽑는게 아님. 
# 동전, 100번 던지기 , 이항 변수, F(앞), B(뒤), 그 중 10번정도 앞면이 나올 확률.
dbinom(10, size=100, prob= 0.5)
# 평균이 10. 표준편차가 6인 확률변수 10의 값을 구하라.(연속형 변수)
dnorm(10, mean=10, sd=6)
# 0~235 구간 
pnorm(235, mean=240, sd=80)
# 350~235 구간의 확률을 알고 싶을 때의 확률값. 
pnorm(350, mean=240, sd=80) -
pnorm(235, mean=240, sd=80)

# 2000번 동전을 던져서 앞면이 0부터 900번까지 나올 확률. 
k1 <- pbinom(900, size= 2000, prob= 0.5)
k2 <- pbinom(0, size= 2000, prob= 0.5) 
k1- k2
# 0~900이므로 k2는 구해도 되고 안 구해도 됨. P(k2) = 0이기 때문. 

x <- seq(from=0, to =100, by=1)
y <- dnorm(x, mean= 50, sd=11)
x
y
plot(x,y, type="l")

x <- seq(from=0, to= 100, by=1)
y <- dbinom(x, size=100, prob=0.5)
plot(x,y, type="l")


# 이항분포
# 연속된 n번의 독립적 시해에서 
# 각 시행이 확률 p를 가질 때의 이산확률분포
# 베르누이 시행이라고 불림, 
# 동전(앞/뒷) / 주사위(1,2,3,4,5,6)/성공,실패
sample(c("H","T"), size=20, replace=TRUE,
       prob=c(0.5,0.5))
rbinom(10,1,1/2) # r은 샘플링
rbinom(10,1,0.3)
dbinom(c(0,1),1,0.5) 
rbinom(10,1,.3) # 10번 던져서 1이 나오는 것을 출력(확률은 30%) 
rbinom(100,10,.3)
# prob = .5
# wins : 19
# totalFlips : 25 
dbinom(19, 25, 0.5) # 25번 던져서 19번 정도 이길 확률 
dbinom(0:18,25, 0.5)
sum(dbinom(0:18,25, 0.5)) # 거의 1에 근접함. 
pbinom(19-1, 25, 0.5) # 누적확률 
library(ggplot2)
# 분포도 그리기 
wins <- c(0:25)
totalFlips <- 25
probabiltity <- .5
d<- 1-dbinom(wins-1, totalFlips, probabiltity)
d1 <- dbinom(wins, totalFlips, probabiltity)
data <- data.frame(wins,d,d1)
data

# x : coin 던진 횟수 
# y : 확률
ggplot(data, aes(wins,d1)) + geom_point() + geom_line() 

# 포아송 분포 rpois, dpois, ppois, qpois

# 일정한 단위 시간, 단위 공간에서 어떤 사건에서 
# 발생하는 경우에 사용할 수 있는 이산확률분포
# 책, 500페이지가 있는데, 200페이지 오타 있음. 
# 1페이지 3페이지 발견할 확인 확률 
# 200/500 = 0.4
dpois(3,0.4) # 포아송분포의 밀도 수 
# 책 200페이지가 있는데, 10페이지 오타있음. 
# 1페이지에서 2개의 오류가 발생할 확률 
# 10/200 = 0.05
dpois(2,0.05)
dpois(1:40, 24)
qqplot(1:40, dpois(1:40,15),xlab="Horse",ylab="Prob")

# 연속 확률분포(continuous probability)
# - 정규 분포(normal distribution)
# - t 분포(T-distribution)
# - F 분포(F - distribution) 
