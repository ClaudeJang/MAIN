# 중심극한정리 -> 동일한 확률분포를 가진 독립 확률 변수 n개의 평균 분포는 
# n이 적당히 크면 정규분포에 가까워 진다. 

AClass <- c(10,10,10,100)
mean(AClass)
hist(AClass, breaks=10) # 히스토그램, 구간은 10씩 10은 3명, 100은 1명. 
# sample(AClass, 2, replace = F)
data <- 
  sapply(1:20, function(i) mean(
    sample(AClass, 2, replace = F)
    ))
mean(data)
hist(data)

AClass2 <- c(rep(10,100),
             rep(50,100),
             rep(100,100))
length(AClass2)
mean(AClass2)
hist(AClass2)

# 연속확률함수는 값이 연속적이기 때문에, 하나의 점에 대한 확률은 0으로 나옴. 

data2 <- 
  sapply(1:10000, function(i) mean(
    sample(AClass2, 2, replace = F)
  ))

hist(data2)

# 30,50,80
data3 <- sapply(1:10000, function(i) mean(
    sample(AClass2, 30, replace = F)
  ))
hist(data3)

data3 <- sapply(1:10000, function(i) mean(
  sample(AClass2, 50, replace = F)
))
hist(data3)
data3 <- sapply(1:10000, function(i) mean(
  sample(AClass2, 80, replace = F)
))
hist(data3) 


# 가설 
# 모집단 -> 표본집단 가설
# 수학점수 90점, 다음 달 100점
# 귀무가설(NULL Hypothesis, H0), 영가설,       
# => 기존의 현상에 차이가 없음을 말하는 진술(차이가 없다.) 
# 대립가설(Alternative Hypothesis, H1) => 가설 검증에서 연구자의 주장에 대한 진술
# (기존의 현상에 반대되는, '차이가 있다.' )

# p-value(유의수준/확률)
# -> 귀무가설 참이라는 가정 아래 얻은 통계량이 귀무가설을 얼마나 지지하는지를 나타낸 확률, 
# 귀무가설이 참이라는 가정하에 현재와 같은 결과 이상의 극단적인 값을 얻을 확률, 이상치 확률)
# p >=0.05; 귀무가설이 극단치를 얻을 확률이 5% 이상이면 귀무가설 기각
# p <0.05 귀무가설이 극단이상치를 얻을 확률이 5% 미만이므로 귀무가설 채택. 
# 예제. 
library(ggplot2)
cars$speed
summary(lm(cars$speed ~ cars$dist)) # p-value: 1.49e-12 : 0.000000000000149 < 0.05 이므로 귀무가설 채택. 


# t-test 
# 학원에 다니기 전의 점수 
# t-test
# 학원에 다니기 전의 점수
before_study <- c(34,76,76,63,73,75,67,78,81,53,58,81,77,80,43,65,76,63,54,64,85,54,70,71,71,55,40)

# 학원을 다닌 후의 점수
after_study <- c(74,87,89,98,65,82,70,70,70,84,56,76,72,69,73,61,83,82,89,75,48,72,80,66,82,71,49)
boxplot(before_study, after_study, names = c("수강 전","수강 후"))
# 평균이 올라감. 
# 두 집단이 평균값이 다른가?
# 두 집단이 정규분포를 따른다.
# Shapiro.test(데이터벡터)
# 샘플 수가 너무 작은 경우에는 샘플만으로도 
# 모집단이 정규분포를 따른다고 인정할 수 있는 지 
# 검사가 필요함. Shapiro 검증.

