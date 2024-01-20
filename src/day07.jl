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

function substituteValues(s::AbstractString)
        
    return replace(s, 
        "A" => "E",
        "K" => "D",
        "Q" => "C",
        "J" => "B",
        "T" => "A"
    )

end

function compareHands(hand1::Hand, hand2::Hand)

    if hand1.evaluateHand != hand2.evaluateHand
        return hand1.evaluateHand < hand2.evaluateHand
    end

    h1 = substituteValues(hand1.hand)
    h2 = substituteValues(hand2.hand)
    
    return h1 < h2 
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

for (i, line) in enumerate(lines) 
    hand, bet = split(line, " ")
    handtype = sort([count(==(i), hand) for i in unique(hand)]; rev=true)
    h = Hand(hand, parse(Int, bet), combinations[handtype])
    push!(handBet, h)
end 

orderedHandBet = sort(handBet, lt=compareHands)

total_value = reduce((total, (index, h)) -> total + h.bet * index, enumerate(orderedHandBet), init=0)

println("Part1:", total_value)


