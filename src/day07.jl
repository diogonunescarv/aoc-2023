# Structs

struct Hand
    hand::AbstractString
    bet::Int
    evaluateHand::Int
end

# Functions 

function readInput(path::String) 
    s = open(path, "r") do file
         read(file, String)
     end
     return s
end

function custom_order(pair)
    hand, _ = pair
    substituted_hand = join(get(subs, c, c) for c in hand)
    return getOrder(substituted_hand)
end

function getOrder(letter)
    index = findfirst(x -> x == letter, cardsOrder)
    return isnothing(index) ? length(cardsOrder) + 1 : index
end

function substituteValues(s::AbstractString, joker::Bool)

    if (joker)

        return replace(s, 
            "A" => "E",
            "K" => "D",
            "Q" => "C",
            "T" => "A",
            "J" => "1",
        )
    end   

    return replace(s, 
        "A" => "E",
        "K" => "D",
        "Q" => "C",
        "J" => "B",
        "T" => "A"
    )

end

function substituteJoker(s::AbstractString)
    
    values = Dict{AbstractString, Int64}()

    for card in s 
        
        if haskey(values, string(card))
            values[string(card)] += 1 
        else 
            values[string(card)] = 1 
        end

    end
    
    global aux = 1
    global changeKey = "a"

    for (key, value) in values
        
        if (value > 1 && value > aux && key != "J")
            global aux = value
            global changeKey = key
        end 

    end

    if (aux != 1)
        s = replace(s, "J" => changeKey)
    end

    return s

end

function compareHandsPt1(hand1::Hand, hand2::Hand)

    if hand1.evaluateHand != hand2.evaluateHand
        return hand1.evaluateHand < hand2.evaluateHand
    end

    h1 = substituteValues(hand1.hand, false)
    h2 = substituteValues(hand2.hand, false)
    
    return h1 < h2 

end

function compareHandsPt2(hand1::Hand, hand2::Hand)

    if hand1.evaluateHand != hand2.evaluateHand
        return hand1.evaluateHand < hand2.evaluateHand
    end

    h1 = substituteValues(hand1.hand, true)
    h2 = substituteValues(hand2.hand, true)
    
    return h1 < h2 

end

function ordenation(lines::Vector{SubString{String}}, joker::Bool)
    
    for (i, line) in enumerate(lines) 
        hand, bet = split(line, " ")
        
        if (joker)

            if occursin("J", hand)
                hand = substituteJoker(hand)
            end

            handtype = sort([count(==(i), hand) for i in unique(hand)]; rev=true)
            
        else 
            handtype = sort([count(==(i), hand) for i in unique(hand)]; rev=true)
        end
        #println(handtype)
        h = Hand(hand, parse(Int, bet), combinations[handtype])
        push!(handBet, h)
    end 

    if joker
        orderedHandBet = sort(handBet, lt=compareHandsPt2)
    else 
        orderedHandBet = sort(handBet, lt=compareHandsPt1)
    end
    

    return orderedHandBet
end

# ============================================================================================
# Main

input::String = readInput("c:\\Users\\User\\Desktop\\Codes\\aoc-2023\\input\\day07.txt")

lines = split(rstrip(input), "\n")

combinations = Dict(
    [5] => 10,
    [4, 1] => 9,
    [3, 2] => 8,
    [3, 1, 1] => 7,
    [2, 2, 1] => 6,
    [2, 1, 1, 1] => 5,
    [1, 1, 1, 1, 1] => 4
)

global handBet = []

# Part1

part1 = ordenation(lines, false)
total_value1 = reduce((total, (index, h)) -> total + h.bet * index, enumerate(part1), init=0)

# Part2
handBet = []
part2 = ordenation(lines, true)
total_value2 = reduce((total, (index, h)) -> total + h.bet * index, enumerate(part2), init=0)

println("Part1:", total_value1)

println("Part2:", total_value2)