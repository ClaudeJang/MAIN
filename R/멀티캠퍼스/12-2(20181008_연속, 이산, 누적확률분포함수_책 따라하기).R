rnorm(n=10)

rnorm(n=10, mean=100, sd=20)

# probabiltity density - 특정 값에서의 확률값. dnorm함수를 이용해 계산. 
# dnorm : 특정 숫자가 발생하는 학률을 반환. 확률 실값이 아닌 확률 추정치. 연속분포에서 정확한 실수치를 계산하는 것은 불가능하기 때문. 
randNorm <- rnorm(30000)
randDensity <- dnorm(randNorm)
library(ggplot2)
ggplot(data.frame(x = randNorm, y= randDensity)) +
  aes(x=x,y=y) +
  geom_point() +
  labs(x="Random Normal Variables",y="Density")
# 정규분포를 따르는 난수들에 대한 플롯과 밀도 곡선 

# pnorm 
p <- ggplot(data.frame(x=randNorm, y = randDensity)) + aes(x=x,y=y) +
  geom_line() + labs(x="x",y="Density")
p
# 곡선 아래에 색을 추가하기 위해서 먼저 해당영역을 그려야 함. 
# 아주 왼쪽에서 -1까지 연속된 숫자를 생성한다. 
neg1Seq <- seq(from=min(randNorm),to = -1, by=.1)

# 연속된 값과 그 값의 밀도값을 결합해 데이터 프레임을 만든다. 
lessThanneg1 <- data.frame(x=neg1Seq, y=dnorm(neg1Seq))
head(lessThanneg1)
# 이렇게 만든 거을 가장 왼쪽값과 오른쪽 값을 추가해 결합한다.
# 이 두 지정의 높이는 0으로 한다. 

lessThanneg1 <- rbind(c(min(randNorm),0),lessThanneg1, c(max(lessThanneg1$x),0))
# 색칠할 부분은 다각형으로 정의한다. 
p+ geom_polygon(data=lessThanneg1, aes(x=x,y=y))


# binomial distribution 
# 이항분포에서 난수는 독립 시행에서 성공하는 횟수를 생성한다. 
# 각 시행에서 성공확률이 0.4인 시행에서 10번 시행해서 성공할 횟수를 시뮬하기 위해 
rbinom(n=1, size=10, prob=0.4)
# 즉, 10번 시도했을 때 각각의 성공확률이 0.4인경우, 반환되는 값은 성공횟수이다. 
# 만약 n 값을 다른 값으로 설정하면 사이즈 값 만큼의 회수를 n세트 시도할 때 각각의 세트에서 얻어지는 성공회수를 벡터로 반환.
rbinom(n=2, size=10, prob=0.4)
# 처음에는 5, 두번째는 3의 난수가 나옴. 
# size 값을 1로 설정하게 되면 베르누이 난수로 바뀌게 된다. 
# 베르누이 난수 반환값은 1(성공), 0(실패)중 하나의 값만 나온다. 

# 이항분포를 시각화 하기 위해서 10회의 시행을 하는 것으로 하고, 각 시행의 성공확률을 0.3으로
# 지정하고 이런 실험을 10,000회 관찰하는 것으로 지정했다.
binomData <- data.frame(Successes =rbinom(n=10000, size=10, prob=.3))
ggplot(binomData, aes(x=Successes)) + geom_histogram(binwidth = 1) 

binom5 <- data.frame(Successes =rbinom(n=10000, size=10, prob=.3),Size=5)
dim(binom5)
binom10 <- data.frame(Successes =rbinom(n=10000, size=10, prob=.3),Size=10)
binom1000 <- data.frame(Successes =rbinom(n=10000, size=1000, prob=.3),Size=1000)
binom10000 <- data.frame(Successes =rbinom(n=10000, size=10000, prob=.3),Size=10000)
binomAll <- rbind(binom5, binom10, binom1000,binom10000)
dim(binomAll)
ggplot(binomAll,aes(x=Successes)) + geom_histogram(bins=30) +
  facet_wrap(~Size, scales="free")

# 10번 중에서 3번 성공할 확률 
dbinom(x=3, size=10, prob=.3)
# 10번 중에서 3번 이하로만 성공할 확률(누적)
pbinom(q=3, size=10, prob=.3)
# 두 함수 모두 벡터화 되어 있다. 

# 포아송분포, 카운트 데이터에서 사용 
# 람다 값이 커질 수록 포아송 분포는 정규분포에 가까워진다. 
# 5개의 서로 다른 포상 분포에서 10000개의 랜덤 카운트를 생성한다.
pois1 <- rpois(n=10000, lambda=1)
pois2 <- rpois(n=10000, lambda=2)
pois10 <- rpois(n=10000, lambda=10)
pois20 <- rpois(n=10000, lambda = 20)
pois <- data.frame(Lambda.1=pois1, Lambda.2=pois2, Lambda.10 = pois10, Lambda.20 =pois20)
# 플롯하기 쉽도록 데이터를 녹이기 위해서 reshape2 로딩
library(reshape2)
# 데이터를 롱 폼으로 녹인다
pois <- melt(data = pois, variable.name = "Lambda", value.name = "x")
# 새로운 열 이름을 정돈하기 위해서 stringr 패키지 로딩 
library(stringr)

pois$Lambda <- as.factor(as.numeric(str_extract(string=pois$Lambda,pattern = "\\d+")))
head(pois)

ggplot(pois, aes(x=x)) + geom_histogram(binwidth= 1) +
  facet_wrap(~Lambda)
