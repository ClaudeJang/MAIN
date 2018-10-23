member <- c("정호", "영재", "은경","민호","보란","정","훈","꽝")
data <- data.frame(member)
for (i in 2:20){
  data[i] <-sample(x=rep(1:8,i), size=8,replace=T)
}
colnames(data) <- c("MEMBER",paste0(c(1:19),"회차"))
data$MEAN <- rowSums(data[,2:20])/19
data$RANK <- round(rank(-data$MEAN),0)

data$TEAM<-gsub(1,"A팀",data$RANK) 
data$TEAM<-gsub(2,"A팀",data$TEAM)
data$TEAM<-gsub(3,"B팀",data$TEAM)
data$TEAM<-gsub(4,"B팀",data$TEAM)
data$TEAM<-gsub(5,"C팀",data$TEAM)
data$TEAM<-gsub(6,"C팀",data$TEAM)
data$TEAM<-gsub(7,"D팀",data$TEAM)
data$TEAM<-gsub(8,"D팀",data$TEAM)
data[,c(1,23)]


#  for (k in 1:2){
#  data$TEAM <- gsub(1,"A팀",data$RANK)
  data$TEAM <- gsub(k,"A팀",data$TEAM)
#for (k in 3:4){
#    data$TEAM <- gsub(k,"B팀",data$TEAM)


data$TEAM <- ifelse(data$RANK == "1" | data$RANK == "2", "A팀", 
                     ifelse(data$RANK == "3" | data$RANK =="4", "B팀",
                             ifelse(data$RANK== "5" | data$RANK =="6","C팀","D팀")))
data 
