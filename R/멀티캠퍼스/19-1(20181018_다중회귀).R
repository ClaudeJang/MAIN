df <- read.csv("example_binary.csv")
View(df)
head(df)
summary(df)

# 표준편차 한 번에 구하기
sapply(df, sd) 
xtabs(~ admit + rank, data = df)
df
str(df)  # rank is not factor. rank will be changed. 
df$rank <- factor(df$rank)
str(df)
# 1 ~0 ,0.5를 기준으로. 
myModel <- glm(admit ~ gre + gpa + rank,
               data = df, family = "binomial") # 정규분포 형식으로 다항회귀식  
myModel # AIC : 임계치, 모델적합도를  판단할 수 있음. 

summary(myModel)

# 표준 신뢰구간
confint(myModel)
mean(df$gre)
mean(df$gpa)
factor(1:4)
newDf <- with(df, data.frame(gre=mean(gre),
                             gpa=mean(gpa),
                             rank=factor(1:4)))
newDf
# RANK 2,3,4에 맞는 GRE,GPA 값을 예측하려함. 
df$rankResult <- round(predict(myModel, newdata = newDf, type="response"),3)
head(df) # 0.5보다 크면 0, 0.5보다 작으면 1 
range(df$gre)
newDf2 <- with(df, data.frame(
  gre=rep(seq(from=200,
              to=800,
              length.out = 100),
          4),
  gpa =mean(gpa),
  rank=factor(rep(1:4,each=100))))
View(newDf2)
head(newDf2, 3)
dim(newDf2)
round(predict(myModel, newdata = newDf2,
              type = "response"),3)


# eample_binary.csv
# 70% train.data
# 30% test.data 
nrow(df) # df 데이터 모수는 400개
s <- sort(sample(nrow(df),nrow(df)*0.7)) # 70% sampling
train.data <- df[s,] # 전체 데이터의 70% 샘플링의 열을 전부 가져온다. 
test.data <- df[-s,] # 30% 샘플링. 
glm_data <- glm(admit ~., data = train.data, family = "binomial")
summary(glm_data) # AIC = 340
# step 
step(glm_data)
temp <- summary(glm_data)
temp$coefficients # summary 인자값들 중 coef만 뽑아서 출력. 이것만 확인하고 싶을 때.

