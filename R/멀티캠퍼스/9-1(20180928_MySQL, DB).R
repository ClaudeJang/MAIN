# RMySQL::dbConnect(
#   drv,      # 데이터베이스 드라이버(RPgSQL, ROracle, MySQL 등)
#   user,     # 사용자 이름
#   password, # 비밀번호
#   dbname,   # 데이터베이스 이름
#   host      # 호스트
 )

# RMySQL::dbListTables(
#   conn # 데이터베이스 접속
# )
# 
# RMySQL::dbGetQuery(
#   conn, # 데이터베이스 접속
#   statement # 수행할 질의
# )

# 예)
# > con <- dbConnect(MySQL(), user="rprogramming", password="<비밀번호>", dbname="rprogramming", host="127.0.0.1")
# > dbListTables(con)
# > dbGetQuery(con, "select * from score");

# RStuio에서 설정 
install.packages("RMySQL", type = "source")
library(RMySQL)
 
# RMySQL:: dbconnect
con <- dbConnect(
   MySQL(),      # 데이터베이스 드라이버(RPgSQL, ROracle, MySQL 등)
   user="user1",     # 사용자 이름
   password="1234", # 비밀번호
   dbname="employees",   # 데이터베이스 이름
   host="127.0.0.1"      # 호스트
 )
 
# RMySQL::dbListTables(

dbListTables(con) # 데이터베이스 접속

 
# RMySQL::dbGetQuery(
#   conn, # 데이터베이스 접속
#   statement # 수행할 질의
# )
df <- dbGetQuery(con,"select * from employees")
df2 <- dbGetQuery(con,"select * from dept_emp")
df3 <- dbGetQuery(con, "select * from departments")
df4 <- dbGetQuery(con, "select * from salaries")

colnames(df) 
# emp_no와 employee가 서로 관계
colnames(df2)
colnames(df3)
colnames(df4)
head(df)
str(df)
View(df)
library(magrittr) # 파이프라인 식 사용 
library(dplyr)
df %>% select(emp_no,gender) %>%
  filter(gender == 'M') 
# emp_no 출력 
df %>% group_by(gender) %>%
  summarise(gender_count = n())
# join은 dplyr 패키지 함수 
ljdf <- left_join(df, df2, by="emp_no") # df- emp_no기준으로 레프트 조인 
head(ljdf,2) 
rjdf <- right_join(df,df2,by="emp_no") 
head(rjdf)
ijdf <- inner_join(df, df2, by="emp_no")
head(ijdf)
sjdf <- semi_join(df, df2, by="emp_no")
head(sjdf)
ajdf <- anti_join(df, df2, by="emp_no")
head(ajdf)
colnames(df)
colnames(df2)

df %>% left_join(df2,by="emp_no") %>%
  left_join(df3,by="dept_no") %>%
  select(emp_no,first_name,gender,dept_name) %>%
  head(3) # 3개를 조인해서 테이블로 출력 

# 2개의 데이터 프레임을 merge, 기본 R 함수 
# full_join, cross_join


# 예)
# > con <- dbConnect(
#MySQL(), 
#user="rprogramming", 
#password="<비밀번호>", 
#dbname="rprogramming", 
#host="127.0.0.1"
#)
# > dbListTables(con)
# > dbGetQuery(con, "select * from score");