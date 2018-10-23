library(stringr)
data <- c("i","am","a","data scientist")
str_length(data)
length(data)
nchar(data)
data2 <- "I am a data scientist"
str_sub(data2,1,4)
str_sub(data2,6,8)


paste0(c("i am a","data scientist"),collapse= " " )
paste0("i am a","data scientist",collapse=" ")
paste("i", "am", "a","data scientist") # 문자 띄어쓰기 됨
paste0("i", "am", "a","data scientist") # 전부다 붙어서 나옴 
data3 <- "i am a data scientist"
data4 <- "서울특별시 강남구 1111 2222"
data6 <- c("서울특별시 강남구 1111 2222","서울특별시 강서구 1111 2222")
str_split(data4, " ", 4)
data5 <- "010-1111-2222"
str_split(data5, "-", 3)
data5 <- str_split_fixed(data5, "-", 3)
data5[1]
str_split_fixed(data6," ", 4) # 고정사이즈로 스플릿할 때
data7 <- c('apple','banana','strawberry')
data8 <- c('apple','b1zaa','strawberry')
str_detect(data8,'n') # 문자에 n이 있는지 유무를 논리값으로 알려줌.
# 20180101-00000-1000-data 00000.log
str_detect(data8,'^[a-z]{2}') # 첫 앞 2자리가 영문인지 논리값으로 반환. 첫(^)
str_detect(data8,'[a-z]{2}$') # 뒷 2자리가 영문인지 논리값으로 반환. 끝($)

str_extract(data8,'^[a-z]{2}')
grep("\\d",data8, value = TRUE) # 숫자가 들어간 요소만 추출. 

phones <- c("010 2879 0201",
            "032-123-4213",
            "031 341 3312",
            "02 3012 3211",
            "010 1111 2223")
phonePattern <- "([0-9]{3})[-.]([0-9]{3})[-.]([0-9]{4})" # 앞의 3자리 숫자만, 뒤의 4자리도 숫자만
str_extract(phones,phonePattern) # 패턴매칭 
str_replace()

data9 <- c('apple','b1nana','strawberry')
str_replace(data9,"[ae]","-") # 일부분만 -로 치환
str_replace_all(data9,"[ae]","-") # 전부 치환 


# 1. 아파트 실거래가_201801~09.xls를 import하여 18년 1월~9월까지의 
# 서울특별시에 해당하는 구별 매매가 평균을 구하시오. 
install.packages("rJava")
library(rJava)
install.packages("xlsx")
library(xlsx)
install.packages("readxl")
library(readxl)
library(magrittr)
# cleaning up envionment
rm(list=ls())
# making directory as an object
src_dir <- c("C:\\myR\\folder\\")
src_dir 
# listing up name of files in the directory => object
src_file <- list.files(src_dir) # list
# 참고) 여러개의 파일을 개별적으로 read하지말고 loop식을 이용하여 한꺼번에 read하도록 한다. 
# 파일 개수 객체로 만들기 
src_file_cnt <- length(src_file)
src_file_cnt
data <- data.frame()
# 폴더 내 파일들을 루프 돌려서 불러오기 
for (i in 1:src_file_cnt){
  #print(paste(src_dir,file))
  temp <- read_excel(paste0(src_dir,src_file[i]),skip = 16)
  paste0(src_dir,src_file[i])
  data <- rbind(data,temp)
}
View(data)
str(data)

colnames(data)
df2 <- data.frame(data$계약년월,
                  data$계약일,
                  data$시군구, 
                  data$`거래금액(만원)`)
colnames(df2) <- c('year_month',
                   'date',
                   'address',
                   'price')
library(stringr)
library(dplyr)
df3 <- filter(df2, grepl('서울',address))
View(df3)
address2 <- str_split_fixed(df3[,3], " ", 3)
View(address2)
df4 <-data.frame(df3$year_month,
                         address2[,2],
                         df3$price)
colnames(df4) <- c("df3_date","df3_address10","df3_price")
df4$df3_price<- str_replace_all(df4$df3_price,",","") 
# 콤마가 있어 계산이 안 되는 문제가 있어 함수를 이용해 콤마를 
# 없애준다. 
View(df4)
df4 %>% group_by(df3_address10) %>% summarise(price1=mean(df3_price))

df4$df3_price<- as.numeric(df4$df3_price)
class(df4$df3_price)
