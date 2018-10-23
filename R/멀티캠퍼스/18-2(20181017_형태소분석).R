# 1. 어제 제공했던 twitter.csv 파일을 이용하여 트윗 텍스트 마이닝을 하고, 
# 단어의 빈도를 나타내는 막대 그래프를 출력하시오. 
# 2. 그리고 word cloud를 만드시오. 
rm(list=ls())
# install.packages("rJava")
library(rJava)
library(memoise)
library(KoNLP) # 형태소 분석
useNIADic()
data <- read.csv("twitter1.csv", encoding = "ASCII")
class(data)
library(stringr)
data$Contents <-str_replace_all(data$Contents,",","")
data$Contents <-str_replace_all(data$Contents,"'","")
data$Contents <-str_replace_all(data$Contents,".","")
data$Contents <-str_replace_all(data$Contents,"?","")
data$Contents <-str_replace_all(data$Contents,"/","")
head(data$Contents,1)
data2 <- unlist(lapply(data$Contents,extractNoun))
for (i in 1:25){
  gsub
  s
  
}
data2
head(data,2)
class(data)
View(data)
text.clean(data$Contents)
colnames(data) <- c("X", "Num", "AccountName", "DateToWrite","Contents")


df1 <- data.frame(content1 = data$Contents)
head(df1,2)
colnames(df1)
View(df1)
library(readr)
library(stringr)
library(rvest) # R webscrapping package
library(RSelenium) # R login package
library(igraph)
library(qdap)
library(text2vec)
library(data.table)
library(stringr)
library(tm)
library(RWeka)
library(tokenizers)
library(slam)
library(wordcloud) # 워드 크라우드
library(ggplot2) # 그래프
library(scam)
library(NLP) # word parsing package
library(openNLP)
library(ggmap)
library(rworldmap)
library(rworldxtra)
library(tm)

text.clean = function(x)                    
{ 
  x  =  iconv(x, "latin1", "ASCII", sub="") # ASCII 문자 유지
  x  =  removeNumbers(x)                    # 숫자 제거
  x  =  stripWhitespace(x)                  # 공백제거
  x  =  gsub("^\\s+|\\s+$", "", x)          # 선행 및 후행 공백 제거
  return(x)
}



KoNLP::extractNoun("방갑습니다. 즐거운 하루되세요. 이순신")
nouns <- extractNoun(df1)
data2 <- unlist(nouns)
head(data2,2) 




View(df1)
library(dplyr)
head(df2, 2)
glimpse(df2)
data2 <- removeWords(data2, stopword2)
length(filter_page1)
