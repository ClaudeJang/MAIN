z <- c(1,2,NA,8,3,NA,3)
is.na(z) # 결측치 찾는 함수 
mean(z,na.rm=T) # 결측치 제외 옵션(T) 설정

MyFunc <- function(a,b){
  print(a+b)
} 
# MyFunc 호출하면 function 함수를 실행하게 되고, 
# 그 밑 서브함수 print(a+b)를 실행하여 값을 반환
MyFunc(1,2)
# MyFunc(1,2) <- function(1,2) <- print(1+2)
myData <- c(1:4)
mean(myData) # mean(c(1:4)) 
library(magrittr)
z %>% is.na %>% sum # pipe(), 연속적으로 함수를 적용할 수 있다. 
myData %>% mean

my.function <- function(a){
  print(a+2)
}
my.function(3)

x <- 3
x %>% my.function # 파이프는 함수형언어의 특징 
