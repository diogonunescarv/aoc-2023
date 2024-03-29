# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

findNumber(s::AbstractString) = parse(Int, String([x for x in identity(s) if isdigit(x)]))
transformArray(s::AbstractString) = (split(s," "))
 
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
    global i = 1
    for s in seeds 
        if s in fnl:(fnl+pace-1) && !(i in positionsChanged) 
            seeds[i] = s - fnl + strt
            append!(positionsChanged, i)
        end
        global i += 1
    end
    return seeds
end 

function generateSeeds(seeds::Vector{Int})
    newSeeds = Int[]

    for i in 1:2:length(seeds)-1
        start = seeds[i]
        count = seeds[i+1]
        ns = start:start + count - 1
        append!(newSeeds, ns)
    end
    println("New Arraw: ", newSeeds)
    return newSeeds
end

function perform_mapping(data::Dict{Tuple{String,String},Matrix{Int}}, source::String, destination::String, numbers::Vector{UnitRange{Int}})
    M = data[(source, destination)]
    new = UnitRange{Int}[]
    while !isempty(numbers)
        mapped = false
        ran = pop!(numbers)
        for row ∈ axes(M, 1)
            inter = intersect(ran, M[row, 2]:M[row, 2]+M[row, 3]-1)
            if !isempty(inter)
                mapped = true
                push!(new, inter[1] - M[row,2] + M[row,1] : inter[end] - M[row,2] + M[row,1])
                left = ran[1]:inter[1]-1
                isempty(left) || push!(numbers, left)
                right = inter[end]+1:ran[end]
                isempty(right) || push!(numbers, right)
                break
            end
        end
        mapped || push!(new, ran)
    end
    return new
end

function part2(seeds::Vector{Int}, data::Dict{Tuple{String,String},Matrix{Int}})
    locations = Set{UnitRange{Int}}()
    chain = ("seed", "soil", "fertilizer", "water", "light", "temperature", "humidity", "location")
    seedstarts = seeds[1:2:end]
    seedlengths = seeds[2:2:end]
    for (ss, sl) ∈ zip(seedstarts, seedlengths)
        numbers = [ss:ss+sl-1]
        for (src, dest) ∈ zip(chain[1:end-1], chain[2:end])
            numbers = perform_mapping(data, src, dest, numbers)
        end
        push!(locations, numbers...)
    end
    return minimum(x -> x[1], locations)
end

# ============================================================================================
# Main

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\tst-day05.txt")

lines = split(rstrip(input), "\n")

global seeds = parse.(Int, split(strip(split(lines[1], ":")[2]), " "))

global seeds2 = generateSeeds(seeds)

data = Dict{Tuple{String,String},Vector{Int}}()

positionsChanged = []

for line in lines[2:end]
    if (line != "\n" && strip(line) != "" && occursin("map", line) === false)
        transf = parse.(Int,filter(x -> strip(x) != "",transformArray(line)))
        global seeds = modSeeds(seeds, transf[1], transf[2], transf[3])
        global seeds2 = modSeeds(seeds2, transf[1], transf[2], transf[3])
    else  
        deleteat!(positionsChanged, 1:length(positionsChanged)) 
    end 
end

# Part 1 

println("Part 1: ", minimum(seeds))



println("Part 2: ", seeds2) #not working yet