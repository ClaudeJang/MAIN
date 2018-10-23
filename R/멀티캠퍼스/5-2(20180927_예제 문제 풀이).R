# 예제(question01.txt)

coffee_data<-read.csv("example_coffee.csv",header=T,stringsAsFactors = F )
View(coffee_data)
?range
names(coffee_data)
class(coffee_data)

# 최초의 커피숍은?(운영중) -range 함수 이용 
current_coffee <- range(coffee_data$dateOflicensing,na.rm=T)
current_coffee
library(data.table)
current_coffeDT <- data.table(coffee_data)
coffee_year <- current_coffeDT[coffee_data$stateOfbusiness == '운영중',range(coffee_data$yearOfStart,na.rm=T),]
coffee_year[1]



# 해마다 오픈한 커피숍의 개수는?
storeOpen <- table(coffee_data$yearOfStart)
storeOpen
class(storeOpen)
barplot(storeOpen,main= "연도별 오픈 수치",xlab = "year", ylab = "Num")
# bar형태의 그래프로 출력하시오. 


# 년도별 영업상태를 출력하시오. 
Start1<-table(coffee_data$yearOfStart) # 개업 점포 수 테이블로 표현 
class(Start1)

n1 <- coffee_data$dateOfclosure # 폐업 점포 수 추출 
n1 
is.na(n1) # 결측치 있는 지 점검
library(dplyr) # 결측치 추출을 위한 라이브러리 설치 
n2 <-coffee_data %>% filter(!is.na(n1)) # 결측치 제외
n3 <- n2$dateOfclosure# 결측치 제외 한 값에서 폐업일자 추출
n3
class(n3)
as.character(n3) # 문자화
n4 <- substr(n3,1,4) # 문자에서 앞 4자리만 추출
class(n4)
n5 <-as.integer(n4) # 추출한 값을 integer로 바꿈
closure1<- table(n5) # 그 수치 다시 테이블화 
class(closure1)
View(closure1)
table(Start1,closure1)
barplot(closure1)
barplot(Start1)

# question02.txt 
# 5. 년도별 영업상태를 비율로 출력하시오. table() -> prop.table()
library(data.table)
DF <- fread("example_coffee.csv")
View(DF)
probability_Business <- prop.table(table(DF$stateOfbusiness,DF$yearOfStart)) * 100

?prop.table
# 6. 1997년 ~ 2014년 데이터만 저장합니다. 열데이터는 (년도, 오픈 수, 폐업 수, 오픈 비율)로 구성하시오. 

# 7. ggplot2로 geom_line과 geom_point를 사용해서 출력하시오. 


