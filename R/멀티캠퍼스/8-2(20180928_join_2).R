library(magrittr) # %>% 


t <- 1
f <- function(x, add=1){
  x+add
} # t와 x로 변수 다르게 주고 
 
f(t, add=2) # 함수형태로 
# pipe식으로 바꾸면 
s <- 3
t %>% f(s,add=.) # = f(t)0
# .$ <- 온점이 참조되는 변수를 의미함. 
t %>% f(1,add=.) # 여기서 .은 t를 의미하게 된다. 
f(f(f(x,1),2),3) # 계산은 되지만 상당히 복잡해 보인다. 
# 더 쉽게
x %>% f(.,1) %>% f(.,2) %>% f(.,3) 
# = x%>% f(1) %>% f(2) %>% f(3)

# log, users, items
set.seed(1) # 샘플링 데이터 추출 
log <- data.frame(
  id <- 1:10,
  user_id = sample(c(1,2,3),10,TRUE),
  item_id = sample(c(1,2,3),10,TRUE),
  correct = sample(c(0,1),10,TRUE)
) %>% as.tbl

users <- data.frame(
  id =c(1,2,3,4),
  age= c(21,24,30,21)
) %>% as.tbl

items <- data.frame(
  id = 1:3,
  item =c("1+1","2*2","3/3")
) %>% as.tbl
class(log)
items
# join 해보기
library(dplyr)
#distinct(log,user_id) # user_id가 3개
#left_join(users,log,by="id")
#inner_join(users,log,by="id") # 왼쪽, 오른쪽 기준 없이 같은 부분만 추출, 4번이 안 나오게 된다.
#full_join(users,log,by="user_id")
#anti_join(users,log,by="user_id")
#semi_join(users,log,by="user_id")

log %>% 
  left_join(users,c("user_id" ="id")) %>%
  left_join(items,c("item_id" ="id")) 


  