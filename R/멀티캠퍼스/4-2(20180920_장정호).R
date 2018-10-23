install.packages("hflights")
library(hflights)
install.packages("data.table")
library(data.table)
install.packages("KoNLP")
# 1. 6000 도착횟수가 넘는 공항 찾기, 항공사 찾기 
TotalCount <- table(hflights$Dest)
TotalCount2 <- TotalCount[TotalCount >= 6000]
TotalCount2
class(hflights$UniqueCarrier)
unique(hflights$UniqueCarrier)
table(hflights$UniqueCarrier) 
addmargins(table(hflights$UniqueCarrier),1) 
# 2. 6000횟수가 넘는 공항들의 전체 합을 구하고 막대 그래프를 출력하시오. 
addmargins(TotalCount2) 
barplot(TotalCount2)

