# rvest <- text mining => wordcloud
# 텍스트마이닝 : 문자 데이터에서 가치있는 정보를 얻어내는 방식. 

# 분석순서
# 1. 형태소 분석
# 2. 명사, 동사 형용사 등의 의미를 지닌 
#    품사 단어 추출
# 3. 빈도표 만들기
# 4. 시각화

# jdk 설치. 
# install.packages("rJava")
# install.packages("memoise")
# install.packages("KoLNP")

library(rJava)
library(memoise)
library(KoNLP) # 형태소를 뽑아낼 수 있다.
useNIADic() # 파일 내 dictionary를 만들어줌. 사전을 다운로드하는 기능. 

data <-readLines("hiphop.txt")
head(data)
library(stringr)
data <- str_replace_all(data,
                        "\\W",
                        " ")
data
KoNLP::extractNoun("방갑습니다. 즐거운 하루되세요. 이순신")
nouns <- extractNoun(data)
class(nouns)
data2 <- unlist(nouns)
data2 
data3 <- table(data2) # 빈도를 알 수 있음. 
data4 <- data.frame(data3, stringsAsFactors = F)

# 워드 클라우드 
library(wordcloud)
library(RColorBrewer)
set.seed(1234) # 난수생성 
pal <- brewer.pal(8, "Dark2")
wordcloud(data4$data2,
          data4$Freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          scale = c(4,0,3),
          colors = pal)
# OR 
# library(dplyr) 에서 rename 함수 이용 
