#4. example_cancer.csv를 이용하여 연령 IQR을 구하시오.

data <- read.csv("example_cancer.csv",na.strings = "-",stringsAsFactors = F) 
colnames(data)
str(data)

quantile(data$age)

#5. example_cancer.csv를 이용하여 연령기준 아웃라이어를 찾고 제거하시오.
boxplot(data$age)

IQR(data$age, na.rm = T) # quantile[4]-quantile[2] 값. 중간값을 의미. 
boxplot(data$age, range = 1.5)
location <- quantile(data$age, 
                     probs = c(0.25,0.75), na.rm=T)
down <- location[[1]]
up <- location[[2]]
down
up
outlier <- subset(data, 
                  subset=(data$age < down | data$age > up))
View(outlier)


#6. example_salary.csv를 이용하여 연령별 평균값을 구하고 하여 그래프로 출력하시오.

data2 <- aggregate(data$age~data$sex+data$age, data, mean)
data2
colnames(data2) <- c('gender','age_num')
class(data2)
ggplot(data2, aes(x=data2$gender,
                  y=data2$age_num,
                  fill=data2$gender)) + geom_bar(stat="identity")



