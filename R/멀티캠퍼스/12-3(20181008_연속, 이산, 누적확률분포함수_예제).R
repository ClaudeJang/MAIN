# 1. 무작위로 선정된 20명의 사람들이 있으며, 전국적으로 인구의 
# 5%는 밤에 혼자 사는 것을 무서워합니다. 20명 중에서 5명은 밤에 혼자 있는 것을 무서워합니다.
# 5명이 무서워 할 확률은?
d1 <- dbinom(x=5, size = 20,prob=.05 ) # 20명 중에서 5명이 무서워 할 확률, 전국적으로 무서워 하는 확률은 5%

#2. 위의 문제에서 0~20명 중에서 누군가 무서워 할 확률을 구하고 그래프로 출력하시오. 
x <- 0:20
Probability <- dbinom(0:20, size=20, prob=.05)
d2 <- data.frame(x=x,y=Probability)
ggplot(d2, aes(x=x,y=Probability)) + geom_point()
#  OR
qplot(x,Probability)
plot(x,Probability)
#3. 위의 문제 유형에서 100명의 무작위로 선택된 개인 그룹에서 0~100명의 사람들이 무서워할 확률은
# (무서워 할 확률 0.35)
dbinom(x=0:100, size=100, prob = 0.35)
data <- data.frame(x=0:100,y=dbinom(x=0:100,size=100, prob=0.35))
ggplot(data, aes(x=0:100,y=dbinom(x=0:100,size=100, prob=0.35))) +
  geom_point() +
  geom_line() +
  labs(x = "사람 수", y="확률")
#4.  75%의 성공률을 가진 약을 보유하고 있다. 20명으로 구성된 그룹이 있고, 
# 0~12명 사이의 사람이 긍정적으로 반응할 확률은?
# 그래프로 출력하시오. 
dbinom(x=0:12,size=20, prob=0.75)
data1 <- data.frame(x=0:12,y=dbinom(x=0:12,size=20, prob=0.75))
ggplot(data1, aes(x,dbinom(x=0:12,size=20, prob=0.75))) +
  geom_point() +
  geom_line() +
  labs(x = "사람 수", y="확률")

# pbinom(12,20,0.75) # 쉽게 누적확률로 구할 수 있음. 
x <- (1:20)
y <- pbinom(1:20,20,0.75)
qplot(x,y)

# 5. 75%의 성공률을 가진 약을 보유하고 있습니다. 20명의 그룹에 1000번의 시도를 하였습니다.
# 각 시도에 대한 이항 분포 및 그래프를 출력하시오. 
y10 <- rbinom(1000,20,.75)
class(y10)
y11 <- as.data.frame(y10)
table(y10)
qplot(y10)
ggplot(y11,aes(x=y10)) + geom_histogram(binwidth = .6)

# 6. 2017년 뉴욕타임즈 기사에서 2009년도 부터 2017년도까지 매주 평균적으로 24마리 말이 죽었습니다. 
# 0~40마리 말이 일주일 안에 죽을 확률은?
qplot(1:40, dpois(1:40,24))

# 7. 1주일에 30마리 이상의 말이 죽을 확률은? 
ppois(30-1,24) # 람다 : 24, x값 변수 

# 8. 수학퀴즈에서 객관식 문제가 10개가 있습니다. 
# 각 질문에서 네가지 가능한 대답 중에서 하나만 정답입니다.(0.25)
# 학생들이 모든 문제에 무작위로 대답하고 하면 5이하의 정답을 가질 확률은?
n = 11
k <- seq(0, 11, by=1)
y <- c(dbinom(k, size=n, prob = 0.25))
barplot(y, k)

