'singleton vesus components in random geometric graphs'
install.packages("spatgraphs")
library(spatgraphs)


isoVsComp <- function(g){
  a <-0
  for (j in 1:length(g$edges))
  {
    if (length(g$edges[[j]])==0) 
    {a <- a+1}
  }
  c(a,spatcluster(g)$nclusters)
}


'one-off simulation'
x <- matrix(runif(1000*2), ncol=2)
g1 <- spatgraph(x, "geometric", par=0.05)
isoVsComp(g1)
plot(g1,x, col='blue', points.pch=19, points.cex=0.2)


g2 <- spatgraph(x,"geometric", par=0.04)
isoVsComp(g2)
plot(g2,x, col='blue', points.pch=19, points.cex=0.2)

g3 <- spatgraph(x,"geometric", par=0.03)
isoVsComp(g3)
plot(g3,x, col='blue', points.pch=19, points.cex=0.2)

g4 <- spatgraph(x,"geometric", par=0.02)
isoVsComp(g4)
plot(g4,x, col='blue', points.pch=19, points.cex=0.2)

g5 <- spatgraph(x,"geometric", par=0.01)
isoVsComp(g5)
plot(g5,x, col='blue', points.pch=19, points.cex=0.2)

'hand-picked isolated pair when par=0.05'
segments(x[238,1],x[238,2],x[793,1],x[793,2],col = 'red')



'plot cluster'
clus<- spatcluster(g)
plot(clus,x, points.cex = 0.2)




'there is bug'
addSegment <- function(){
  isoPair <- NULL
  for (j in 1:999)
    for (k in (j+1):1000)
    {
      if (length(g$edges[[j]])==1 & length(g$edges[[k]])==1)
        isoPair <- rbind(c(j,k),isoPair)
    }
  for (i in nrow(isoPair))
    segments(x[isoPair[i,1],1], x[isoPair[i,1],2], x[isoPair[i,2],1], x[isoPair[i,2],2],col='red')
}


'duplicates'

P <- NULL
for (duplicate in 1:100)
{
  x <- matrix(runif(1000*2), ncol=2)
  g <- spatgraph(x, "geometric", par=0.05)
  P <- rbind(isoVsComp(g), P)
}

pred <- 1000*exp(-1000*pi*(0.05)^2)
sum(P[,2])/100
sum(P[,1])/(100*pred)
sum(- log(P[,2]/1000) / pi)/1000
sum(- log(P[,1]/1000) / pi)/1000
hist(P[,2])
hist(P[,2])
