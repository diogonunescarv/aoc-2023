# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

findNumber(s::AbstractString) = String([x for x in identity(s) if isdigit(x)])
#parse(Int, )
# ============================================================================================
# Main

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\tst-day03.txt")

lines = split(rstrip(input), "\n")

global stringNumber = ""

for (i,line) in lines
    println(position(i,line))
    for c in line
        if(isdigit(c))
            stringNumber *= c
        else 
            if (stringNumber != "")
                #println(stringNumber)
                #print(findprev(stringNumber,line,1))
                global stringNumber = ""
                
            end 
        end
    end 
end 