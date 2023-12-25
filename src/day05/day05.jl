# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

findNumber(s::AbstractString) = parse(Int, String([x for x in identity(s) if isdigit(x)]))

transformArray(s::AbstractString) = split(s," ")

# ============================================================================================
# Main

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\tst-day05.txt")

lines = split(rstrip(input), "\n")

# Part 1 

getSeeds()

for line in lines 
    println(line)
end 