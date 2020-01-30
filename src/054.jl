# In the card game poker, a hand consists of five cards and are ranked, from
# lowest to highest, in the following way:
#
# High Card: Highest value card.
# One Pair: Two cards of the same value.
# Two Pairs: Two different pairs.
# Three of a Kind: Three cards of the same value.
# Straight: All cards are consecutive values.
# Flush: All cards of the same suit.
# Full House: Three of a kind and a pair.
# Four of a Kind: Four cards of the same value.
# Straight Flush: All cards are consecutive values of same suit.
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
#
# If two players have the same ranked hands then the rank made up of the highest
# value wins; for example, a pair of eights beats a pair of fives (see example 1
# below). But if two ranks tie, for example, both players have a pair of queens,
# then highest cards in each hand are compared (see example 4 below); if the
# highest cards tie then the next highest cards are compared, and so on.
#
# Consider the following five hands dealt to two players:
#
# Hand  Player 1          Player 2           Winner
# 1     5H 5C 6S 7S KD    2C 3S 8S 8D TD     Player 2
#       Pair of Fives     Pair of Eights
#
# 2     5D 8C 9S JS AC    2C 5C 7D 8S QH     Player 1
#       Highest card Ace  Highest card Queen
#
# 3     2D 9C AS AH AC    3D 6D 7D TD QD     Player 2
#       Three Aces        Flush with Diamonds
#
# 4     4D 6S 9H QH QC    3D 6D 7H QD QS     Player 1
#       Pair of Queens    Pair of Queens
#       Highest card Nine Highest card Seven
#
# 5     2H 2D 4C 4D 4S     3C 3D 3S 9S 9D    Player 1
#       Full House         Full House
#       With Three Fours   with Three Threes
#
# The file, poker.txt, contains one-thousand random hands dealt to two players.
# Each line of the file contains ten cards (separated by a single space): the
# first five are Player 1's cards and the last five are Player 2's cards. You
# can assume that all hands are valid (no invalid characters or repeated cards),
# each player's hand is in no specific order, and in each hand there is a clear
# winner.
#
# How many hands does Player 1 win?

using ProjectEulerSolutions

# Define a unique score for every hand such that a winning hand will score
# higher than a losing hand.
function score_hand(hand::BitArray{2})::Float32
    sum_across_suits = sum(hand, dims=2)[:]
    is_flush = maximum(sum(hand, dims=1)) == 5

    single_index = findall(sum_across_suits .== 1)
    pair_index = findall(sum_across_suits .== 2)

    no_multiple_numbers = maximum(sum_across_suits) == 1
    nonzero_numbers = findall(sum_across_suits .> 0)

    max_value = nonzero_numbers[end]

    if no_multiple_numbers && nonzero_numbers[end] - nonzero_numbers[1] == 4
        if is_flush # straight or royal flush
            return 100000 + max_value
        else # straight
            return 50000 + max_value
        end
    elseif is_flush # flush
        # Check score by largest value, then next largest, etc
        return 60000 + sum([0.0001, 0.01, 1, 14, 14 * 14] .* nonzero_numbers)
    end
    if maximum(sum_across_suits) == 4 # 4 of a kind
        return 80000 + 14 * findall(sum_across_suits .== 4) + single_index[1]
    end
    if maximum(sum_across_suits) == 3
        three_index = findall(sum_across_suits .== 3)
        if length(pair_index) == 1 # Full house
            return 70000 + 14 * three_index[1] + pair_index[1]
        else # 3 of a kind
            return 40000 + 14 * single_index[2] + single_index[1]
        end
    end
    if length(pair_index) == 2 # 2 pair
        return 10000 + sum([14, 14*14] .* pair_index) + single_index[1]
    elseif length(pair_index) == 1 # 1 pair
        return 4000 + 14 * 14 * pair_index[1] + sum([0.01, 1, 14] .* single_index)
    else  # high card
        return sum([0.0001, 0.01, 1, 14, 14 * 14] .* single_index)
    end
end


function p054solution(path::String="")::Integer
    if !isfile(path)
        if path != ""
            println("Cannot find path: '", path, "'")
        end
        return -1
    end

    # Fill in card indexes into hand
    card_inds = Dict{String, Tuple{Integer, Integer}}()
    for (i, vi) in enumerate(['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'])
        for (j, sj) in enumerate(['C', 'S', 'H', 'D'])
            card_inds[vi * sj] = (i, j)
        end
    end

    count = 0
    open(path) do file
        for row in eachline(file)
            inds = map(x -> card_inds[x], split(row, ' '))
            hand1 = falses(13,4)
            hand2 = falses(13,4)
            for i in 1:5
                hand1[inds[i]...] = true
                hand2[inds[i+5]...] = true
            end
            if score_hand(hand1) > score_hand(hand2)
                count += 1
            end
        end
    end

    return count
end

p054 = Problems.Problem(p054solution)

input_path = "data/p054_poker.txt"

Problems.benchmark(p054, input_path)
