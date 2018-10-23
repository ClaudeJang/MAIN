# Koweps_tpc10_2015_beta1.sav(spss)
# Koweps_Codebook.xlsx(xls)
# 1. 여성 직업 빈도 상위 10개 직업을 출력하시오. 
library(dplyr)
library(readxl)
library(foreign)
library(ggplot2)
library(magrittr)
data <- read.spss("Koweps_hpc10_2015_beta1.sav",to.data.frame = T)
str(data)
colnames(data)
data2 <- data
data2 <-
  rename(data2,
         sex = h10_g3,
         birth = h10_g4,
         marriage = h10_g10,
         religion = h10_g11,
         income = p1002_8aq1,
         code_job = h10_eco9,
         code_region = h10_reg7)
table(data2$sex)
data2$sex <- ifelse(data2$sex == 1, "male",
       ifelse(data2$sex == 3,NA,"female"))
dataCode <- read_excel("Koweps_Codebook.xlsx",col_names=T,sheet=2)
dataCode
table(is.na(dataCode$job))
data3 <- left_join(data2, dataCode, by= "code_job")
data4 <- data3 %>% 
  filter(!is.na(job) & sex =="female") %>%
  group_by(job) %>%
  summarise(n=n()) %>%
  arrange(desc(n)) %>%
  head(10)
data4   # 여성 직업 빈도 상위 10개 직업 


# 2. 연령대별 이혼율표 만드시오. 
# marriage =1, divorce = 3, NA, ratio = divorce/(marriage + divorce)
data2$ag
data2$marriage <- ifelse(data2$marriage == 1, "marriage", 
                         ifelse(data2$marriage == 3, "divorce", NA))
# 2018 - birth + 1 
data2$age <- 2018- data2$birth + 1 
data2 <- data2 %>% mutate(age1 = ifelse(age <= 30, "young",
                                        ifelse(age>60, "middle","old")))
table(data2$marriage)
table(is.na(data2$marriage)) 
data5 <- data2 %>% 
  filter(!is.na(marriage) ) %>%
  group_by(age1, marriage) %>%
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
  
           

#3. # 3. 연령대 및 종교 유무별 이혼률 표 만들기
table(data2$religion)
data2$religion <- ifelse(data2$religion == 1, "yes","no")
data2$marriage <- ifelse(data2$marriage == 1, "marriage", 
                         ifelse(data2$marriage == 3, "divorce", NA))
data6 <- data2 %>%
  filter(!is.na(data2$marriage)) %>%
  group_by(religion, marriage, age1) %>%
  summarise(n=n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
View(data6)

#4. # 4. 지역코드(code_region[1 ~ 7]) 목록을 만들고
# code_region		region
# 1				서울
# 2				수도권(인천/경기)
# 3				부산/경남/울산
# 4				대구/경북
# 5				대전/충남
# 6				강원/충북
# 7 				광주/전남/제주도 
# 위의 지역명을 추가하고, 지역별 연령대 비율표를 만드시오. 
list.region <- data.frame(code_region <- c(1:7),
                          region <- c("서울",
                                      "수도권(인천/경기)",
                                      "부산/울산/경남",
                                      "대구/경북",
                                      "대전/충남",
                                      "강원/충북",
                                      "광주/전남/제주도"))
View(list.region)
colnames(list.region) <- c("code_region","region") 

data7 <- left_join(data2,list.region, by="code_region")
data8 <- data7 %>%
  group_by(region,age1) %>%
  summarise(n=n()) %>%
  mutate(tot_group3 = sum(n)) %>%
  mutate(pct = round(n/tot_group3*100, 1))
View(data8)
