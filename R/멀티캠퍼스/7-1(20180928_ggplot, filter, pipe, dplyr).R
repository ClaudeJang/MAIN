## 2018. 10. 1 

# plyr, dplyr
# tidyverse -> (ggplot2, dplyr, readr, tibble, tidyr, purrr, stringr, forcats) 의 세부 패키지. 
# 데이터 추출 - filter, select, arrange, mutate(새로운 행을 추가), summarise, group by, left_join(), bind_rows() 
library(magrittr)
library(dplyr)
df <- read.csv("example_exam.csv")
df %>% filter(class == 1)
df %>% filter(math >50) %>% head(2)

head(df, n=3)

df %>% filter(english > 50 | math >50) # OR 
df %>% filter(class %in% c(1,4,5)) # Class가 1,4,5반만 나오게 추출 %in%이 포함한다는 의미. 

str(mtcars)
str(cars)

library(ggplot2)
class(mpg)
mpg <- as.data.frame(mpg)
df2<- mpg %>% filter(manufacturer %in% c('ford','honda'))
df2   
mean(df2$hwy)

select()
select_() # select_ : 인용부호가 필요할 때 사용. 사용금지 권고
df %>% select(class,math) %>% filter(class > 1) 
# select 검색할 부분 # filter  검색 내용 
df
class(df)
df[df$class >1,] 
dt <- data.frame(df)
dt[,,]

df %>% select(-class)
df %>% arrange(math) # 수학을 기준으로 오름차순
df %>% arrange(desc(math),desc(class)) # 내림차순 


# mutate를 이용해 새로운 열을 쉽게 삽입이 가능하다. 
df2 <- df %>% mutate(total = math + english + science,
                     mean = (math + english + science)/3 ) %>%
  select(total,mean) %>%
  head(3)
df2
# 조건식을 넣어 새로운 열을 만들 수 있음. 
df <- df %>% mutate(check = ifelse(math > 60, "합격","과락"))
df
colnames(df)[6] <- "passfail"
df

diamonds
select(diamonds, carat, price) # select(data, subset1, subset2)
# 인용된 이름이 필요할 때  -> 인용문장으로 만들 때 유용 
diamonds %>% select(one_of('carat','price'))# 인용부호 포함 
diamonds %>% select(carat, price) # 인용부호 없이 
select(diamonds,one_of('carat','price'))
diamonds[,c('carat','price')]
thecols <- c('carat','price')
diamonds %>% select(one_of(thecols))
diamonds %>% select(c('carat','price'))
diamonds %>% select(1,7)

# 열 이름에 대해 부분매칭을 사용해 검색하는 경우 
# starts_with, ends_with, contains 함수 사용 

diamonds %>% select(starts_with('c'))
diamonds %>% select(ends_with('e'))
select(diamonds, contains('l'))
# 정규 표현식을 가지고 검색을 할 때 matches 함수 사용 

diamonds %>% select(matches('r.+t'))
# r과 t사이에 수에 제한 받지 않는 와일드카드가 있는 열 
diamonds %>% select(-c('carat','price'))
diamonds %>% select(-one_of('carat','price'))
diamonds %>% select(-c(carat, price))

diamonds %>% filter(cut %in% c('Ideal','Good'))
diamonds[diamonds$cut =="Ideal",]

# 인용된 표현식을 사용해 변수의 값에 기초, 필터링 할 때 
diamonds %>% filter_("cut=='Ideal'") # 더블 쿼터와 구분해서 써야 컴퓨터가 다름을 인식 
diamonds %>% filter_(~cut == "Ideal") # cut이 "Ideal"인 것만 

filter(diamonds, c(carat <1 | carat >5))
# carat이 1보다 작거나 5보다 큰 것들 모두 반환 

theCut <- "Ideal"
diamonds %>% filter_(~cut == theCut) # 정상 
diamonds %>% filter(~cut == theCut) # 오류  

theCol = "cut" 
theCut <- "Ideal"
diamonds %>% filter_(sprintf("%s =='%s'",theCol, theCut))                     
# 값과 열을 모두 변수에 지정하고 사용할 때 
# sprintf 함수를 사용해 전체 표현식을 하나의 문자열로 구성하면 가능해짐 

