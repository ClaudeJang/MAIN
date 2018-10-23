# Vector 
  #  Integer, Numeric, Character, Logical, Date

test <- 1 
str(test)
test1 <- c(1,2,3,4,5)
str(test1)
test2 <- 1:10
View(test2)
class(test2)
?str
test2 <- seq(5,9,by=0.5)
test2
test3 <- c(1:10)
test3[c(1,3)]

test4 <- c(1,2)
names(test4) <- c("first","two")
test4
test4[c("first","two")]
# Matrices
test5 <- matrix(c(1:10),nrow =2,byrow=F,dimnames=list(c("row1","row2"),c(1,2,3,4,5) ))
test5
test5[2,c(1,4)]
test5[c(1,2),c(1,3,4)]
test5[c("row1"),]
test5[1:2,3:4]
rownames(test5) <- c("one","two")
colnames(test5) <- c()
test5
?matrix
# List
test6 <- list(1,2,3,4,5)
test6[[1]]
test6 <- list(c(1,2),test5,"test")
test6
str(test6)
test6[[1]][c(1,2)]
names(test6) <- c("one","two","three")
test6
test6$three
test6[[1]]
# Array
test7 <- c(1,2,3)
test8 <- c(4,5,6,7,8,9)
test9 <- array(c(test7,test8),dim=c(3,3,2),dimnames = list(
  c("row1","row2","row3"),
  c("col1","col2","col3"),
  c("matrix1","matrix2")))

test9
test9["row1","col1","matrix1"]
colnames(test9) <- c("row2","row3","row4")
test9
# Factor
test10 <- c("man","women","man","man")
test10 <- as.factor(test10)
test10 <- factor(test10)
test11 <- gl(3,4,labels = c("man","woman","test1")) # 3개 요인을 4번씩 반복. 
test11

# Data.frame

test12 <- data.frame(
  stuNo =c(1,2,3,4),
  stuName =c("John", "Tom", "Amy", "Kim"),
  stuAddress = c("Seoul","Seoul","Incheon","Seoul"),
  Price = c(100,200,300,400),stringsAsFactors = F
  )
test12
str(test12)
test12$stuNo <- c(2,3,4,5)
rownames(test12) <- c("row1","row2","row3","row4")
test12
test12$etc <- c("NA","NA","NA","NA")
head(test12,n=2)
library(magrittr)

test12[1,1]
test12$stuNo %>% mean(na.rm=T)
mean(max(test12$stuNo),na.rm=T)
test12$stuNo %>% max %>% mean(na.rm= T)
names(test12)
rownames(test12)
colnames(test12)
test12[test12$stuNo>2,c(1,3)]

subset(test12, select= c(1,3),
       subset=(test12$stuNo>2))
library(data.table)

testFunc <- function(a,b){
  return(a+b)
}
testFunc(1,2)

do.call("testFunc",args=list(a=1,b=2))
do.call("+",list(1,2))


