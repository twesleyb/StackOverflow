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
res2 <- score_network_hclust(k = 20)

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
                                parallel = TRUE, 
                                bulkNew = nThreads,
                                packages = c("WGCNA","igraph"), 
                                export = "data",
                                initPoints = 5, 
                                nIters = 1000,
                                gsPoints = 100, 
                                verbose = 1)

results$BestPars

