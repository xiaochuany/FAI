'merge sort implementation'
merge <- function(A, B){
  i<- 1
  j<- 1
  k <- 1
  C <- numeric(length(A)+length(B))
  while (i <= length(A) & j <= length(B)) {
  if (A[i] <= B[j]) {
    C[k] <- A[i]
    i<- i+1
    k<- k+1
  }
  else {
    C[k] <- B[j] 
    j <- j+1
    k<- k+1
    }
  }
  while(i<=length(A)){
    C[k]<- A[i]
    i<- i+1
    k <- k+1
  }
  while(j<=length(B)){
    C[k]<- B[j]
    j <- j+1
    k <- k+1
  }
  C
}

mergeSort <- function(A){
  if (length(A)>1) {
    midPos <- floor(length(A)/2)
    X<-mergeSort(A[1:midPos])
    Y<-mergeSort(A[(midPos+1):length(A)])
    merge(X,Y)
  }
  else
  { A }
}



'piggybacking: count inversions'

sort_and_countSplitInv <- function(B, C){
  i<- 1; j<- 1; k<- 1
  count <- 0
  D<-numeric(length(B)+length(C))
  while(i<=length(B) & j<= length(C)){
    if (B[i]<= C[j]){
      D[k]<-B[i]
      i<- i+1
      k<- k+1
    }
    else{
      D[k]<-C[j]
      j<-j+1
      k<-k+1
      count <- count+ length(B)-i+1
    }
  }
  while(i<=length(B)){
    D[k]<-B[i]
    i<- i+1
    k<- k+1
  }
  while(j<=length(C)){
    D[k]<-C[j]
    j<-j+1
    k<-k+1
  }
  list(D,count)
}


sort_and_countInv <- function(A){
  if (length(A)==1)
    list(A,0)
  else{
    B <- A[1:floor(length(A)/2)]
    C <- A[(floor(length(A)/2)+1):length(A)]
    scB <- sort_and_countInv(B)
    scC <- sort_and_countInv(C)
    splitBC <- sort_and_countSplitInv(scB[[1]],scC[[1]])
    list(splitBC[[1]], scB[[2]]+scC[[2]]+ splitBC[[2]])
  }
}

