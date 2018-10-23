install.packages("ggiraphExtra")
library(ggiraphExtra)
library(dplyr)
library(tibble)
crime <- 
  rownames_to_column(USArrests, var="state")

head(crime,3)
crime$state <- tolower(crime$state) # 소문자로 나타냄. 
str(crime)
library(ggplot2)
install.packages("maps")
install.packages("mapproj")
states_map <- map_data("state")
states_map
ggChoropleth(data = crime,
             aes(fill=Murder, # 색깔변수
                 map_id=state), # 지역
             map = states_map) # 지도 데이터


data <- read.csv("TestData.csv", 
                 header = T,na.strings=c("-"))
data

install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014") # 깃허브 파일 다운로드
library(kormaps2014)
# github 코드 저장, 공유 사이트 

str(changeCode(kormap1))
colnames(korpop1)
library(dplyr)
str(changeCode(kormap2))
str(changeCode(kormap3))
# 총인구_명
# 행정구역별_읍면동
korpop1 <- rename(korpop1,
                  pop = "총인구_명",
                  name="행정구역별_읍면동") # 인구에 대비해서 결핵환자 데이터

ggChoropleth(data= korpop1,
             aes(fill=pop,
                 map_id=code,
                tooltip = name),
             map=kormap1,
             interactive = T) # 데이터를 맵에 그려서 색깔로 표현해줌 

