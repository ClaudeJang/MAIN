# 데이터 로드하기. 

x <- 10:1
y <- -4:5
q <- c("Hotkey", " Football","Baseball", " Curling","Rugby", "Lacrosse","Basketball","Tennis",
       "Cricket","Soccer")
theDF <- data.frame(x,y,q)
theDF
names(theDF) <- c("First","Second","Sport") # 열 이름 설정하는 방법 1

theDF <- data.frame(First = x, Second = y, Sport= q) #열 이름 설정방법 2 
theDF
?data.frame

nrow(theDF)
ncol(theDF)
dim(theDF)
names(theDF)
rownames(theDF)
colnames(theDF)
head(theDF)
class(theDF)
theDf$q
theDF[3,2:3]
theDF[,2:3]
theDF[,c("First",'Sport')]
class(theDF[["Sport"]])
theDF[["Sport"]] # 데이터 프레임으로 값 변환
theDF[,"Sport",drop=T] # 벡터로 값 변환