shapiro_test <- c(74,87,89,98,65,82,70,70,70)
shapiro.test(shapiro_test)
# shapiro - wilk test, 0.3252 귀무가설을 기각불가 (>0.05)
# 정규분포를 따른다. 
# t.test(x,y, paired = TRUE,
# var.equal = TRUE, alternative = "two.sided")
# x => A집단
# y => B집단
# paired => 독립표본의 경우 F,T 
# var.equal => TRUE 두 집단의 분산이 같음, 분산이 같은지 확인하는 테스트(var.test)
# alternative => 양측검정 
var.test(before_study,after_study) # p value 0.5이므로 귀무가설 기각 불가. 
# 귀무가설 : 분산이 같다.
# 대립가설 : 분산이 다르다. 
# t.test(x,y,paired =T, var.equal = T, alternative = "two-sided")
# x,y: A,B 집단 벡터
# paired = TRUE, 대응표본 = 한 집단으로부터 두번 반복해서 샘플 추출
# paired = FALSE, 독립표본 = 서로 독립된 집단에서 각각 샘플 추출
# Alternative = "two.sided", 옵션1 ; A,B집단이 서로 같은지 비교함
# Alternative = "less", 옵션2 ; A집단이 B집단보다 작은지 비교 
# Alternative = "greater", 옵션3 ; A집단이 B집단보다 큰지 비교
t.test(before_study, after_study,paired=T) # p= 0.002 < 0.05보다 작음. 대립가설 채택. (데이터 확인에 불과)
# 귀무가설 : 두 집단의 평균 차이가 0이다.  
# 대립가설 : 두 집단의 평균이 다르다.(0이 아니다) -> 학원 수강 전과 수강 후의 점수차이가 있다. 

# 점수 차이가 있는 것은 확인, 수강 전 대비 수강 후의 점수가 올랐는 지 확인하고 싶다면.
t.test(before_study, after_study, paired=T, alternative = "less") # before과 after보다 작은지 비교.
# p=0.014이므로 차이가 있고, 수강 후의 점수가 더 크다.(수강 전의 집단의 평균이 더 작음을 확인)
t.test(before_study, after_study, paired=T, alternative = "greater") 
# p-value : 0.9859이므로 >0.05 보다 큼. 

# Data in two numeric vectors
women_weight <- c(38.9, 61.2, 73.3, 21.8, 63.4, 64.6, 48.4, 48.8, 48.5)
men_weight <- c(67.8, 60, 63.4, 76, 89.4, 73.3, 67.3, 61.3, 62.4) 

#1. 남자, 여자의 몸무게에 대한 BoxPlot를 출력하시오.
data <- data.frame(
  group=rep(c('Women','Man'), each=9),
  weight=c(women_weight, men_weight)
) # 두 개의 그룹을 데이터프레임 화 시킴. 

boxplot(women_weight,men_weight)

#2. 남자, 여자를 기준으로 총 명수, 평균, 분산을 출력하시오.
# 남자 명수 
length(men_weight)
# 남자 평균
mean(men_weight)
# 남자 무게 분산
var(men_weight)
# 여자 명수, 평균, 분산
length(women_weight)
mean(women_weight)
var(women_weight)
#3. var.test를 적용하고, 확인하시오.
var.test(men_weight,women_weight) # p-value = 0.1714 이므로 >0.05 보다 큼, 
# 귀무가설 : 분산에 차이가 있다. 대립가설 = 분산에 차이가 없다. (기존 분산값 차이로 알 수 있음) 
# P 값이 17%로 이상치 상위 0.05보다 들지 못하기 때문에 분산에 차이가 있다는 귀무가설을 채택하게 됨. 
# 4. unpaired two-samples t-test를 적용하고, 확인하시오.(독립적인 두개의 선택)
t.test(men_weight,women_weight,paired = F, alternative ="two.sided", var.equal = T) 
# 각각 독립 집단에서 샘플을 뽑아 두 집단이 서로 일치하는 지를 본다. 
# P값이 0.015로 0.05보다 작음. # 귀무가설은 두 집단이 서로 일치한다. 대립가설은 두 집단이 서로 다르다. 
# 귀무가설이 참일 경우에 극단적인 이상치를 가지게 되므로 (상위 1.5%), 귀무가설을 기각하게 된다.
# 즉 두 집단이 서로 다르다고 볼 수 있는 근거가 있다고 할 수 있다.
t.test(weight~group,
       data=data, var.equal = T,
       alternative = "greater")
# p = 0.006 으로 0.05 미만 상위 값이므로, 대립가설 채택, 귀무가설 기각. 
t.test(weight~group,
       data=data, var.equal = T,
       alternative = "less")
# 작은지 여부 테스트. 0.9934이므로 귀무가설 채택. '여자몸무게가 남자 몸무게보다 작다'는 귀무가설이 채택됨. 


