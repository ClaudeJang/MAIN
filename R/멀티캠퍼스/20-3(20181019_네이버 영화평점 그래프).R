#네이버 영화 평점 결과를 수집한후 가장 많은 평점을 
#받은 영화를 기준으로 정렬하시오.
#기간은 2018.09.01 ~ 2018.09.30일까지의 평점을 기준으로 한다.
#평점이 가능 높은 상위 10개를 출력하고, 그래프로 출력하시오.

#* 참고사항

class(url)
url <- "https://movie.naver.com/movie/sdb/rank/rmovie.nhn?sel=cur&tg=0&date=20181015"


html_source <- read_html(res, encoding = "ms949")
title <- html_nodes(html_source, ".title")
rating <- html_nodes(html_source, ".point")
# length(title)  # 38개
# length(rating) # 38개
title <- html_text(title)
rating <- html_text(rating)
title # 글자만 빼내기. 
rating
title <- gsub("\r|\n|\t","",title)
title
rating
class(rating)
df <- data.frame(title, rating)
df
# 2018-10-15 -> 20181015 형식으로 바꾸는 작업이 필요. 
# 20180901 ~ 20180930 grouping



#betterDates <- as.Date(dates, format = "%m/%d/%y")
#gsub("-", "", as.character(betterDates))

#date <-c("09/01/2018","01/01/2010", "01/01/2011"," 01/01/2012")
res <- GET(url)
#################################
library(httr)
library(rvest)
library(dplyr)
library(stringr)
library(magrittr)
library(zoo)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer) 



url2 <- "https://movie.naver.com/movie/sdb/rank/rmovie.nhn?sel=cur&tg=0&date="
days<-c(01:30)
days <- sprintf("%02d", days) #1을 2자리수로 만들어라
days <- as.character(days)
september1<-paste0("201809",days)
september2<-paste0(url2, september1)
length(september2)
class(september2)
GET(september2[30])
#newdate<-gsub("-","",as.Date(date,"%m/%d/%Y"))
#newdate
df <- data.frame()
for(a in 1:30){
  res1 <- GET(september2[a])
  html_source <- read_html(res1, encoding = "ms949")
  title <- html_nodes(html_source, ".title")
  rating <- html_nodes(html_source, ".point")
  title <- html_text(title)
  rating <- html_text(rating)
  title <- gsub("\r|\n|\t","",title)
  df_temp <- data.frame(title,rating)
  df <- rbind(df, df_temp)
}
df
View(df)
install.packages("dmm") # 언팩터화하는 패키지
library(dmm)
df$rating <-unfactor(df$rating)
df$title <- as.character(df$title)

str(df)
colnames(df)

df2 <- df %>% group_by(title) %>% summarise(rating2 = mean(rating)) %>% head(10)
library(ggplot2)
ggplot(df2, aes(x=title, y = rating2)) + geom_bar(stat="identity")
View(df2)
