library(ggplot2)
require(GGally)
data <- diamonds[1:5000]

ggparcoord(data, columns=5:7, scale="uniminmax")+xlab("")+ylab("") 
ggparcoord(data, columns=5:7, groupColumn="cut")
hcav <- hclust(dist(data), method="ave")
clu3 <- cutree(hcav, k=5)
clus <- factor(clu3)
data2 <- cbind(data, clus)
ggparcoord(data2, columns=5:7, groupColumn="clus", scale="uniminmax", mapping = aes(size = 1)) + ggplot2::scale_size_identity() + xlab("") +  ylab("") + theme(legend.position = "none")
 
ggparcoord(data2, columns=5:7, groupColumn="clus", scale="globalminmax", mapping = aes(size = 1)) +ggplot2::scale_size_identity() + xlab("") +  ylab("") + theme(legend.position = "none")
