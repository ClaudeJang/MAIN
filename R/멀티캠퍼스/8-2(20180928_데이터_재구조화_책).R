# 데이터 재구조화 

# cbind, rbind
# 2개의 데이터 세트가 똑같은 열이나 행을 갖고 있는 경우. 

# ex. 3개의 벡터를 만들고, 결합해 하나의 데이터 프레임으로 만든다. 
sport <- c("Hockey","Baseball","Football")
league <- c("NHL","MLB","NFL")
trophy <- c("Stanley Cup","Commissioner's Trophy","Vince Lombardi Trophy")
trophies1 <- cbind(sport,league,trophy)

# data.frame을 이용해 또 다른 데이터 프레임을 만듦.
trophies2 <- data.frame(sport = c("Basketball","Golf"),
                        league = c("NBA","PGA"),
                        trophy = c("Larry O Brien Championship Trophy",
                                   "Wanamaker Trophy"),
                        stringsAsFactors = F)
# rbind 사용해서 하나의 데이터 프레임으로 만든다. 
trophies <- rbind(trophies1,trophies2)
trophies
cbind(Sport=sport,Association=league,Prize=trophy)

# 데이터가 정렬되어 있지 않아서 cbind로 문제 해결할 수 없을 때 
# join을 사용 
# merge() in R base, join() in package_plyr, merge() with data.table

download.file(url = "http://jaredlander.com/data/US_Foreign_Aid.zip",
              destfile = "US_Foreign_Aid.zip")
unzip("US_Foreign_Aid.zip",exdir="data")
# 파일들의 리스트를 먼저 얻는다. 
library(stringr)
theFiles <-dir("data/", pattern="\\.csv")
# 이들 파일을 순회한다. 
for(a in theFiles){
  #데이터를 할당한 좋은 이름을 만든다.
  nameToUse <- str_sub(string = a, start= 12, end = 18)
  # read.csv함수를 사용해 csv파일을 읽는다. 
  temp <- read.table(file=file.path("data",a),
                     header=T,sep = ",",stringsAsFactors = F)
  # 읽은 데이터를 워크스페이스에 할당한다. 
  assign(x = nameToUse, value = temp)
}
 
# merge함수 사용 
Aid90s00s <- merge(x = Aid_90s, y = Aid_00s,
by.x = c("Country.Name","Program.Name"), # by.x = 왼쪽 데이터 프레임의 키 열을 지정
by.y = c("Country.Name","Program.Name") # by.y = 오른쪽 데이터 프레임의 키 열 지정 
)
head(Aid90s00s)
View(Aid90s00s)
