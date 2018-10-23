rm(list=ls())
install.packages("scam")
install.packages("RSelenium")
install.packages("igraph")
install.packages("qdap")
install.packages("text2vec")
install.packages("RWeka")
install.packages("ggmap")
install.packages("rworldmap")
install.packages("rworldxtra")
install.packages("tokenizers")
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
{ require("tm")
  x  =  gsub("<.*?>", " ", x)               # HTML 태그를 제거하기위한 정규 표현식
  x  =  iconv(x, "latin1", "ASCII", sub="") # ASCII 문자 유지
  x  =  gsub("[^[:alnum:]]", " ", x)        # 영문숫자만 유지 
  x  =  tolower(x)                          # 소문자로 변환
  x  =  removeNumbers(x)                    # 숫자 제거
  x  =  stripWhitespace(x)                  # 공백제거
  x  =  gsub("^\\s+|\\s+$", "", x)          # 선행 및 후행 공백 제거
  x  =  gsub("\\s[[:alpha;}}$", "",x)
  return(x)
}


url <- "https://www.imdb.com/title/tt0910970/reviews?filter=love&filter=love&start=10"
url

page1 <- read_html(url)
filter_page1 <- html_nodes(page1,".content") # 텍스트만 끄집어 내는 함수 
filter_page1 
stopword2 <- stopwords("english")  # 언어 종류가 영어일 때 필요없는 단어를 제거해줌. 대명사 등
data<- html_text(filter_page1)
data2 <- text.clean(data)
data2 <- removeWords(data2, stopword2)
length(filter_page1)

 
#data <- gsub("'"," ", data)






#data <- gsub("\n"," ",data)  # 데이터에 불필요한 sep 쪽 제거함.




data2 <- stripWhitespace(data2) # 공백을 없애주는 함수 
length(data2)
# 단어 빈도 확인하려면
library(stringr)
#data2 <- gsub(" s ", " ", data2)
#data2 <- gsub(" t ", " ", data2)
data3 <- str_split(data2," ")
data4 <- unlist(data3)
data5 <- table(data4)

# 빈도수 높은 단어 상위 10개를 추출하시오.  
library(magrittr) # %>%(pipeline)
library(dplyr) # arrange, mutate, summarise, group_by
class(data5)
data6 <- data.frame(data5)
d<-data6 %>% arrange(desc(Freq)) %>%
  head(10)
d

colnames(d) <- c("d_name", "d_count")
library(ggplot2)

ggplot(data=d, 
       aes(x = d_name, 
           y = d_count)) + geom_bar(stat = "identity")



url1 <- 
  "https://www.imdb.com/title/tt0910970/reviews?ref_=tt_ov_rt"
pages1 <- read_html(url1)
pages1
filter_pages1 <- html_node(pages1, ".content") # class는 .(점)으로 쓰고(<div class="content">\n), 
# id는 #을 쓴다. 
filter_pages1 
stopword2 <- stopwords("english") # 영어일 때 필요없는 단어를 제거해줌. 대명사 등(불용단어)
# 내가 제거할 단어를 더 추가할 수도 있음. 
dataa<- html_text(filter_pages1)
dataa
dataa <- gsub("\n"," ", dataa)
dataa2 <- text.clean(dataa)
dataa2 <- removeWords(dataa2, stopword2)
dataa2 <- stripWhitespace(dataa2)
length(dataa2)
dataa3 <- str_split(dataa2, " ")
dataa4 <- table(dataa3) 

# -------------------------------------------------
# question 01 - 
# html_nodes => 25건으로 된 경우 동일한 처리를 하시오.  
#for (i in 1:25){
url1 = "https://www.imdb.com/title/tt0910970/reviews?ref_=tt_ov_rt"
page1 = read_html(url1)
reviews1 = html_text(html_nodes(page1,'.content'))
class(reviews1)                               
#}
reviews = gsub("\n",' ',reviews)
writeLines(reviews,'test.txt')

temp.text = readLines(file.choose()) 
class(temp.text)
head(temp.text, 4)

data = data.frame(id = 1:length(temp.text), 
                  text = temp.text, stringsAsFactors = F)
dim(data)
colnames(data)
data$id
data$text

stpw1 = readLines(file.choose()) 
stpw2 = tm::stopwords('english')   
comn  = unique(c(stpw2, stpw1))    
stopwords = unique(gsub("'"," ",comn))

x  = text.clean(data$text)            
x  =  removeWords(x,stopwords)        
x  =  stripWhitespace(x)              
#x  =  stemDocument(x)