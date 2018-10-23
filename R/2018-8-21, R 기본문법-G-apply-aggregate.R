?matrix
?apply
x<-matrix(1:100, nrow=10, ncol=10)
apply(x,1,sum)
apply(x,2,sum)
# 1은 행, 2는 열 
# 데이터 프레임은 열단위, 열의 이름이 제목
test <- data.frame(a=1:3,b=2:4,c=3:5) 
test
lapply(test,mean)

x <- list(a = 1:5, b=1:10) 
sapply(x,mean)

seg.df<-read.csv("http://goo.gl/qw303p")
head(seg.df,15)
View(seg.df) 
attach(seg.df) # 데이터 고저
mean(income[subscribe=="subNo"])
mean(income[subscribe=="subYes"])
apply(seg.df[subscribe=="subNo", c(1,3,4)], 2, mean) 
apply(seg.df[subscribe=="subYes", c(1,3,4)], 2, mean) 
table(kids)
table(ownHome,subscribe)
by(income, subscribe, mean) # 구독여부에 따른 소득 값.
by(kids, subscribe, mean)
# by는 직관적이지만, 이 값 자체로는 뭘 설명할 수 없다. 

aggregate(income ~ Segment+kids, data=seg.df, mean)
aggregate(income ~ Segment, data=seg.df, mean)
# 조건 추가하려면 뒤에 +로 붙여주면 된다. 
aggregate(income ~ ownHome,data=seg.df,mean)
k<-aggregate(income ~ subscribe, data=seg.df, mean)
# 결과가 표라서 데이터프레임.
class(k)
aggregate(income~Segment+ownHome+subscribe, data=seg.df, mean)
# 로지스틱으로 yes, no를 파악하고 그 다음에 어떤 변수가 영향을 미치는 가를 보는 것. 
# 지금은 그룹핑으로 단순히 보는 것. 
# 데이터가 적으면 엑셀 피벗으로 보고
# 데이터가 많으면 R로 피벗테이블 역할을 함. 

i

