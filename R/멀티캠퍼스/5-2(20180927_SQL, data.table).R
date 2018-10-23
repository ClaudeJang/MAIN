# SQL 구문  
# select * from test
# select * from test where a ="1"
# select * from test group by a 

library(data.table)
data <- fread("data.table.data.csv")
str(DT)
# oracle, Mysql, sql server, 관계형 데이터베이스 =SQL 
data[,sum(col2), by=col1] 
# where, select, group by - where에서 찾고, select를 통해 찾고 group by를 통해 필터링. 

# where col1 =='cat'
col1  col2  
cat    1
cat    2
cat    1
dog    2
cat    1
# cat 5 , dog 2 

data2 <- data.table(
  c('cat','cat','cat','dog','cat'),
  c(1,2,1,2,1)
)
str(data2)
colnames(data2) <- c('col1','col2')
rownames(data2) <- c('row1','row2','row3','row4','row5')
data2[,sum(col2),by=col1] #where = data, select, col2의 합계, group by는 col1로 
data2[col1 =='cat',mean(col2), by=col1]
# prop.table <- 항목 컬럼에 대한 비율 알려주는 함수 
subset(data2, select= c(1,2)) # subset으로 쿼리구문 쓰기에는 힘듦. 


# 행 결합, 열 결합 

# cbind, column 결합 
# rbind, row 결합 

data2 <- rbind(c(1,2,3),c(5,6,7))
data2 
data3 <- cbind(c(1,2,3),c(5,6,7))
data3

# apply 
sum(1:10)
data4 <- matrix(1:9, ncol= 3)
data4 
apply(data4, 1, sum) # 행(1)을 기준으로 data4의 합을 구한다. 
apply(data4, 1, mean) # apply(data, 1 or 2, function) 1 -> by row, 2 -> by col
myfunc <- function(a){a*a}
apply(data4, 1, myfunc )

data(iris)
str(iris)
colSums(iris[,1:4])

# lapply, sapply 
lapply(iris[,1:4],sum) # lapply(data, func) 
sapply(iris[,1:4],sum) # lapply는 리스트 반환, sapply는 벡터 반환 
# unlist # 리스트가 까다로울 때 벡터로 바꾸는 기능.  
data5 <- list(1,2,3,4) 
data6 <- unlist(data5)
data6
# tapply 
tapply(1:10, rep(1,10), sum) # tapply(data, index, func)
tapply(iris$Sepal.Length, iris$Species, sum)
# mapply 
mapply(rnorm,
       c(1,2,3),
       c(0,10,100),
       c(1,1,1))

# 그룹 집계 계산 
aggregate(iris$Sepal.Width ~ iris$Species, iris, mean) 
tapply(iris$Sepal.Width, iris$Species, mean) # aggregate와 같은 값인데 행렬형태로 나옴. 