# summarize
df %>% summarize(mean_check = mean(math)) 
# aggregate, group by 
df %>%
  group_by(class) %>%
  summarise(mean_check = mean(english),
            sum_check = sum(english),
            median_check = median(english),
            n = n())

# mean, median, sum, min, max, sd, n 
# mpg 정보에서 회사별로 분리하고 suv에 해당하는 통합 연비 
# 와 통합연비 평균을 구하고 내림차순으로 정렬하고 
# 1~5위까지 출력하시오. 
# group by, filter, mutate 
# 통합연비 = (cty+hwy)/2 
# 통합연비 평균 = mean() 
# arrange(desc())
# head(5)

View(mpg)
mpg

mpg %>%
  group_by(manufacturer) %>%
  filter(class=="suv") %>%
  mutate(total = (cty+hwy)/2) %>%
  summarise(mean_tot = mean(total)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)

# 어떤 회사 자동차의 hwy(고속도로연비)가 가장 높은 지 알아보려고 한다. 
# hwy 평균이 가장 높은 회사 3곳을 출력하시오. 

mpg %>%
  group_by(manufacturer) %>%
  summarise(hwy_tot = mean(hwy)) %>%
  arrange(desc(hwy_tot)) %>%
  head(3)

# 데이터 합치기 (cbind, rbind 외) 
# 두 개를 붙일 때 어떤 key를 기준으로 붙이는 것. 
# 사용자 데이터 있다고 가정, user id, username, lacation
# user1, 홍길동, 서울 
# user2, 이순신, 서울 
# user3, 강감찬, 용산 

# 로그 데이터
# timestamp,user id, logtype, etc
# 2018000000, user1, PC
# 2018000001, user2, PC
# 2018000002, user1, Mobile
# 2018000003, user1, PC

# 두 데이터의 구조가 다름에도 붙이고 싶을 때 



# ggplot2 

library(ggplot2)
g<- ggplot(data = iris, aes(x=iris$Sepal.Length,
                            color=iris$Species)) 
g2 <- g + geom_histogram(fill="white",bins=10)
g2

# geom_density 
g3 <- ggplot(data = iris, aes(x=iris$Sepal.Length,color=iris$Species))
g4 <- g3 + geom_density()
g4              

# geom_bar
mpg
g5 <- ggplot(data = mpg, aes(x=class))
g6 <- g5 + geom_bar()
g6         
# coord_filp
g7 <- ggplot(data = mpg, aes(x=class))
g8 <- g7 + coord_flip() + geom_bar()
g8   

# xlab, ylab, ggtitle
# labs(title = "", x="", y="")
g9 <- ggplot(data = mpg, aes(x=class))
g10 <- g9 + geom_bar()
g10 + xlab("x axis") + ylab("y axis") + ggtitle("Main") 
# OR 이렇게 해도 똑같음.  
g10 + labs(title="main", x = "X axis", y = "Y axis")

# labs(title = "", x="", y=""), geom_text 
g10 + labs(title="main", x = "X axis", y = "Y axis") + geom_text(stat = "count", aes(label=..count..),
                                                                 vjust = 0)
# example 
test <- c(rep('banana',3), rep('orange',25), rep('apple',5))
df <- data.frame(test)
ggplot(df, aes(test, ..count..)) + geom_bar(aes(fill=test),position="dodge")
# ..count..는 스페셜 카운트 


# example_population 
# dplyr 패키지를 사용하여 처리하시오. (example_population_f)
library(data.table)
library(magrittr)
library(dplyr)
library(ggplot2)
data <- fread("example_population_f.csv")
getwd()

class(data)
data2<- as.data.frame(data)
class(data2) 
View(data)
colnames(data)
# 1. 충청도만 데이터를 구성하고 시별 그래프를 출력하시오.(x = City, y= Population)
data3 <- data2 %>% filter(Provinces %in% c('충청북도','충청남도'))
data3 <- data2 %>% filter(Provinces == "충청북도" | Provinces == "충청남도")
data3
colnames(data3)
head(data3$Population,3)

g1 <- ggplot(data3,aes(x=City,y=Population))
g2 <- g1 + geom_bar(stat ="identity")
g2
# stat = "count", stat = "identity" <- 이거 사용하면 데이터프레임의의 자료를 쓸 수 있다. 
# 빈도 따질 때는 카운트, 아이덴티티는 데이터프레임 자료 가져올 때.

