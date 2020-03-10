library(ggplot2)
require(GGally)

ggparcoord(iris, columns=1:4, scale="uniminmax")+xlab("")+ylab("") 
ggparcoord(iris, columns=1:4, groupColumn="Species")
hcav <- hclust(dist(USArrests), method="ave")
clu3 <- cutree(hcav, k=3)
clus <- factor(clu3)
usa1 <- cbind(USArrests, clus)
ggparcoord(usa1, columns=1:4, groupColumn="clus", scale="uniminmax", mapping = aes(size = 1)) + ggplot2::scale_size_identity() + xlab("") +  ylab("") + theme(legend.position = "none")
 
ggparcoord(usa1, columns=1:4, groupColumn="clus", scale="globalminmax", mapping = aes(size = 1)) +ggplot2::scale_size_identity() + xlab("") +  ylab("") + theme(legend.position = "none")
