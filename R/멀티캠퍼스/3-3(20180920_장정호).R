# 제어문 구조 
# conditional syntax
# if,if else 구조 

x <- 4
if(x>10){
  print("x is large number")
} else if(x>5){
  print("x is small number")
} else{
  print("나도 모른다")
}  

if(TRUE){
  print("TRUE")
} else{
  print("FALSE")
}

# switch 구문- 간혹 씀. 
x1 <- 'a'
switch(x1, 
       'a'='first',
       'b'='two')
x2

# ifelse , T/F를 수행할 수 있는 조건식
x2 <- ifelse(1==1,"yes","no")
x2

totest <- c(1,1,0,1,0,1)
ifelse(totest == 1, "Yes","No")

# for, while
for(i in 1:10){
  print(i)
}

j <- 100 # 초기 값 설정 
while(j < 1000){
  print(j)
  j <- j+1
} # TRUE가 될 때까지 j값이 1씩 증가.  
# 초기값 넣어주는 차이가 for와 while 구문 차이 

print("end")

# next는 해당값 나올 시 다음 단계로 스킵
# break는 해당값 나오면 작업 중단하고 빠져나오게 됨 .

for(i in 1:100){
  if(i==50){
    break;
  }
  print(i)
}

for(i in 1:100){
  if(i==50){
    next;
  }
  print(i)
}
# 구구단 
# 2단 
for(i in 1:9){
  print(i*2)
}

# 전체 구구단 다 나오게 
for(x1 in 2:9){
    for(y1 in 1:9){
      if((x1*y1)==20){
        break;
      }
      print(paste(x1,"*",y1,"=",x1*y1))
    }
}

# function - 함수를 만들어서 호출
my.function <- function(msg){
  print(msg)
}

my.function('Hello,R')
my.function2 <- function(val){
  if(val>=20){
    print("val >= 20")
  }else{
    print("val < 20")
  }
}
my.function2(10)
my.add <- function(a,b){
  return (a+b)
} # print는 화면에 출력, return은 반환
myVal1 <- my.add(1,2)
myVal1

sprintf("%s %s Hello ",'R','pyhton') # %s에 뒤에 문구 치환. 
sprintf("Hello %s", 'R')
my.add2(1,2)
my.add2(1,2,3)
my.add2(1,3)
my.add2(1)
my.add2 <- function(a, b = 0,c = 0){
  return(a+b+c)
} # c= 0 은 기본 값, 만약 c에 값이 없으면 자동 0으로 인식. 

my.add3 <- function(a,b){
  val1 <- my.add2(a,b)
  return(val1)
}
my.add3(1,2) # 함수에 함수를 호출할 수 있음. 

ls() # 전체 로드된 변수들 체크하는 용도
rm(list=ls()) # 전체 리스트 초기화 

x3 <- 10
x4 <- 20 # 변수 할당
my.function3 <- function(){
  x5 <- 30
  sprintf("Test values %s %s %s", x3, x4, x5)
} 
print(x5) # x5는 함수 내에서만 적용이 되는 것. (지역 변수)
# x3, x4 변수를 sprintf 내에 집어 넣음. 안이든 밖이든 가능. (전역 변수)
my.function3() 

my.function4 <- function(){
  x6 <- 10
  print(x6)
}
my.function4() # x6은 지역변수, 함수 내에서만. 
x6


# plot 
x <- c(1,3,5,7,9)
y <- c(2,2,4,7,1)
plot(x,y,type = "S",
     col="red",
     xlab = "x axis",
     ylab = "y axis",
     main = "test graphics") # x,y를 제외한 나머지 값들은 옵션. 
barplot(y)
?plot

library(ggplot2)
str(mtcars)
mtcars[,c('wt','mpg')]
plot(x=mtcars$wt, 
     y= mtcars$mpg, 
     xlab ='Weight', ylab= 'Mile per Gallon', 
     col="red", main = "correlation",xlim=c(2.5,5),ylim=c(15,30)) 
# lim : 특정 부분만 확대해서 볼 수 있다. 

