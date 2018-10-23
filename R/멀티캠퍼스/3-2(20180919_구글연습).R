# compare the output of these examples, and compalre the difference btw when
# the data are being read as ' character'. and when they are being read as
# 'facter'
exam_data <- data.frame(animal = c("dog","cat","sea cucumber", "sea urchin"),
                        feel=c("furry","furry","squishy","spiny"),
                        weight = c(45,8,1.1,0.8),stringsAsFactors = F)
str(exam_data) # strAsFactors =F면 팩터아닌 캐릭터로 가져옴 

# 구글 예제(https://statkclee.github.io/R-ecology-lesson/kr/03-data-frames.html)
# 도전 과제 1 
author_book <- data.frame(author_first=c("Charles", "Ernst", "Theodosius"),
                          author_last=c("Darwin", "Mayr", "Dobzhansky"),
                          year=c(1942, 1970,1950),stringsAsFactors = F) 
# author_last 벡터가 character가 되어야 하고, year값이 기존 2개에서 스칼라 개수에 맞는 
# 되어야 함. 
author_book

# 도전 과제 2 -str함수 쓰기전 자료형 클래스 예측해보기 
country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18,15),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, FALSE),
                              has_kangaroo=c(FALSE, FALSE, FALSE, TRUE),stringsAsFactors = F)
country_climate
str(country_climate)
# stringAsFactors = F로 두면 팩터로 변환시키지 않고 캐릭터 형태로 둔다 .
# 확실하게 보장하려면 개별 컬럼의 형태를 일치시킨다. 논리값은 논리값대로, integer는 integer대로

color <- c("red", "green", "blue", "yellow")
counts <- c(50, 60, 65, 82)
new_datarame <- data.frame(colors = color, counts = counts)
new_datarame # 벡터를 가지고 있는 경우, 데이터 프레임 함수에서 각각의 벡터를 붙여주면 된다. 
class(new_datarame)
summary(new_datarame)

seq(1,10, by=2)
seq(5,10,length.out = 3)
?seq #desired length of the sequence. 
# A non-negative number, which for seq and seq.int will be rounded up if fractional.
# length.out 총 반환 갯수(length)를 3개 나오게 함

seq(50,5,length.out = 10)
# 50에서 5까지 일정한 차이로 나오는 10개의 수열 도출

seq(1,8,by=3)
colnames(diamonds)
