module Catex

using Catlab
using Catlab.CategoricalAlgebra
using Catlab.Graphs
using Catlab.Graphics
using GraphViz

include("GenomicIntervals.jl")

local intervals::Vector{GenomicIntervals.GenomicInterval} = GenomicIntervals.read_genomic_intervals("test/resources/pacbio.hg19.intervals")
graph = GenomicIntervals.intervals_to_graph(intervals)
GraphViz.display(graph) # displays in table form
category = GenomicIntervals.graph_to_category(graph)
println(category)

end # module Catex
