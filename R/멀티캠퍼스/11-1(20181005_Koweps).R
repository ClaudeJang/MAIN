library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)
library(magrittr)
data <- 
  read.spss(file="Koweps_hpc10_2015_beta1.sav",
            to.data.frame = T)

str(data)
colnames(data)
data2 <- data
dim(data2)
data2 <-
  rename(data2,
         sex = h10_g3,
         birth = h10_g4,
         marriage = h10_g10,
         religion = h10_g11,
         income = p1002_8aq1,
         code_job = h10_eco9,
         code_region = h10_reg7)
colnames(data2)

# 성별에 따른 월급의 차이
data2$sex
data2$income
class(data2$sex)
data2$sex
table(data2$sex)
summary(data2$sex)
data2$sex <- ifelse(data2$sex == 9,
                    NA,data2$sex)
table(is.na(data2$sex))
head(data2$sex,3)
data2$sex <- ifelse(data2$sex == 1,
                    "male", "female")
table(data2$sex)
qplot(data2$sex)
income <- data2 %>% group_by(sex) %>%
  summarise(mean_income=mean(income,na.rm=T))

#   sex          mean_income
#1  male
#2 female     
data2$birth
income
ggplot(data=income,aes(x=sex, y=mean_income)) + geom_col()
 

# 나이 & 월급 관계 그래프 
summary(data2$birth)
table(data2$birth)
data2$age <- 2018- data2$birth + 1
summary(data2$age)
# 2018 - birth + 1 
qplot(data2$age)
age_income <- data2 %>%
  filter(!is.na(income)) %>%
  group_by(age) %>% 
  summarise(age_mean = mean(income))

ggplot(data = age_income, aes(x= age, y= age_mean)) + geom_line()
# 나이별 평균

data2 <- data2 %>% mutate(age1 = ifelse(
  age < 26, 'young',
  ifelse(age <=31,'middle','old')
  ))
age_income1 <- data2 %>%
  filter(!is.na(income)) %>%
  group_by(age1) %>% 
  summarise(age_mean1 = mean(income))
table(data2$age1)
qplot(data2$age1)
ggplot(data=age_income1, aes(x=age1,y=age_mean1)) + geom_col()

age_income2 <- data2 %>%
  filter(!is.na(income)) %>%
  group_by(age1,sex) %>% 
  summarise(age_mean2 = mean(income))
ggplot(data=age_income2, aes(x=age1, y= age_mean2,fill=sex)) + geom_col(position = "dodge")
# col(position="dodge") 하면 각 성별로 나뉘어 표시가 된다. 



      
# Koweps_Cookbook.xlsx 읽어서 
# code.job, job -> data.frame
dataCode <- read_excel("Koweps_Codebook.xlsx",col_names=T,sheet=2)
data2
table(is.na(data2$code_job))
dataCode
data3 <- left_join(data2, dataCode, by = "code_job")
data3$code_job
data3$job
data4 <- data3 %>% 
  filter(!is.na(code_job)) %>%
  select(code_job,job)
View(data4)
data5 <- data3 %>% filter(!is.na(code_job) & !is.na(income)) %>%
  group_by(job) %>% summarise(job_mean = mean(income)) %>% arrange(desc(job_mean))

data6 <- data5 %>% arrange(desc(job_mean)) %>% head(10)
g6 <- ggplot(data=data6, aes(x=job,y=job_mean)) + geom_col() + coord_flip() 
# coord_filp 하면 수평으로 막대 출력 


# 남성 직업 빈도 상위 10개 직업
job_male <- data3 %>%
  filter(!is.na(job) & sex =="male") %>%
  group_by(job) %>%
  summarise(n=n()) %>%
  arrange(desc(n)) %>%
  head(10)
job_male

g <- ggplot(data= job_male, aes(x=reorder(job,n),y=n))
g1 <- g +geom_col() + coord_flip()
g1 
head(data3$religion,3)
str(data$religion)
range(data3$religion) # 1 (yes), 2(no)
data3$religion
data3$religion<- ifelse(data3$religion == 1, "yes","no")
data3$sex <- ifelse(data3$sex == 1, "male","female")
range(data3$marriage) # 1(marriage), 2(divorse)

# 종교 유무에 따른 이혼율  
data3$marriage <- ifelse(data3$marriage ==1, "marriage",
                         ifelse(data3$marriage == 3,
                                "divorce", NA))
data3$marriage
table(data3$marriage) 
table(is.na(data3$marriage))
qplot(data3$marriage)
data3 %>%
  filter(!is.na(marriage)) %>%
  group_by(religion, marriage) %>%
  summarise(n=n()) %>% #  1 = yes, 2= no
  mutate(tot=sum(n)) %>%
  mutate(pct = round(n/tot * 100,1))


