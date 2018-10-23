library(ggplot2)
library(ggthemes)
colnames(diamonds)
g <- ggplot(data = diamonds,
       aes(x=carat,y=price,colour=clarity)) 
g2 <- g + geom_point() + theme_wsj()
g2

g3 <- ggplot(data = diamonds,
            aes(x=carat,y=price,colour=clarity)) 
g4 <- g3 + geom_point() + theme_bw()
g4

df5 <- read.csv("example_studentlist.csv")
df5
g6 <- ggplot(df5,
             aes(x=height,y=weight,colour=bloodtype))
g7 <- g6 + geom_point() + geom_line()
g7

g8 <- ggplot(df5, 
             aes(x=bloodtype)) + geom_bar()
g8

g8 <- ggplot(df5, 
             aes(x=bloodtype)) + geom_bar()
g8

g9 <- ggplot(df5, 
             aes(x=bloodtype,fill=sex)) + geom_bar()
g9 # 여자, 남자 구분 

g10 <- ggplot(df5, 
             aes(x=bloodtype,fill=sex)) + geom_bar(position = "dodge")
g10

g11 <- ggplot(df5, 
              aes(x=bloodtype,fill=sex)) + geom_bar(position = "dodge")
g11 # 남녀 따로 바 출력

g12 <- ggplot(df5, 
              aes(x=bloodtype,fill=sex)) + geom_bar(position = "identity")
g12 # 덮어씌운 것 

g13 <- ggplot(df5, 
              aes(x=bloodtype,fill=sex)) + geom_bar(position = "fill")
g13


