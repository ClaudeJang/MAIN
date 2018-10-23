# dplyr
# cross tab
# reshape2, melt, cast

library(reshape2)
# example_data5.csv
df <- read.csv("example_data5.csv",header = T)
df 
melt(df,id.vars = c("id","time")) 
# id, time 데이터 고정시켜놓고 나머지 데이터를 그에 맞게 정렬. 

melt(df,id.vars = c("id")) # id데이터만 고정, variable에 time, x1,x2 지정

# dcast - melt와 반대 기능, 축을 바꿔줌 
df2 <- read.csv("example_data3.csv",header = T)
df2
# Year, SemiYear, ProductA, ProductB 형태로 하고 싶을 때
dcast(df2,Year+SemiYear~Product,value.var = "Income")
# Year,SemiYear는 고정, Product를 variable로 나타내는 것, 
# value.var="Income" 은 Income 필드 값을 각 product A,B에 넣는 것임.

df3 <- read.csv("example_data4.csv")
df3
library(reshape2)
colnames(df3[,-1])
# id.vars 
# measure.vars
# variable.name
# value.name
x <- colnames(df3[,-1])
melt(df3,id.vars="ID",
     measure.vars = x,
     variable.name = "Species",
     value.name = "Sepal.Length",
     na.rm=T)