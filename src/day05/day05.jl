# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

findNumber(s::AbstractString) = parse(Int, String([x for x in identity(s) if isdigit(x)]))
transformArray(s::AbstractString) = (split(s," "))

# function findSeeds(s::AbstractString)
#     st, nb = split(s,"seeds:")
#     seed = parse.(Int,filter(x -> strip(x) != "",transformArray(nb)))
#     return seed
# end 

function numericLine(line::AbstractString)
    parts = split(line, " ")
    for part in parts
        number = parse.(Int, part, nothing)
        if isnothing(number)
            return false
        end
    end
    return true
end

function modSeeds(seeds::Vector{Int}, strt::Int, fnl::Int, pace::Int)
    #println(strt," " , fnl, " ",pace)
    global i = 1
    for s in seeds 
        if s in fnl:(fnl+pace-1) && !(i in positionsChanged) 
            seeds[i] = s - fnl + strt
            push!(positionsChanged, i)
        end
        global i += 1
    end
    #println(seeds)
    return seeds
end 

# ============================================================================================
# Main

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\day05.txt")

lines = split(rstrip(input), "\n")

global seeds = parse.(Int, split(strip(split(lines[1], ":")[2]), " "))

data = Dict{Tuple{String,String},Vector{Int}}()

positionsChanged = []

for line in lines[2:end]
    if (line != "\n" && strip(line) != "" && occursin("map", line) === false)
        transf = parse.(Int,filter(x -> strip(x) != "",transformArray(line)))
        #println(transf)
        global seeds = modSeeds(seeds, transf[1], transf[2], transf[3])
        #println(seeds)
    else  
        deleteat!(positionsChanged, 1:length(positionsChanged)) 
    end 
end

# Part 1 

println("Part 1: ", minimum(seeds))