# %%, %/% # 거듭제곱 
# %in% 
seq(1,20,2)
rep(1:2,5) # 1,2를 5번 반복 

# list
x5 <- list("홍길동","이순신","강감찬")
x6<- list(empno ="100",empname ="이순신",empData = c("100","200"))
x6# no, name is string type, data is vector type. 
x6$empno # 각 subset에 대해서 추출가능 
x7 <- list(a=list(val=c(1,2,3)), b=list(val=c(1,2,3,4)))
x7           
x7$a$val
x7[[1]]
x7[[2]]
x7[[1]][[1]]
x8 <- list(list(c(1,2,3)),list(c(1,2,3,4),c(3,10)))
x8[1] # 1 전체 가지고 오는 것
x8[[1]] # 1 중 1항목만 가지고 오는 것.
x7[1]
x7[[1]]
x9 <- matrix(c(1:9),nrow=3,byrow=F,dimnames = list(c('item1','item2','item3'),c('co11','col2','col3'))) #3*3
x9[1,1]
x9[1,]
x9[,1]
x9[1:2,]
x9[,1:2]
x9[c(1,3),c(1,2)]
x9['item1',]
x9[c('item1','item2'),]
dim(x9)
ncol(x9)
nrow(x9)
# array 
matrix(1:12,ncol=4)
array(1:12,dim=c(3,4))
x10 <- array(1:12,dim=c(3,4,2))
x10[,,1]
# data.frame : 2차원 형태의 데이터 구조 
x11 <- data.frame(col1 = c(1:4),col2 =c(2:5))
x12 <- data.frame(empNo=c('10','20','30'),empName=c('이순신','홍길동','권율'),empAddress = c('서울','뉴욕','런던'))
str(x12)
x12$empNo
x12$empName
x12$empAddress
x12[c(1,2),c(2,3)]
x12$empNo[1]
x12$empNo
x12[-1,-c(2,3)]
x12[,c('empName','empAddress')]
# immutable : 바뀌지 않는 -> readonly, R-object 
str(x12)
head(x12) # 디폴트 6건
head(x12, n= 7) 
y1 <- c(1:93)
head(y1,n=10)
x13 <- data.frame(x=1:1000)
head(x13)
tail(x13)
colnames(x13) <- c('val')
x12
names(x12) %in% c('empNo') # x12의 각 열 이름 중에 'empNo'가 존재하는 지 논리값으로 반환
x12[,names(x12) %in% c('empNo')] # 62의 구문을 넣어서 조회 가능. 
x13 <- data.frame(c(1:10))
rownames(x13)[2] <- c('test')
colnames(x13)[1] <- c('num1')
x13
x14 <- c(1,2,3,4)
class(x14)
x15 <- matrix(x14)
class(x15)
x16 <- list(x14)
class(x16)
x17 <- data.frame(x14)
class(x17)
str(x17)
str(x16)
str(x15)
x18 <- data.frame(matrix(c(1,2,3,4),ncol=2)) # matrix를 data.frame으로 데이터컨버팅한 것. 
colnames(x18) <- c('열1','열2')
x18
x19 <- data.frame(list(c(1,2,3),c(2,3,4),c(3,4,5)))# 데이터프레임에 리스트를 넣을 때 2개의 값을 넣어야 함. 
colnames(x19) <- c('col1','col2','col3') # 데이터프레임의 열 이름을 가독성 쉽게 바꾼다. 

# 새로운 필드 추가 
x19$col4 <- c(1,2,3)
x19$col5 <- factor(c('m','f','m'),levels=c('m','f'))
str(x19)
x19[1,2] <- 10
x19[,-c(1,2)]
x19[-c(1,2),]

# 데이터 시각화 
# install.packages("ggplot2")
library(ggplot2)
class(diamonds) # 클래스 확인
str(diamonds) # 구조 확인
View(diamonds) 
View(mtcars) # 실 데이터를 화면에서 볼 수 있도록 해줌. 

head(diamonds, n=3)
head(diamonds[,"cut"],n=4)
head(diamonds[,c("cut","price")],n=4)
diamonds[,c("cut","price")]
names(diamonds)
diamonds[c(1,2,4),c("carat","table", "color")]
diamonds[,grep("^c",colnames(diamonds))]
# 변수명 중에서 e 문자로 시작하는 열들을 추출 
diamonds[,grep("e$",colnames(diamonds))]
diamonds[diamonds$cut=="Fair",]
diamonds[(diamonds$cut=="Fair")&(diamonds$price>=18000),]
# cut이 fair이고 price가 18000달러 이상인 데이터 추출
diamonds[(diamonds$cut=="Fair")|(diamonds$price>=18000),]
diamonds[(diamonds$cut=="Fair")|(diamonds$price>=18000),c(2,3)]
# 행 + 2,3열만 추출 
names(diamonds)
# diamonds[(diamonds$cut=="Fair")|(diamonds$color = "E")|(diamonds$price>=7600),c(1,2)]
head(diamonds,n=100)
print(diamonds,nrow=100)
diamonds[(diamonds$cut == 'Fair')&(diamonds$price>=18000), 'x'] = NA
#cut이 “Fair”이고 price가 18000 달러 이상이면 x값을 NA로 수정

colnames(diamonds)
diamonds$xyz.sum <- (diamonds$x + diamonds$y + diamonds$z)
diamonds$xyz.sum = NULL # xyz.sum 열 삭제 
diamonds <- diamonds[,-c(3,5)]

diamonds <- diamonds[,-c(1,2,4)] 
diamonds <- subset(diamonds, select= -c(price,x,y,z)) 
# 특정 열 이름으로 삭제하고 싶을 때 subset함수 사용해서 select argument로 삭제한다. 

diamonds[order(diamonds$carat,decreasing=TRUE),]

# 조건 1, 조건2 각각 내림차순, 오름차순 다르게 할 때. 
data2 <- data.frame(c(1,1,1,2,2,2),
                    c(3,1,2,3,1,2))
colnames(data2) <- c('col1','col2')
data2[order(data2$col1,-data2$col2,decreasing=TRUE),] # 
# 기본이 DESC, -되면 ASC로 바뀜 



