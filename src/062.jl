# The cube, 41063625 (345^3), can be permuted to produce two other cubes:
# 56623104 (384^33) and 66430125 (405^33). In fact, 41063625 is the smallest
# cube which has exactly three permutations of its digits which are also cube.
#
# Find the smallest cube for which exactly five permutations of its digits are
# cube.

using ProjectEulerSolutions

# For each fixed number of digits, search through the right ranges of numbers
# to build up sets of cubes.  Store them as sorted tuples, counting the number
# that match to the same key.  When we hit 5, return the smallest.
function p062solution(n::Integer=5)::Integer

    ndig_max = ndigits(2^63-1) - 1  # Bigger than 18 and we will need to use BigInts
    for ndig in 9:ndig_max

        dict = Dict{Tuple, Array{Integer,1}}()
    
        num_low = Integer(ceil(10^((ndig-1)/3)))
        num_high = Integer(floor(10^(ndig/3)))
        max_count = 1
        max_key = 1

        for i in num_low:num_high
            num = i^3
            key = Tuple(sort(digits(num)))
            if haskey(dict, key)
                append!(dict[key], num)
            else
                dict[key] = [num]
            end
            c = length(dict[key])
            if max_count < c
               max_count = c
               if max_count == n
                   return minimum(dict[key])
               end
            end
        end
    end
    return -1
end

p062 = Problems.Problem(p062solution)

Problems.benchmark(p062, 5)
