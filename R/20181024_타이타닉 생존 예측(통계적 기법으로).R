# https://statkclee.github.io/ml/ml-modeling-titanic.html
## 1. 데이터 준비 
# Titanic : 머신러닝이 아닌, 통계적 기법으로 타이타닉 생존율 예측. 

suppressMessages(library(readr)) 
suppressMessages(library(dplyr))
# suppressMessages : 로딩 메세지를 감추기 위해 명령 사용.
getwd()
titanic.train.df <- read.csv("titanic_train.csv")
titanic.test.df <- read.csv("titanic_test.csv")
titanic <- bind_rows(titanic.train.df, titanic.test.df)
# kaggle 생존 데이터가 트레인과 테스트로 나뉘져 있는데, 
# 합쳐서 하나의 데이터셋으로 만들고 난 후 전처리 작업을 하고 
# 전통적 방식으로 예측하는 방법을 전개


## 1.2 데이터 정제
# 타이타닉 생존데이터를 불러온 다음 현황을 파악하고, 결측값에 대한 대응방안을 마련한다. 
# 예를 들어, 결측값이 너무 많은 경우 변수(Cabin) 자체를 제거한다. 
# Name, Ticket처럼 관측점마다 유일한 변수는 정보로서 의미가 없기 때문에 이것도 제거한다. 
# Age 변수는 평균을 매워넣는 것으로 하고, 
# 상대적으로 적은 결측값이 있는 관측점은 
# Embarked, Fare, Survived는 관측점을 제거하는 방식으로 정제 작업을 수행한다.
# 특히, Amelia 팩키지의 missmap 함수를 사용해서 
# 결측값 진행 작업을 바로 시각적으로 확인한다.

summary(titanic) # 현황파악 

sapply(titanic, function(x) sum(is.na(x))) 
# titanic의 결측 데이터 확인을 위해 sapply를 사용해 벡터 형식으로 반환

sapply(titanic, function(x) length(unique(x)))
# unique 함수는 기본 내장 함수, 중복데이터가 있는 지 확인.

#install.packages("Amelia")
suppressMessages(library(Amelia))
missmap(titanic, main = "결측값과 관측값")
# blue : 관측값, red : 결측값.

# 결측값을 신경 안 쓰기 위해 분석에 사용될 변수만 선정
colnames(titanic)
titanic <- titanic %>% select(survived, pclass, sex, age, sibsp, parch, fare, embarked) %>%
  mutate(age = ifelse(is.na(age), mean(age, na.rm=T), age)) %>%
  filter(!is.na(embarked)) %>%  # 결측값 2개 행 제거
  filter(!is.na(fare)) %>% # 결측값 1개 행 제거
  filter(!is.na(survived)) # 결측값 418개 행 제거 

missmap(titanic, main = "결측값과 관측값")
# 순수한 관측값만 남게 됨. 

## 1.3 예측 모형 적용 
# caret의 createDataPartition 사용해서 7 : 3으로 데이터 나눔. 
# glm <- 이항회귀모형(로지스틱). 전체 변수를 넣어서 생존 예측. 
# 변수는 어떻게? ANOVA 사용해서 변수 구별. logit.reduced.m으로 축소된 모형 개발
# 이항회귀식에서는 결정계수가 큰 의미가 없다? 
# ROCR 패키지로 포화모형과 축소모형 차이가 있는 지 ROC곡선으로 도식화 

suppressMessages(library(caret))

# 데이터 분리

train.id <- createDataPartition(titanic$survived, p =0.7)[[1]]
class(train.id)
str(titanic)
titanic.train.df <- titanic[train.id,]
titanic.test.df <- titanic[-train.id,]

# 선형회귀 적합 
logit.full.m <- glm(survived ~.,family=binomial(link='logit'), data=titanic.train.df)
summary(logit.full.m)

# 변수선택
anova(logit.full.m, test = "Chisq") 
# 표본집단 3개 이상일 때 단독으로 사용. 
# 아노바가 평균검정에서 사용될 때 검증하고자 하는 것이 표본집단의 평균차이이기 때문이다. 
# 이 때 표본집단 평균과 표본전체집단의 평균 들의 차이로 파악
# 평균간거리 편차. 

