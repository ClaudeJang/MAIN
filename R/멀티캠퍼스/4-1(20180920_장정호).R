library(ggplot2)
class(diamonds) # 완전한 데이터 프래임 형식이 아님. 
df <- diamonds 
df2 <- as.data.frame(diamonds) # 완전한 데이터 프레임으로 바꿈. 
class(df2)
str(df2)
str(df)
mean(df2$price) # 데이터 프레임으로 변환한 다음에 평균 등 수치계산 가능. 
df3 <- subset(df2, 
              select =c(cut,price),
              subse(df2$price > 18000)) # select 문은 해당 항목을 선택해서 출력. 
# cut, price 항목을 제외하고, price 항목이 18000초과인 값만 df3으로 지정

df3 <- read.csv("example_studentlist.csv",encoding="ASCII")
df3
df4 <- read.csv("example_studentlist2.csv",encoding="ASCII")
df4

condi_height <- subset(df3, subset=(df3$height>170))
# select 옵션으로 원하는 column만 추출할 수 있다. 
condi_height
# 전체 데이터에서 height를 뺴고 싶을 때 
# df5 <- subset(df3, select=-height) # height만 제거 

## df3 column name 변경하기  
class(colnames(df3))
colnames(df3)[6] <- c("blood")
colnames(df3)
BMI <- (df3$weight/(df3$height)^2)*10000
# BMI라는 컬럼 추가, BMI = weight/height^2
df3_1 <- cbind(df3,BMI) # df3 데이터 프레임에 BMI 컬럼 수치 추가한다. 
df3_1

# height 165이상, weight 50 이상인 사람. 

df4 <- subset(df3_1,subset=(df3$height>=165)&(df3$weight>=50)) # 조건 2개로 연산자 사용.
df4
# raw data = df3 
df7 <- table(df3$blood,df3$sex)
class(df7)
df8 <- as.data.frame(df7)
df8
plot(df8$Freq, type='o')
## 그래프 그리기 
x <- c(21,22,23,24,25,26,98)
y <- c(30,31,32,33,34,35,30)
plot(x,y,type="l", col="red")
barplot(x,main="테스트",xlab="기온",ylab="횟수",
        names.arg = c("1","2","3","4","5","6","7"),
        col="red") # 빈도수 그래프 
# names.arg = 항목 별 이름

# table(df4$blood)
barplot(table(df4$blood),xlab= "Bloodtype",ylab = "Count",border = "red",
        col ="blue",density = 10)
 
## Titanic
Titanic
margin.table(Titanic, 1) # 1을 넣으면 1차원(클래스), 2를 넣으면 2차원(성별), 3은 나이
margin.table(Titanic, 2)
margin.table(Titanic, 3)
margin.table(Titanic, 4)
# 4는 생존자 수 , 전체 카운트를 구하려면.?
margin.table(Titanic)
barplot(margin.table(Titanic,1),xlab= "Class",ylab = "Count",border = "red",
        col ="blue",density = 10)

barplot(margin.table(Titanic,2),xlab= "Sex",ylab = "Count",border = "red",
        col ="blue",density = 10)

barplot(margin.table(Titanic,3),xlab= "Age",ylab = "Count",border = "red",
        col ="blue",density = 10)

barplot(margin.table(Titanic,4),xlab= "Are they Safe?",ylab = "Count",border = "red",
        col ="blue",density = 10)

barplot(margin.table(Titanic,1), xlab ="Class",col=c("red","green"))
legend("topleft",
       c("Not survived", "survived"),
       fill = c("red","green"))

## airquality 
airquality
class(airquality)
str(airquality)
Temp <- airquality$Temp
Temp
hist(Temp,xlab ="Temperature",
     xlim=c(50,100)) # 분포도 # x축 최저 50에서 100까지. 
h2 <- hist(Temp,ylim = c(0,40))
h2$counts
h
text(h2$mids,h2$counts,labels=h2$counts,adj=c(0.5,-0.5)) 
# h2에 각 건 수치를 히스토그램 막대 위에 올림. adj는 위에 숫자 위치 조정할 때 사용. 
h # $breaks 속성을 보면 55부터 100까지 5씩 구간화 , $count - 60~65사이 개수가 10건. 
hist(Temp,breaks=10) # breaks값 주면 히스토그램을 그 값만금 구간화 시킨다. 
hist(Temp,xlim=c(50,100), breaks=c(55,60,70,80,100),col="red") # 수동으로 구간을 지을 수 있음. 


## ggplot2
library(ggplot2)
diamonds
ggplot(data=diamonds,
       aes(x=diamonds$carat,
           y=diamonds$price,color=clarity))+geom_point()

# 오존농도 시각화 
h3 <- boxplot(airquality$Ozone,col="red",horizontal = TRUE) 
h3 # 변수로 주면 각종 항목을 볼 수 있음. 

## 연령대 별로 대장암 환자에 대한 도수분포표 출력 
getwd() # 파일 경로 확인
cancer1 <- read.csv("example_cancer.csv") # csv파일을 불러 옵니다. 
cancer1 
View(cancer1) # 파일의 내용을 확인합니다. 
h5 <- cancer1$age # cancer1에서 나이부분만 추출하여 h5에 할당합니다. 
h5
hist(h5, main="대장암 환자 분포", xlab="Age", breaks=c(10,20,30,40,50,60,70,80,90,100,105))
# 나이를 활용하여 히스토그램을 그리고, 각 나이 구간별로 나눕니다.
h6 <- hist(h5,ylim=c(0,3000),xlab="Age",ylab = "단위(명)", main="대장암 환자 분포",
             col=c("red","blue"))
h6
text(h6$mids,h6$counts,labels=h6$counts,adj=c(0.5,-0.5),col="green")
# 다른 방식
cancer1 <- read.csv("example_cancer.csv") # csv파일을 불러 옵니다. 
# table(cut(df9$age, breaks=(1:11)*10))
df10 <- table(cut(cancer1$age, breaks=(1:11)*10)) # 나이로 구간화 하고, 각 구간을 10~110까지로 나눕니다. 
table(cancer1$age)
str(df10)
rownames(df10) <- c("10세","20세","30세","40세","50세","60세","70세","80세","90세","100세")
class(df10)
barplot(df10) # 완료!
################################################################
df11 <- as.data.frame(df10) # plot쓸 때 x,y지정하기 위해서
df11
plot(df11$Var1, df11$Freq,type="n")
# ggplot
s <- ggplot(data=diamonds[diamonds$carat<2.5,],
       aes(x=carat,y=price,colors=color)) #alpha 넣으면 폰트 작게 가능. 
s + geom_point(aes(color=color))+geom_smooth()



