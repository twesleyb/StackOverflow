#------------------------------------------------------------------------------
## Prepare the workspace.
#------------------------------------------------------------------------------

rm(list = ls())
if (.Device != "null device" ) dev.off()
cat("\f")
options(stringsAsFactors = FALSE)

# Insure no other packages are loaded.
#library(magrittr)
#library(JGmisc)
#detachAllPackages(keep = NULL)

# Load dependencies:
suppressPackageStartupMessages({
  library(ParBayesianOptimization)
  library(WGCNA)
  library(igraph)
  library(doParallel)
})

# Set the working directory.
rootdir <- "D:/projects/StackOverflow/hyperparameter-optimization"
setwd(rootdir)

# Get the data from github.
url <- "https://github.com/twesleyb/StackOverflow/raw/master/hyperparameter-optimization/data/data.RDS"
data <- readRDS(gzcon(url(url)))
dim(data)
data[1:5,1:5]

# Allow parallel calculations:
allowWGCNAThreads()
nThreads <- detectCores(all.tests = FALSE, logical = TRUE)
clusterLocal <- makeCluster(c(rep("localhost", nThreads)), type = "SOCK")
registerDoParallel(clusterLocal)

#------------------------------------------------------------------------------
## Define a function to be optimized.
#------------------------------------------------------------------------------

# Perform heirarchical clustering of data. Cut into k groups. Overall quality,
# is described by the network partitions modularity, q.

score_network_hclust <- function(k){
  # Calculate the signed adjaceny matrix of data.
  # Perform heirarchical clustering and divide into k groups.
  r <- 1 - bicor(t(data))
  adjm <- ((1 + r) / 2)^12 # Signed, weighted adjacency matrix. 
  diss <- 1 - adjm
  diag(diss) <- 0
  hc <- hclust(as.dist(diss), method = "average")
  membership <- cutree(hc, k)
  g <- graph_from_adjacency_matrix(adjm, mode = "undirected", weighted = TRUE)
  q <- modularity(g, membership, weights = edge_attr(g, "weight"))
  return(list(Score = q, dendro = hc))
}

# Before proceeding, test the function:
res1 <- score_network_hclust(k = 2)
res2 <- score_network_hclust(k = 20) # should be a better fit.

# Examine the results.
res1$Score
res2$Score
plot(res1$dendro, labels = FALSE)

#------------------------------------------------------------------------------
## Perform Bayesian optimization.
#------------------------------------------------------------------------------

# What is the optimal number of heirarchical groups to divide the network into?

# BayesianOptimization:
results <- BayesianOptimization(FUN = score_network_hclust, 
                                bounds = list(k = c(2L,1000L)), # maximum number of clusters is number of proteins...
                                packages = c("WGCNA","igraph"), 
                                export = "data",
                                initPoints = 3, 
                                nIters = 10,
                                gsPoints = 1,
                                parallel = TRUE,
                                bulkNew = nThreads,
                                verbose = 1)

results$BestPars

#------------------------------------------------------------------------------

score_network_hclust <- function(k){
  # Calculate the signed adjaceny matrix of data.
  # Perform heirarchical clustering and divide into k groups.
  r <- 1 - bicor(t(data))
  adjm <- ((1 + r) / 2)^12 # Signed, weighted adjacency matrix. 
  diss <- 1 - adjm
  diag(diss) <- 0
  hc <- hclust(as.dist(diss), method = "average")
  membership <- cutree(hc, k)
  g <- graph_from_adjacency_matrix(adjm, mode = "undirected", weighted = TRUE)
  q <- modularity(g, membership, weights = edge_attr(g, "weight"))
  return(list(Score = q, dendro = hc))
}

# Before proceeding, test the function:
res1 <- score_network_hclust(k = 2)
res2 <- score_network_hclust(k = 20) # should be a better fit.

# Examine the results.
res1$Score
res2$Score
plot(res1$dendro, labels = FALSE)
