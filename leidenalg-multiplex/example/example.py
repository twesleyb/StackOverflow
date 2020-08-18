#!/usr/bin/env python3

import sys
import igraph
import leidenalg

## Example 1. Simple generated graphs.

# Create two graphs.
g0 = igraph.Graph.GRG(100, 0.2)
g1 = igraph.Graph.GRG(100,0.1)

# Multiplex partition.
partition = leidenalg.find_partition_multiplex([g0,g1],
        leidenalg.ModularityVertexPartition)

## Example 2. Some read graphs.

# Load the graphs.
g0 = igraph.Graph.Read_Pickle("g0.pickle")
g1 = igraph.Graph.Read_Pickle("g1.pickle")

# Enforce same vertex set.
subg0 = g0.induced_subgraph(g1.vs['name'])
subg1 = g1.induced_subgraph(subg0.vs['name'])

# Multiplex partition.
optimiser = leidenalg.Optimiser()
partition = leidenalg.find_partition_multiplex([subg0,subg1],
        leidenalg.ModularityVertexPartition)
