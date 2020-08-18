# How to update igraph membership?

# Generate a graph.
import igraph
g = igraph.Graph.Erdos_Renyi(n=100,m=250)

# Make a random partition of 4 clusters.
from random import randint
partition = [randint(0,3) for x in range(100)]

# Cluster the graph.
clusters = igraph.VertexClustering(g,membership = partition)

clusters.modularity

# Checks.
clusters.membership == partition # True
clusters.graph.clusters().membership == partition # False
