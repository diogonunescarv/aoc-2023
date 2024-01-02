# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

findNumber(s::AbstractString) = parse(Int, String([x for x in identity(s) if isdigit(x)]))

# ============================================================================================
# Main

colorDict = Dict("red" => 12, "green" => 13, "blue" => 14)

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\day02.txt")

lines = split(rstrip(input), "\n")

# Part 1

global sum1 = 0

for line in lines
    check = true
    game, gameData = split(line, ":")
    id = findNumber(game)
    v = split(gameData, ";")
    for turn in v
        round = split(turn,",")
        for balls in round
            n, color = split(balls)
            if parse(Int, n) > get(colorDict, color, 0)
                check = false
            end
        end 
    end
    if (check)
        global sum1 += id
    end
end 

println(sum1)

# Part 2

colorDict2 = Dict("red" => 0, "green" => 0, "blue" => 0)

global sum2 = 0

for line in lines
    game, gameData = split(line, ":")
    id = findNumber(game)
    v = split(gameData, ";")
    for turn in v
        round = split(turn,",")
        for balls in round
            n, color = split(balls)
            n = parse(Int, n)
            if n > get(colorDict2, color, 0)
                colorDict2[color] = n
            end
        end 
    end
    p1 = reduce(*, values(colorDict2))
    global sum2 += p1

    for (chave, valor) in colorDict2
        colorDict2[chave] = 0
    end

end 



print(sum2)