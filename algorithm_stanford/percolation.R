'percolation 2d square lattice'
'divide and conquer'


library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)

EMPTY    = 0
OCCUPIED = 1
FLOW     = 2

create.grid <- function(N, p) {
  grid = matrix(rbinom(N^2, 1, p), nrow = N)
  #
  attributes(grid)$p = p
  #
  return(grid)
}

set.seed(1)
p1<-create.grid(40,0.3)
p2<-create.grid(40,0.6)

visualise.grid <- function(g) {
     N = nrow(g)
     #
      limits = c(0, N) + 0.5
      #
         ggplot(melt(g[nrow(g):1,], 1, varnames = c("row", "col"), value.name = "occupied")) +
          geom_tile(aes(x = col, y = row, fill = factor(occupied))) +
           geom_hline(yintercept = limits, size = 2) +
           geom_vline(xintercept = limits, size = 2) +
           xlim(limits) + ylim(limits) +
           coord_fixed(ratio = 1) +
          scale_fill_manual(values = c("white", "grey", "lightblue")) +
           theme(panel.background = element_blank(),
                            axis.title = element_blank(),
                             axis.text = element_blank(),
                             axis.ticks = element_blank(),
                             legend.position = "none"
                             )
     }
 
 grid.arrange(visualise.grid(p1), visualise.grid(p2), ncol = 2)
 
 flow <- function(g, i = NA, j = NA) {
  # -> Cycle through cells in top row
  #
   if (is.na(i) || is.na(j)) {
            for (j in 1:ncol(g)) {
                g = flow(g, 1, j)
              }
           return(g)
          }
    #
    # -> Check specific cell
    #
    if (i < 1 || i > nrow(g) || j < 1 || j > ncol(g)) return(g)
    #
    if (g[i,j] == OCCUPIED || g[i,j] == FLOW) return(g)
    #
          g[i,j] = FLOW
        
          g = flow(g, i+1, j)        # down
          g = flow(g, i-1, j)        # up
          g = flow(g, i, j+1)        # right
          g = flow(g, i, j-1)        # left
          
        g
       }
 
 grid.arrange(visualise.grid(flow(p1)), visualise.grid(flow(p2)), ncol = 2)
 