# factor 만들기 

myData2 <- c('Male','Male','Female','Male') # 범주형 데이터 
myData2
is.factor(myData2)
myData2_factors <- factor(myData2)
myData2_factors

myData3_factors <- factor(myData2, levels = c('Male','Female','Nothing'))
myData3_factors

myData4 <- gl(3,4,labels = c('Male','Female','Nothing')) 
#gl : generate 함수 , 발생시키는 것. 3을 4번 발생
myData4

gender <- c('m', 'f', 'f', 'm', 'f', 'f')
gender_factor <- factor(gender)
gender_factor2 <- factor(gender, levels=c('m', 'f'), labels=c("남자", "여자"))
gender_factor2

# matrix 행렬(matrix)은 데이터의 형태가 2차원으로 행(row)과 열(column)로 구성
myMatrix <- matrix(c(3:14),nrow=4, byrow = T) #열 우선
myMatrix
myMatrix2 <- matrix(c(3:14), nrow=4, byrow = F) # 행 우선 
myMatrix2
nrow(myMatrix)
ncol(myMatrix)
dim(myMatrix)

# dimnames : rownames와 colnames 정보를 넣을 수 있다. 시각화(그래프)할 때 각각의 이름을 넣음. 
# 각 요소를 뽑을 때 지정된 이름으로 쉽게 뽑을 수 있다. 

myMatrix3 <- matrix(c(3:14),nrow=4, byrow = T, dimnames = list(rownames1,colnames1))
# dimnames에 list 함수로 벡터의 집합을 원소로 둘 수 있음. (여러 타입의 원소를 한번에 넣을 수 있음)
rownames1 <- c('row1','row2','row3','row4')
colnames1 <- c('col1','col2','col3') 
myMatrix3 

letters[1:10] # 대소문자 알파벳이 들어있음. 순서로 10번째까지 반환. 
LETTERS[1:10]

myMatrix3[1,3] # row1, col3의 값 반환

myMatrix3[4,2]      
myMatrix3[,3] # col3만 추출. 
myMatrix3[3,] # 매우 중요한 부분. row3만 추출
myMatrix3[,]

myMatrix4 <- matrix(c(1:4),nrow=2)
myMatrix4 
myMatrix5 <- matrix(c(5:8),nrow=2)
myMatrix6 <- myMatrix5 + myMatrix5
myMatrix6 

# array : 다차원 벡터. 잘 안 씀.  - data.frame으로 대부분 사용 
myVector1 <- c(1,2,3)
myVector2 <- c(1:6)
myArray <- array(c(myVector1,myVector2), dim = c(3,3,2),dimnames = list(row.names1,column.names1,matrix.name1))
myArray # dim(row, col, matrix), dimnames = list() - 열, 행, 차원 순 

column.names1 <- c('col1','col2','col3')
row.names1 <- c('row1','row2','row3')
matrix.name1 <- c('matrix1','matrix2')

myList <- list('이순신', "yellow", c(2,3,2),TRUE,13.3)
myList  
cars%>%is.data.frame
newlist<-list(cars, 1:10)
myList1 <- list(1,2,3)
myList1
names(newlist) <- c("data.frame","vector")
newlist

myList2 <- list(c(1,2,3),matrix(c(1:6),nrow=2))
myList2
myList2[1]
myList2[2]
newlist$data.frame 
# 'newlist'에서 'data.frame'으로 지정된 항목을 추출. 

myList1 <- list(1,2,3)
myList2 <- list(2,3,4)
myList3 <- c(myList1, myList2)
myList3
myVector1 <- c(1,2,3)
myVector2 <- c(2,3,4)
myVector3 <- c(myVector1,myVector2)
myVector3
#list to vector
myVector4 <- unlist(myList1)
myList1
myVector4

emp.data <- data.frame(
  emp.id = c(1:3),emp.name = c("이순신","강감찬","권율"),
  salary = c(1000,2000,3000),stringsAsFactors = FALSE,
  start_date = as.Date(c("2018-09-19","2018-09-19","2018-09-19"))
) 
# stringAsFactors : 데이터의 유형이 문자형인 경우는 데이터 프레임을 생성할 때 
# 기본적으로 요인(factor)으로 변경되며, 이것을 원하지 않을 경우 FALSE를 지정하면 
# 문자형 그대로 유지됨
emp.data 
str(emp.data) # 데이터의 구조를 알 수 있음. 
summary(emp.data) 
nrow(emp.data)
ncol(emp.data)
dim(emp.data)
names(emp.data)
names(emp.data)[1:3]
emp.data$emp.id
emp.data$emp.name
emp.data$salary
class(emp.data$emp.id)

emp.data2 <- data.frame(emp.data$emp.id,emp.data$emp.name)
emp.data2
emp.data[1:2,] #1번과 2번 행에 대해서만 호출
emp.data2[1:2,1:2] # 1-2행, 1-2열만 호출
emp.data[c(1),c(1,2)] # (1,3)는 1,3만 가져오고 1:3은 1,2,3 다 가지고 오는 것.
emp.data$dept <- c('구매팀','생산팀','CEO') # 컬럼 추가 .$ 표시 뒤에 원하는 항목을 벡터로 삽입 가능.
emp.data
class(emp.data)
emp.data[,c("emp.name","dept")] # 각 열 이름으로도 호출 가능. 


# R로 데이터 읽어오기 
# xlsx <-저장공간 제한 
# csv <- 텍스트 파일로 저장공간 제한 X 
# import 가져오기, export 내보내기  
data <- read.csv("input.csv",header = T) # input.csv파일 불러온 후 data로 지정
data # header - 파일 내 열의 이름 
class(data)
max(data$salary)

# 최대 봉급을 받은 사람의 세부 정보(subset)를 알고 싶다면
subset(data,salary == max(data$salary))
subset(data, dept == "IT")
subset(data, salary > 600 & dept =="IT")
# 봉급이 600달러가 넘으면서 부서가 IT인 사람 조회 

book_data <- read.csv("TomatoFirst.csv",header = T)
book_data
head(book_data)

library(readr) # 텍스트 파일을 읽는데 사용하는 일련의 함수들을 제공한다. 
tomato1 <- read.delim("TomatoFirst.csv",sep = ',')
tomato1
?read.delim 
### 오류, 그냥 read.delim 함수는 csv 파일 중 탭으로 나눈 파일을 읽을 때 편하다. 

flights <- read.csv("flights.csv",header=T)
airports <- read.csv("airports.csv")
airlines <- read.csv("airlines.csv")
str(airports)
unique(flights$AIRLINE)
table(flights$YEAR, flights$MONTH) 

# ODBC : database connection, 표준 인터페이스 
# Spark : 스파크 연결 


# 웹 데이터 스크래핑
install.packages("rvest")
library(rvest)

data_html <- read_html("https://www.jaredlander.com/data/ribalta.html")
data_html # 전체 다 읽지만 console에는 잘려서 나온다. 여기에서 걸러서 추출
data2<-data_html %>% html_nodes('ul') %>% html_nodes('span') # 노드 항목에서 span 태그만 뽑아내고 싶은 것. 
data3 <- data_html %>% html_nodes('.street')
data3
data4 <- data_html %>% html_nodes('.street') %>% html_text()
data4 # 마지막 주소만 크롤링 


