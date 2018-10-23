library(data.table)
library(dplyr)
library(ggplot2)
library(magrittr)
data <- fread("example_data.csv",stringsAsFactors = T,header=T)
data <- read.csv("example_data.csv",stringsAsFactors = T,header=T)
str(data)
as.data.frame(data)
class(data)
data %>% select(Index,State:Y2008) %>% head(3) 
data %>% select(-Index,-State)
# data %>% select(-c(Index,State))
select(data,starts_with('Y'))
select(data,ends_with('5'))
select(data,-starts_with("Y"))
select(data,contains("l"))
# starts_with(), ends_with(), contains(), matches()
# one_of(),num_range(), everything() 
select(data,State, everything())

# rename : 이름 바꿀 때 사용, 식으로 편하게 바꿀 때 
colnames(data)
data2 <- rename(data, Index1 = Index) # 변수 지정해줘야 함. 
colnames(data2)

filter(data,Index == "A") # Index가 A와 같은 자료만 추출 
filter(data, Index %in% c("A","C")) # A와 C 포함하는 자료만 추출 
filter(data, !Index %in% c("A","C")) # A와 C만 제외하는 자료만 추출(Not)
filter(data, Index %in% c("A","C") & Y2002>=120000)
filter(data, grepl("Ar",State)) # grepl 함수 이용해 추출, State중 "Ar"들어간 곳의 자료만 data에서 전부 추출 

summarise(data, mean=mean(Y2005), 
          Y2005_median = median(Y2005),
          mean2=mean(Y2006)) # mean과 mean2, Y2005_median항목을 새로 만들어 추출 
# 한 번에 하는 방법
summarise_at(data, vars(Y2005,Y2006),
          funs(mean,median)) # vars에 해당 필드 데이터 넣고, 만들고 싶은 값 함수를  funs에 넣어서 입력 

# refer to data.frame - 데이터의 레퍼런스를 온점에 넣는 것. 
myTop <- function(x,N=5){
  x %>% arrange(desc(Y2005)) %>% head(N)
} # 사용자 함수 myTop을 만듬. 
data %>% do(myTop(.,N=3))  # 임의의 사용자 함수를 만들 때는 조건이 들어가지 않은 원본 데이터로 하는 게 좋다.
data %>% select(State, Y2005) %>% do(myTop(.,N=3))
# OR 
d <- data %>% select(State, Y2005)
d1 <- myTop(d,N=3) # 중간에 함수가 들어간 상태면 변수 지정해서 식을 단순화 시키는 게 좋다. 
# 
data
length(colnames(data))
dim(data)
d1 <- select(data,Index,State)
head(d1,2)
d2 <- select(data, starts_with("I"))
head(d2,2)
dim(d1)
dim(d2)
filter(d1, Index =="A")
filter(d1, Index %in% c('A','C'))
filter(d1, grepl('Ar',State)) # State라는 column을 넣고 'Ar'을 검색함.

myFunc <- function(x){
  x %>% arrange(desc(Index)) %>% head # 내림차순으로 
}

data %>% select(Index, State) %>% do(myFunc(.)) # .을 넣음으로서 기존 'data'값을 여기에 넣음 
# myFunc이 내림차순 정렬이기 때문에 State의 W값부터 나오게 됨. 
data %>% filter(Index %in% c('A','C','I')) %>% group_by(Index) # %>% do(head.,2)


diamonds
str(diamonds)
diamonds$color
# diamonds, diamondColor
# diamondColor(A,B,C)
# diamond(A,B,D)
# 두 개를 논리곱을 시켜서 discription을 만들어 준다. 

# inner_join
# left_join 
# right_join
# full_join 

df1 <- data.frame(
  Id <- c(1,2,3,4,5),
  w <- c('a','b','c','d','e')
)
df2 <- data.frame(
  Id <- c(1,7,3,6,8),
  y <- c('t','z','y','l','s')
)

colnames(df1) <- c('Id','w')
colnames(df2) <- c('Id','y')

df1
df2 
inner_join(df1,df2,by="Id")
left_join(df1,df2,by="Id") # 왼쪽 df1의 Id는 다 나오고 왼쪽 기준이므로 일치하지 않는 y데이터들은  안나오게 됨.
full_join(df1,df2,by="Id") # 양 쪽이 다 나옴. 
right_join(df1,df2,by="Id")
# by = c('color' ='Color')
distinct(data,Index) # index에서 중복되는 항목을 제외하고 보여준다. 각 스칼라 1개씩 
distinct(data, Index,State,.keep_all = T) # keep_all을 넣으면 기존 distinct값이 유지되면서 다른 필드값도 나옴.
unique(data$Index) # unique
# distinct는 데이터프레임을 이용해서 추출, 첫번째 인자에 데이터프레임이 들어가야함.
# unique는 데이터프레임 없이. 
semi_join(df1,df2,by="Id") # df1에서 일치하는 값만 가져옴 
anti_join(df1,df2,by="Id") # 세미 조인의 반대. 세미조인값을 제외하고 가져옴.  
# 각 join들을 쓰는 이유는 데이터베이스에서 자료를 가지고 오기 위함. 
# 실제 RDBMS에서 키를 중심으로 각 테이블이 연결되어 있기 때문에 join 함수를 이용해서 
# 자료를 추출. 