# 최적 모형 
logit.reduced.m <- glm(survived  ~ pclass+sex+age+sibsp, family=binomial(link='logit'), data=titanic.train.df)
# anova분석에서 유의한 변수들만 추려서 최적 모형을 만듬. 
summary(logit.reduced.m)

# 모형평가 
install.packages("ROCR")
suppressMessages(library(ROCR))
# 전체 모형
logit.full.pred <- predict(logit.full.m, newdata=titanic.test.df, type="response")
logit.full.pr <- prediction(logit.full.pred, titanic.test.df$survived)
logit.full.prf <- performance(logit.full.pr, measure = "tpr", x.measure = "fpr")
plot(logit.full.prf)

# ROC (Receiver Operating Charateristic Curve)
# http://pyopyo03.tistory.com/8
# TPR과 FPR을 각각 x,y축으로 놓은 그래프 
# 양분된 결과(1,0)를 예측하는 테스트의 정확도를 평가하기 위하여 
# 민감도와 특이도 사용 
# 민감도 : 1을 1이라고 예측
# 특이도 : 0을 0이라고 예측 
#TPR : 1인 값을 1로 맞게 예측한 비율 
#FPR : 0인 값을 1로 잘못 예측한 비율 
#ROC커브의 밑면적(the Area Under a ROC Curve; AUC; AUROC) 
#ROC 커브의 X,Y축은 [0,1]의 범위며, (0,0) 에서 (1,1)을 잇는 곡선 
#ROC 커브의 밑 면적이 1에 가까울수록(즉, 왼쪽 상단 꼭지점에 다가갈수록) 좋은 성능 
# 이때의 면적(AUC)은 0.5~1의 범위를 가짐(0.5면 성능이 전혀 없음. 1이면 최고의 성능) 


# 축소 모형
logit.reduced.pred <- predict(logit.reduced.m, newdata=titanic.test.df, type="response")
logit.reduced.pr <- prediction(logit.reduced.pred, titanic.test.df$survived)
logit.reduced.prf <- performance(logit.reduced.pr, measure = "tpr", x.measure = "fpr")
plot(logit.reduced.prf)

# ROC 면적
logit.reduced.auc <- performance(logit.reduced.pr, measure = "auc")
logit.reduced.auc <- logit.reduced.auc@y.values[[1]]
logit.reduced.auc


# TPR과 FPR은 서로 반비례 관계 


# ROC 면적 
logit.full.auc <- performance(logit.full.pr, measure = "auc")
logit.full.auc <- logit.full.auc@y.values[[1]]
logit.full.auc

# 3.5. ROC 면적비교

plot(logit.full.prf)
plot(logit.reduced.prf, add=TRUE, col="red")

logit.full.auc
logit.reduced.auc
# 확대모형과 축소모형의 면적 수치
# 오히려 축소모형이 좀 더 예측 수치가 높았음. 


# 변수가 많을수록 여러 모형이 존재하므로, 성능 조건을 충족하는 

# 최적의 모형을 선정한다. 
#경우의 수가 너무 많고, 성능이 비슷한 모형을 반복적으로 개발할 우려도 있고 해서, 
#기준조건(Criterion-based) 방법으로 통해 변수를 추출해 나간다. 
#즉, 가장 성능이 좋은 변수부터 선택해 나가면서 복잡성과 성능을 최적화한다. 
#가장 일반적으로 많이 사용되는 방식이 
#AIC(AkaikeInformationCriterion)
#BIC(BayesInformationCriterion)을 들 수 있다.


# 1.4 자동모형 선정방법

# 변수 선택 모형 선정 

logit.null.m <- glm(survived ~1, family=binomial(link='logit'), data=titanic.train.df)
logit.full.m <- glm(survived ~., family=binomial(link='logit'), data=titanic.train.df)

logit.bic.m <- step(logit.null.m, scope=formula(logit.full.m), direction="both", criterion="BIC", k=log(nrow(titanic.train.df)))
logit.aic.m <- step(logit.null.m, scope=formula(logit.full.m), direction="both", criterion="AIC", k=2)


myResult <- predict(logit.full.m, newdata = titanic.test.df, type= "response")


myResult2 <- ifelse(myResult > 0.5, 1, 0)
myResult2


install.packages("Metrics")
library(ROCR)
library(Metrics)
p <- prediction(myResult2, titanic.test.df$survived)
p1 <- performance(p, measure = "tpr",
                  x.measure = "fpr")
plot(p1)
