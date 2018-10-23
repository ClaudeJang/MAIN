myTest <- "안녕하세요."
x1 <- 1 
x2 <- "하이, 즐거운 하루되세요."
x3 <- FALSE
x4 <- 2  
# a<- b <- 7, a와 b 모두 상수 7이 할당된다. 
a <- b <- 10
a
b
assign("an",11) # 이거 보다는 화살표가 더 편하다

# 변수명 설정
a
# %/%는 몫을 의미함. 13%/%4 = 3 
rm(a.test) # rm()은 변수 제거하는 함수
class(x1)
class(x2)
class(x3)
class(x4) # complex는 복소수, 복합 타입을 의미함. 
is.character(x3)
3==4 # ==는 같다. 
3!=4 # !=는 다르다. 쓰는 이유는 논리식을 만들 때.
12L
class(12L)
12L * 3

x6 <- "test"
x6
x7 <- "test"
x7
nchar("test")
nchar("testtest")

date1 <- as.Date("2018-09-18")
date1
class(date1)
as.numeric(date1)
as.Date(date1) # 날짜를 스트링타입으로 바꿔주는 것. 
# TRUE는 1 FALSE 0, 논리형 연산할 때 사용 

x <- 30L
if(is.integer(x)){
  print("x is integer")
} else{
  print("x is not integer")
} #interpreter 방식  
 # is.integer 는 T/F체크 방식. 


# 특수 형태 데이터  
# 1. NULL - 값이 존재하지 않는 객체로 지정할 때 사용 
# 2. NA(Not Available) - 결측치, 값은 있지만 쓸 수 없는 값. Missing Value
# (남&여 - 1&2인데, 3의 값을 집어넣었을 때)
# 3. NaN(Not available Number) - 수학적으로 계산할 수 없는 값. 

mode(x) # is.numeric과 유사하지만 클래스 역할을 함. 

# array, vector, matrix
x8 <- c(1,2,3,4)
is.numeric(c(1,2,3,4))
mode(x8)
x9 <- c("자장면", "탕수육","짬뽕")
mode(x9)
is.character(x9)
class(x9)
x10 <- c(1, "짜장면", FALSE, "짬뽕")
x10 # 모두 문자로 바뀌어서 나옴. 벡터로 묶으면 문자로 변경
mode(x10) # 여러 가지 유형으로 묶어도 하나로 통일되서 나옴.
x11 <- as.numeric(x10)
x11 # 나머지 문자와 논리값이 결측치로 바뀐 것. is.numeric으로 논리값 판단할 때
# 벡터 자체는 같은 타입으로 통일 된다. 
x12 <- as.character(x10)
x12
x13 <- 1 # 싱글 벡터 형태. c()로 여러개 스칼라를 묶어서 벡터로 만들 수도 있음. 
length(x10) # 벡터의 사이즈를(스칼라 개수) 반환.
x14 <- c(1,2,3,4)
x15 <- x14^2
x15 # 벡터 자체에 각각 2를 곱함. 벡터 연산

x16 <-c(1,2,3,4)
x17 <-c(2,3,4,5)
x18 <- x16 + x17
x18
x19 <- 1:10
x19
x20 <- 1:5
x21 <- x19 + x20
x21 # 서로 length가 달라도 계산 시에 짧은 length 벡터가 첫 스칼라 부터 다시 더해줌.

x21 <= 10
x22 <- x21 <= 10 # 10보다 작거나 같은 지 연산값으로 나타낸다. 
x22
 
x23 <- c('apple', 'strawberry', FALSE, 10)
x23
x23[c(1,2)] # 벡터에서 첫번째, 두번째를 뽑아 낸 것. 
x23[c(2,4)]
x23[c(TRUE,FALSE,TRUE,FALSE)] # T/F를 통해서 뽑을 수도 있다. 
x23[c(-2)] # 두번째 값을 제외한 값을 준다.  
x24 <- as.numeric(x23)
x24

x23 <- 10L
class(x23)
x24 <- as.numeric(x23) # 형 변화, 타입을 변화시킨다. 
class(x24)
x23
x24
x25 <- "1"
class(x25)
x26 <- "2"
x27 <- as.integer(x25)
x28 <- as.integer(x26)
class(x27)
class(x28)
x27 + x28 

x27 <- c(0,2,4)
x27[c(1)]
x27[c(T,F,T)]
x27[c(1,0,0)] # T,F,F와 같음. 
x27[1:2]

x28 <- 1:5
x29 <- 5:1
x30 <- -3.3:5 # 시작값에서 1씩 증가. 
x30
x31 <- 5:-3.3 # 시작값에서 1씩 감소 
x32 <- c(One = "a", Two="b", Three="c")
x32 # data.frame 형식과 유사. 
data.frame(x32) 
w <- 1:3 # 벡터 w 생성 
names(w) <- c("a", "b", "c") # 요소에 이름을 부여 
names(w)
w
x34 <- c('a'=1, 'b'=2, 'c'=3)
x34
x35 <- 2:4
x36 <- seq(from =1, to=5, by= 1)
x36
x37 <- seq(from =1, to=10, by= 2)
x38 <- seq(from =1, to=5, by= 0.5)
x39 <- rep(c("a","b"),times=c(10,5)) # a를 10번 반복, b를 5번 반복 
# 벡터를 넣어서 각각의 벡터에 일치된 값을 수치로 반복
x39 
