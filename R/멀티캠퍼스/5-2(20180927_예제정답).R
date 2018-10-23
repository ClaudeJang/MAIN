# 예제 정답
library(ggplot2)
library(data.table)
DF <- fread("example_coffee.csv", header = T, stringsAsFactors = F, data.table = F)
range(DF$yearOfStart,na.rm=T)
DF2 <- subset(DF,subset= (DF$yearOfStart==1964))
DF3 <- subset(DF,subset =(DF$stateOfbusiness=="운영중"))
range(DF3$yearOfStart, na.rm=T)
subset(DF3, subset = (DF3$yearOfStart == 1967))
table(DF$yearOfStart)
qplot(DF$yearOfStart, date=DF, geom = "")
DF4 <- table(DF$stateOfbusiness,DF$yearOfStart)
DF4
? min

# question02.txt 
# 5. 년도별 영업상태를 비율로 출력하시오. table() -> prop.table()
library(data.table)
DF <- fread("example_coffee.csv")
Freq <- table(DF$stateOfbusiness, DF$yearOfStart)
which(colnames(Freq)=="1997") # 1997 인덱스 번호
which(colnames(Freq)=="2015") # 2015 인덱스 번호 
range(DF$yearOfStart, na.rm=T)
Freq <- Freq[,c(30:48)]
Freq2 <- prop.table(Freq, 2)

data2 <- data.frame(colnames(Freq),
                    Freq[1,], 
                    Freq[2,],
                    Freq2[1,],
                    Freq2[2,])

data2
data2 <- data.table(data2)
colnames(data2) <- c("Time",
                     "Open",
                     "Close",
                     "POpen",
                     "PClose")
rownames(data2) <- NULL
data2
str(data2)
df2 <- data2
ggplot(data=df2,aes(x=Time, y=Close, group=1))+geom_line()+geom_point()

?prop.table
# 6. 1997년 ~ 2014년 데이터만 저장합니다. 열데이터는 (년도, 오픈 수, 폐업 수, 오픈 비율)로 구성하시오. 

# 7. ggplot2로 geom_line과 geom_point를 사용해서 출력하시오. 
