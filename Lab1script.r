trees

names(trees)

attributes(trees)

pairs(trees)
plot(trees$Girth,trees$Height)


plot(trees$Girth,trees$Height, col=15)
plot(trees$Girth,trees$Height, col=20)
title(main = "Height vs Girth in Trees", col.main=3)





getwd()
lab1 = read.csv("lab1.csv")
lab1

pairs(lab1)
x = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)
plot(x, lab1$Rotten.Tomatoes, col=1, ylab= "Ratings: Rotten.Tomatoes (G) and IMDB Rating (B)") 
lines(x, lab1$Rotten.Tomatoes, col=3)
par(new = TRUE)
plot(x, lab1$Rating, col=1, axes=FALSE, xlab = "", ylab = "") 
lines(x,lab1$Rating, col=4)

plot(x, lab1$Rotten.Tomatoes, col=1, ylab= "Ratings: Rotten.Tomatoes (G) and IMDB Rating (B)") 
lines(x, lab1$Rotten.Tomatoes, col=3)
par(new = TRUE)
plot(x, lab1$Rating, col=1, axes=FALSE, xlab = "", ylab = "") 
lines(x,lab1$Rating, col=4)



png(filename="lab1.png")
plot(x, lab1$Gross.Boxoffice, col=1, ylab= "Gross (G) and Budget (B)") 
lines(x, lab1$Gross.Boxoffice, col=3)
par(new = TRUE)
plot(x, lab1$Budget, col=1, axes=FALSE, xlab = "", ylab = "") 
lines(x,lab1$Budget, col=4)
dev.off()
