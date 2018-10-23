# dplyr, RMysql
install.packages("RMySQL", type = "source")
library(RMySQL)
library(dplyr)

con <- dbConnect(
  MySQL(),      # 데이터베이스 드라이버(RPgSQL, ROracle, MySQL 등)
  user="root",     # 사용자 이름
  password="1234", # 비밀번호
  dbname="employees",   # 데이터베이스 이름
  host="127.0.0.1"      # 호스트
)
dbListTables(con) # 데이터베이스 접속 

# employees, dept_emp, 

# 1. 부서 중 development 부서의 인원을 출력하시오. 
df <- dbGetQuery(con,"select * from employees") #df0
df2 <- dbGetQuery(con,"select * from dept_emp") #df1
df3 <- dbGetQuery(con,"select * from departments") # df3
df4 <- dbGetQuery(con,"select * from salaries") #df3
colnames(df3)
colnames(df2)
colnames(df)
colnames(df4)
# d005 = development
left_join(df,df2,by="emp_no") %>% filter(dept_no=="d005") %>% head(3)


# 2. employees 부서별 인원을 출력하시오. 
df2 %>% group_by(dept_no) %>% summarise(count=n())
# OR
df3 %>% left_join(df2, by="dept_no") %>% 
  left_join(df, by="emp_no") %>% 
  group_by(dept_name) %>% 
  summarise(count=n()) %>% 
  arrange(desc(count)) 
# OR
df3 %>% left_join(df2, by="dept_no") %>% 
  left_join(df, by="emp_no") %>% 
  group_by(dept_name) %>% 
  summarise(count=n()) %>% 
  arrange(desc(count)) %>% 
  filter(dept_name == 'Sales') 


# 3. employees 중에서 월급이 가장 높은 상위 5명을 출력하시오. 

sol2<-df4 %>% arrange(desc(salary)) %>% head(5)
df %>% left_join(df4,by="emp_no") %>%
  group_by(emp_no) %>%
  summarise(salary_mean=mean(salary)) %>%
  arrange(desc(salary_mean)) %>%
  head(5)

# 4. 부서별로 인원을 출력하고 가장 인원이 많은 부서를 출력하시오. 
df %>% left_join(df4, by="emp_no") %>% select(emp_no,salary) %>% head(10)


