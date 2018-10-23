df <- read.csv("example_data1.csv")
df 


# x,MARGIN =1(row), 2=(columns), function, ...(기타 argument)
apply(df,1,max) # 행을 기준으로 df의 최대값을 나타냄. 
apply(df,2,max)
apply(df,1,max,na.rm=T) # 결측치 제외 

# purrr 라이브러리 

library(purrr) # 함수형 프로그래밍 패러다임을 활용할 수 있도록 구성. 
map(theList,sum) # 리스트 각 요소에 대해
# 세부 필드 별로 함수를 독립적용하고 다시 리스트 형식으로 반환
# lapply 함수과 같은 기능 + 파이프 기능 이용 가능 
theList <- list(
  A=matrix(1:9,3),
  B=1:5,
  C=matrix(1:4,2),
  D=2
)
theList %>% map(sum)
lapply(theList,sum) # 22열과 같은 결과

# identical : 두 개의 함수의 값이 같은 지 확인하는 함수, 논리값 반환 
identical(lapply(theList,sum),theList %>% map(sum,na.rm=T)) # theList가 결측값 같고 있을 경우 
theList2 <- theList
theList2[[1]][2,1] <- NA
theList2[[2]][4] <- NA
theList2 %>% map(sum) # 2개 요소가 NA
# 해결방법 1, anonymous func
theList2 %>% map(function(x) sum(x,na.rm=T))
# 해결방법 2, map함수 ...인자에 na.rm=T를 넘겨서 sum함수의 부가인자로 사용
theList2 %>% map(sum,na.rm=T)

# map_chr
theList %>% map_chr(class)
theList3 <- theList
theList3 [['E']] <- factor(c("A","B","C"),ordered=T)
class(theList3$E) 
theList3 %>% map_chr(class) # 새로운 E의 길이가 2라서 chr에서 에러 유발(길이가 1이어야 함)
# 해결방법 map 함수로 리스트를 반환. 
theList3 %>% map(class)

myFunc <- function(a){
  return(a + 1)
}
map(theList,myFunc)
theList %>% map(function(a){
  return(a+1)
}) # 여기다 함수를 바로 넣어서 쓸 수도 있음. 
map(theList,function(a){a+1}) # anonymoust func형태로도 간단하게 만들어서 쓸 수 있음. 
# 각각 반환값 유형에 따라 함수_(형식)으로 구성. 
theList %>% map_int(NCOL) # 결과로 정수형 벡터를 원할 때. 열의 개수 반환 
 
# pmap 인자값을 2개를 넣을 수 있음.                     

