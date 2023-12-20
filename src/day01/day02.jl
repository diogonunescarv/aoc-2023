function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

finalNumber(s::AbstractString) = s[1] * s[end]

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\day01.txt")

lines = split(rstrip(input), "\n")

global soma = 0

for line in lines
    s = (String([x for x in identity(line) if isdigit(x)]))
    if(s != "")
       global soma += parse(Int, finalNumber((s)))
    end
end

print(soma)