# 2. 위의 그래프를 오름차순으로 정렬하시오.(reorder 함수), ggplot
g3 <- ggplot(data3,aes(x=reorder(City,Population),y=Population)) # Population 기준으로 reorder.
g4 <- g3 + geom_bar(stat ="identity") + geom_text(stat="identity",aes(label=Population),vjust=0)
g4
# geom_text에 막대그래프 수치 넣음. stat= identity로 자료에서 가져오고,
# aes(label=Population)로 해서 Population 열의 수치를 이용. 
# stat
#     stat="count" 빈도수 구할 때 
#     stat="identity" => x,y축 사용 => identity
#     stat="bin" => no x,y, x축 하나만 부여 

# 3. 남자 비율이 높고 1인가구가 많은 도시를 필터링하고 그래프로 출력하시오. (ggplot) 
library(data.table)
library(magrittr)
library(dplyr)
library(ggplot2)
data <- fread("example_population_f.csv")

d4 <- data3 %>% filter(SexRatio > 1)
d4
d5 <- ggplot(d4, aes(x=d4$City,y=d4$SexRatio))
d6 <- d5 + geom_bar(stat="identity") +geom_text(stat="identity", aes(label=SexRatio),vjust=0)
d6  
             


          
# 4. 경기도 데이터중 남녀 비율을 확인하고, 그래프로 출력하시오.(ggplot) 
ifelse(SexRatio <1, "여자비율높음")
df3 <- read.csv("example_population_f.csv")
colnames(df3)
df3 <- df3[,-1]
df3 <- mutate(df3,CheckTF = ifelse(SexRatio < 1,"여자비율높음",ifelse(SexRatio > 1, "남자비율높음","비율동일")))
df3$CheckTF <- factor(df3$CheckTF) # factor화 
df3$CheckTF <- ordered(df3$CheckTF,
                       c("여자비율높음","남자비율높음","비율동일"))
df4 <- df3 %>% filter(Provinces =="경기도")
g6 <- ggplot(df4, aes(x=City, y= SexRatio)) 
g7 <- g6 + geom_bar(stat="identity") + geom_text(stat="identity", aes(label=SexRatio),vjust=0)
g7

df5 <- df3 %>% filter(Provinces =="서울특별시")

# 5. 시도별 남녀 비율을 구하고, 그래프로 출력하시오. (ggplot)
df <- fread("example_population_f.csv")
df1 <- as.data.frame(df)
View(df1)
df2 <- df1 %>% group_by(Provinces) %>%
  summarise(total_male=sum(Male),total_female=sum(Female)) %>%
  mutate(total_ratio = (total_male / total_female)) %>%

ggplot(df2, aes(x=Provinces,y=total_ratio)) + geom_bar(stat="identity")+ geom_text(stat="identity", aes(label=total_ratio),vjust=0)

# 5-1. 각각의 모수대비 비율 
df <- fread("example_population_f.csv")
df1 <- as.data.frame(df)
df2 <- df1 %>% group_by(Provinces) %>%
  summarise(total_Pop=sum(Population),total_male=sum(Male),total_female=sum(Female))
View(df2)

df3 <- df2 %>% mutate(male_ratio=total_male/total_Pop,female_ratio=total_female/total_Pop)
df4 <- df3 %>% select(c(1,5))
df5 <- df3 %>% select(c(1,6))
df4_male <- as.data.frame(df4)
df5_female <- as.data.frame(df5)
colnames(df4_male)[2] <- c('ratio') # 1:16 남자
colnames(df5_female)[2] <- c('ratio') # 17:32 여자
df6 <- rbind(df4_male,df5_female)
df6
df6$ratio <- round(df6$ratio,3)
df6$sex[1:16] <- "male"
df6$sex[17:32] <- "female"
install.packages("ggthemes")
library(ggthemes)
g <- ggplot(df6, aes(x=Provinces, y=ratio, fill=sex)) +
  geom_bar(stat="identity")+ coord_cartesian(ylim = c(0.475, 0.525)) + theme_wsj()+ geom_text(aes(y=ratio, label=ratio))
g
