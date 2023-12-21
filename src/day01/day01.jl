# Functions

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

finalNumber(s::AbstractString) = s[1] * s[end]

function replaceStrings(s::SubString{String})
    s = replace(s,
        "twone" => "twoone",
        "oneight" => "oneeight",
        "threeight" => "threeeight",
        "fiveight" => "fiveeight",
        "sevenine" => "sevennine",
        "eightwo" => "eighttwo",
        "eighthree" => "eightthree")
    
    return replace(s, "one" => "1",
                      "two" => "2",
                      "three" => "3",
                      "four" => "4",
                      "five" => "5",
                      "six" => "6",
                      "seven" => "7",
                      "eight" => "8",
                      "nine" => "9")

end

# ==========================================================================================
# Main 

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\day01.txt")

lines = split(rstrip(input), "\n")

global sum1 = 0

# Part 1 

for line in lines
    s = (String([x for x in identity(line) if isdigit(x)]))
    if(s != "")
       global sum1 += parse(Int, finalNumber((s)))
    end
end

println(sum1)

#Part 2

global sum2 = 0

for line in lines
    s = (String([x for x in replaceStrings(line) if isdigit(x)]))
    if(s != "")
       global sum2 += parse(Int, finalNumber((s)))
    end
end

print(sum2)


