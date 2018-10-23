# 1. 월급 평균을 구하고 월급의 범위를 구하시오.(mean, range)
data <- fread("example_salary.csv",header=T,stringsAsFactors = F,na="-") 
# 특정 문자열이 - 로 되어있으니까, na 옵션을 통해 전부 확인해서 바꿔준다. 
names(data) <- c("age", "salary_month","salary_bonus", "hours","NumofWorkers","careers","sex")
View(data)
str(data)
as.numeric(data$salary_month)
mean(data$salary_month,na.rm=T) # 월급의 평균
range(data$salary_month,na.rm=T) # 월급의 범위

# 2. 1117605원에서 4064286원까지 범위에서 어떤 연령대, 성별, 경력의 평균값은? 
which(data$salary_month == 1117605)
which(data$salary_month == 4064286)
data[60:48,]

# 3. 성별로 평균월급을 구하시오.
aggregate(salary_month ~ sex, data, mean)

# OR 

tapply(data$salary_month, data$sex, mean, na.rm=T)

# 4. 경력별 평균월급을 구하시오.
aggregate(salary_month ~ careers, data, mean)
# OR 
tapply(data$salary_month, data$careers, mean, na.rm=T)

# 5. 가장 적은 월급을 받은 집단은?
aggregate(salary_month ~ sex + careers, data, range)
# OR 
tapply(data$salary_month, data$careers, range, na.rm=T)
data[which(data$salary_month == 1172399),] # 인덱스 번호로 찾아서 추출, which함수 사용.  



# data sorting  
data10 <- c(20,1,7,3,11)
data2 <- c(20,11,33,50,47)
sort(data10, decreasing = T)
order(data10)
order(data2)
order(data2, decreasing = T)
class(iris)
str(iris)
iris[order(iris$Sepal.Length),]
iris[order(iris$Sepal.Length,decreasing= T),]
iris[order(iris$Sepal.Length,iris$Petal.Length),]
print(mean(iris$Sepal.Length))
print(mean(iris$Petal.Length))

# iris 계속 쓰는 게 귀찮으면
with(iris,{
     print(mean(Sepal.Length))
     print(mean(Petal.Length))
}) # with를 써서 고정한 후에 뒤에 필드명만 쓰면 됨. 한번만 선언할 수 있어서 편함. 

x <- data.frame(val=c(1,2,3,4,5))
within(x, {
  val <- c(1,2,3,4,5)
}) # 데이터 수정할 때 사용. 


# MySQL , R in SQL 
# 설치 및 패키지 불러오기. # R의 라이브러리 중 하나. 데이터베이스 연동해서 쓸 때 편함. 
install.packages("sqldf")
library(sqldf)
# sql 구문을 사용해서 데이터 불러올 수 있음. 
# 다른 컴퓨터에 저장된 내용을 불러와서 내 컴퓨터에서 확인 가능. 
df <- sqldf('SELECT * FROM Orange')
class(df) 

# R studio 설정_RMYSQL 설치
install.packages("RMySQL",type = "source")
library(RMySQL)
con <- dbConnect(MySQL(),
                 user="user1",
                 password="1234",
                 dbname="employees",
                 host="70.12.115.58") # MySQL 접속 
con1 <- dbConnect(MySQL(),
                  user="user1",
                  password="1234",
                  dbname="employees",
                  host="70.12.115.57")
dbListTables(con) 
df <- dbGetQuery(con, "select * from employees") 
# DB연결해서 salaries에서 데이터를 가지고 온다. + departments에서 dept_no가 d009인것 조회 
library(data.table)
df2 <- data.table(df)
class(df2)
df2[emp_no > 10003,,]
library(sqldf)
sqldf("select * from df2") 


# example_exam 예제  
library(dplyr)
data11 <- read.csv("example_exam.csv", stringsAsFactors = T) # factor로 안 됨. 
str(data)  # 데이터 항목 보기 
View(data)
data %>% filter(class == 1) # class가 1인 데이터만 추출, 파이프라인 사용 
data %>% filter(class == 2)
data %>% filter(class != 1)

# filter(data, class == 1)
r <- data %>% filter(math > 50)
str(r)
data %>% filter(class == 1 & math >= 50) # AND
data %>% filter(english < 90 | science < 50) # OR 
data %>% filter(class %in% c(1,3,5))
data1 <- data%>% filter(class==1) # 1반 데이터만 추출
mean(data1$math) # 1반의 수학성적의 평균 도출 

mtcars
install.packages("ggplot2")
library(ggplot2)
library(magrittr)
library(ddply)
mpg
View(mpg) 
str(mpg)
# 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. 
# displ이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의 hwy가 평균적으로 높은 것은? 
displ_4 <- mpg %>% filter(displ <= 4)
displ_5 <- mpg %>% filter(displ > 5)
mean(displ_4$hwy) # displ_4이하 자동차의 고속도로연비가 상대적으로 더 높다. 
displ_5$hwy %>% mean

# 2. 자동차 제조회사에 따라 도시 연비가 다른지 알아보려고 합니다. 
# "audi"와 "toyota" 중 어느 자동차 제조회사의 cty(도시 연비)가 평균적으로 더 높은지? 
info_audi <- mpg %>% filter(manufacturer == "audi")
info_toyota <- mpg %>% filter(manufacturer == "toyota")
mean_audi<- mean(info_audi$cty)
mean_toyota <- mean(info_toyota$cty) # toyota 연비가 18.529..로 평균적으로 더 높음. 

# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 
# 이 회사들의 자동차를 추출한뒤 hwy의 전체 평균은? 

info_chev <- mpg %>% filter(manufacturer == "chevrolet")
info_ford <- mpg %>% filter(manufacturer == "ford")
info_honda <- mpg %>% filter(manufacturer == "honda")
mean_hwy_chev <- info_chev$hwy %>% mean
mean_hwy_ford <- info_ford$hwy %>% mean
mean_hwy_honda <- info_honda$hwy %>% mean

# df2 <- filter(manufacturer %in% c('chevrolet','ford','honda')) %>% head(5)로 사용 가능(상위 5개)
# df2
# mean(df2$hwy)
total_mean <- mean(c(mean_hwy_chev,mean_hwy_ford,mean_hwy_honda))
total_mean


# p.215, 216 
data11
str(data11)
data11 %>% select(-english,math, class) %>%head(3) # english 제외 
data11 %>% select(-english,-math) %>%head(3) # english, math 제외
data11 %>% 
  filter(class== 1) %>% 
  select(-math) %>% 
  head(3) # 1반의 math를 제외한 값을 앞 3개만 출력 

# 정렬방식 arrange 
data11 %>% arrange(math) # 오름차순 정렬(디폴트 값) 
data11 %>% arrange(desc(math), english) # 내림차순 정렬 

# 상용차 mpg 데이터 이용 
head(mpg,3)
mpg %>% 
  filter(manufacturer == "audi") %>%
  arrange(desc(hwy)) %>%
  select(manufacturer, hwy) %>%
  head(5) 
# mpg에서 제조사 아우디 차량을 필터링 하고, 그 중 제조사와 고속도로 연비항목만 추출, 
# 단, 고속도로 연비항목은 내림차순으로 출력. 
# 깔때기처럼 떨어지는 구조. 

data11 %>%
  mutate(total = math + english + science) %>%
  head

