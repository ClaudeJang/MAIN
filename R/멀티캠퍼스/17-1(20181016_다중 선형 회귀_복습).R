# linear Regression
# -1 < x < 1
x <- c(150, 171, 138,186,128,136,179,152,131,140)
y <- c(63,81,56,91,47,57,76,72,62,42)

lm_data <- lm(y ~ x)

lm_data
# y = -33.7351 + 0.6515 * x
summary(lm_data)
x1 <- data.frame(x=170)
x1
predict(lm_data, x1) # x1 데이터에 대한 y(몸무게) 예측 
plot(x, y, col = "blue") # 
abline(lm_data, cex= 1.3, pch= 16)

#abline(lm(y~x)) 
#plot(y, x, col="blue")
#abline(lm(x~y),cex=1.3, pch=16)

# dplyr - join, group_by, mutate, summarise etc. 
# multiple regression - y = c + a1x1 + a2x2 + a3x3 .....
# lm(y ~ x1 + x2)
df <- mtcars[,c("mpg","disp","hp","wt")]
# cylinder displacement("disp")
# hp : horse
# wt : car's weight

lm_data2 <- lm(df$mpg ~ df$disp + df$hp + df$wt)
# mpg = (-0.000937 * disp) + (-0.031157 * hp) + (-3.800891 * wt) + 37.105505 
summary(lm_data2)
options(scipen = 999)
