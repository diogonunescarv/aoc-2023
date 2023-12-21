# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

findNumber(s::AbstractString) = parse(Int, String([x for x in identity(s) if isdigit(x)]))

transformArray(s::AbstractString) = split(s," ")

function part2(winning_numbers::Vector{Vector{Int}}, my_numbers::Vector{Vector{Int}})
    ncards = ones(Int, length(winning_numbers))
    for (i, (w, m)) ∈ enumerate(zip(winning_numbers, my_numbers))
        ncards[i+1:i+length(intersect(w, m))] .+= ncards[i]
    end
    return ncards |> sum
end

# ============================================================================================
# Main

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\tst-day04.txt")

lines = split(rstrip(input), "\n")

# Part 1 

global sum1 = 0

for line in lines
    game, gameData = split(line, ":")
    id = findNumber(game)
    winingNumb, myNumb = split(gameData, "|")
    winingNumb = parse.(Int,filter(x -> strip(x) != "",transformArray(winingNumb)))
    myNumb = parse.(Int,filter(x -> strip(x) != "",transformArray(myNumb)))
    equal = intersect(winingNumb, myNumb)
    matches = length(equal)
    if (matches > 0)
        global sum1 += (2^(matches - 1))
    end
    
end 

#println(sum1)

# Part 2

global sum2 = 0

for line in lines
    nextCard = 0
    cardValue = 1
    game, gameData = split(line, ":")
    id = findNumber(game)
    winingNumb, myNumb = split(gameData, "|")
    winingNumb = parse.(Int,filter(x -> strip(x) != "",transformArray(winingNumb)))
    myNumb = parse.(Int,filter(x -> strip(x) != "",transformArray(myNumb)))
    equal = intersect(winingNumb, myNumb)
    matches = length(equal)
    
    if (matches > 0)
        global sum2 += (nextCard > 0 ? (nextCard - cardValue) : cardValue)
        if (nextCard == 0)
            nextCard += matches
        else 
            nextCard -= cardValue
        end 
    else 
        global sum2 += (nextCard - cardValue)
    end
    println(nextCard) 
end 

