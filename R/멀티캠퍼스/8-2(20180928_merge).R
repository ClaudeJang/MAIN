df1 <- data.frame(ID = c(1, 2, 3, 4, 5),
                  w = c('a', 'b', 'c', 'd', 'e'),
                  x = c(1, 1, 0, 0, 1),
                  y=rnorm(5),
                  z=letters[1:5])

df2 <- data.frame(ID = c(1, 7, 3, 6, 8),
                  a = c('z', 'b', 'k', 'd', 'l'),
                  b = c(1, 2, 3, 7, 4),
                  c =rnorm(5),
                  d =letters[2:6]) 

library(dplyr)
left_join(df1,df2,by="ID")
right_join(df1,df2,by="ID")
# inner join
merge(df1,df2,by="ID")
merge(df1,df2,by.x="ID",by.y="b",all =TRUE)
# left_join
merge(df1,df2,by="ID",all.x=TRUE)
# right_join
merge(df1,df2,by="ID",all.y =TRUE)
# full_join
merge(df1,df2,by="ID",all=TRUE)
# cross_join
merge(df1,df2,by=NULL)
