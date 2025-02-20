module GenomicIntervals

using Catlab
using Catlab.Graphs

struct GenomicInterval
    chrom::String
    start::Int
    stop::Int
end

export read_genomic_intervals
export intervals_to_category
export intervals_to_graph
export GenomicInterval

function read_genomic_intervals(file_path::String)::Vector{GenomicInterval}
    intervals = GenomicInterval[]
    open(file_path, "r") do file
        for line in eachline(file)
            if !startswith(line, "#") && !isempty(line)
                chrom, locus = split(line, ':')
                start, stop = split(locus, '-')
                push!(intervals, GenomicInterval(chrom, parse(Int, start), parse(Int, stop)))
            end
        end
    end
    return intervals
end

# convert a Graph into a category
function graph_to_category(graph::Graph)
    # Create a new FiniteCategory
    return FinCatGraph(graph)
end

function intervals_to_graph(intervals::Vector{GenomicInterval})::Graph
    g = Graph()
    add_parts!(g, :V, length(intervals)+1)
    add_parts!(g, :E, length(intervals), src=1:length(intervals), tgt=2:length(intervals)+1)
    return g
end

end # module GenomicIntervals
