# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

function findSolutions(time::Int, dist::Int)
    solutions = 0
    
    for speed in 0:time
        if (speed*(time-speed) > dist)
            solutions += 1
        end 
    end 
    
    return solutions
end

function findNumber(s::AbstractString)
    number = join(filter(x -> isdigit(x), s))
    return parse(Int, number)
end
# ============================================================================================
# Main

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\day06.txt")

lines = split(rstrip(input), "\n")

# Part 1

time1 = parse.(Int, split(strip(split(replace(lines[1], r"Time:\s*" => "Time:"), ":")[2]), "   "))
distance1 = parse.(Int, split(strip(split(replace(lines[2], r"Distance:\s*" => "Distance:"), ":")[2]), "   "))

global solutions1 = []

for (a,b) in zip(time1, distance1)
    append!(solutions1, findSolutions(a,b))
end

println("Part 1: ", reduce(*,solutions1))

# Part 2 

time2 = findNumber(replace(lines[1], r"Time:\s*" => "Time:"))
distance2 = findNumber(replace(lines[2], r"Distance:\s*" => "Distance:"))

global solutions2 = []

for (a,b) in zip(time2, distance2)
    append!(solutions2, findSolutions(a,b))
end

println("Part 2: ", reduce(*,solutions2))

# TO-DO - improve the blank spaces treatment.