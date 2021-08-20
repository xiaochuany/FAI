'
closest pair problem in 2d

divide and conquer (due to ???)

closestPair(P)
Step 1: sort according to x variable and y variable, leading to orderings P_x and P_y. Let xbar be the medium x-variable of P.
Step 2: divide P_x into left half Q_x and right half R_x, then solve recursively closestPair(Q_x) and closestPair(R_x)
Step 3: set delta = min(dist left optimal pair, dist right optimal pair)
Step 4: find the optimal split pair with dist < delta by splitPair(P,delta)
Step 5: return the optimal among the three pairs

splitPair(P,xbar,delta)
Step 1: set S_y = subset of P_y such that the x-variable is within delta of the medium. 
Step 2: 
initialize best = delta, bestPair = null
for j = 1:(|S_y|-7) for k = 1:7  
if dist(S_y[i], S_y[j]) < best,  
set best = dist(S_y[i], S_y[j]) and bestPair = (S_y[i], S_y[j])
Step 3: return bestPair
'


dist <- function(a,b)
{
  sqrt(sum((a-b)^2))
}

splitPair <- function(P_y, xbar, delta){
  S_y <- P_y[ P_y[,1] <= xbar +delta & P_y[,1] >= xbar - delta, ]
  best <- delta
  bestPair <- NULL
  if (is.null(S_y) |  nrow(S_y)==1)
    list(best,bestPair)
  else
  {
    if (nrow(S_y)<=7)
    {
      for (i in 1: (nrow(S_y)-1))
        for (l in (i+1):nrow(S_y))
        {
          if (dist(S_y[i,], S_y[l,]) < best )
          {
            best <- dist(S_y[i,], S_y[l,])
            bestPair <- rbind(S_y[i,], S_y[l,])
          }
        }
      list(best,bestPair)
    }
    else
    {
      for (j in 1: (nrow(S_y)-7))
        for (k in 1: min(7, nrow(S_y)-j) )
        {
          if (dist(S_y[j,], S_y[j+k,]) < best )
          {
            best <- dist(S_y[j,], S_y[j+k,])
            bestPair <- rbind(S_y[j,], S_y[j+k,])
          }
        }
      list(best, bestPair)
    }
  }
}

closestPair <- function(P)
{
  if(nrow(P)<=5)
  { 
    best <- dist(P[1,],P[2,])
    bestPair <- rbind(P[1,],P[2,])
    for (i in 1:(nrow(P)-1))
      for (j in (i+1):nrow(P))
      {
        if (dist(P[i,], P[j,]) < best )
        {
          best <- dist(P[i,], P[j,])
          bestPair <- rbind(P[i,], P[j,])
        }
      }
    list(best,bestPair)
  }
  else
  {'we could have written our own sort method by generalising the mergeSort file'
    P_x <- P[order(P[,1]),]
    P_y<- P[order(P[,2]),]
    xbar <- P_x[floor(nrow(P_x)/2),1]
    Q_x <- P_x[P_x[,1]<= xbar,]
    R_x <- P_x[P_x[,1]> xbar,]
    leftSol <- closestPair(Q_x)
    rightSol <- closestPair(R_x)
    delta <- min(leftSol[[1]], rightSol[[1]])
    splitSol <- splitPair(P_y, xbar, delta)
    if (splitSol[[1]]<delta)
    {
      splitSol
    }
    else
    {
      if (leftSol[[1]] <= rightSol[[1]]) 
        leftSol
      else
        rightSol
    }
  }
}

