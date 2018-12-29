# The number, 1406357289, is a 0 to 9 pandigital number because it is made up
# of each of the digits 0 to 9 in some order, but it also has a rather
# interesting sub-string divisibility property.
# 
# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note
# the following:
# 
# d2d3d4 = 406 is divisible by 2
# d3d4d5 = 063 is divisible by 3
# d4d5d6 = 635 is divisible by 5
# d5d6d7 = 357 is divisible by 7
# d6d7d8 = 572 is divisible by 11
# d7d8d9 = 728 is divisible by 13
# d8d9d10 = 289 is divisible by 17
#
# Find the sum of all 0 to 9 pandigital numbers with this property.

using ProjectEulerSolutions

# Returns whether an array of digits matches the criterion.
function legal_value(vals::Array)
    return (vals[6] == 0 || vals[6] == 5) &&
           mod(vals[4], 2) == 0 &&
           mod(vals[3] + vals[4] + vals[5], 3) == 0 &&
           mod(100 * vals[5] + 10 * vals[6] + vals[7], 7) == 0 &&
           mod(100 * vals[6] + 10 * vals[7] + vals[8], 11) == 0 &&
           mod(100 * vals[7] + 10 * vals[8] + vals[9], 13) == 0 &&
           mod(100 * vals[8] + 10 * vals[9] + vals[10], 17) == 0
end

# Uses a helper function to generate permutations that all obey the specified
# "legal_value" criterion.
function p043solution(n::Integer=10)::Integer

    matrix = zeros(Integer, 0)
    permutation_matrix!(collect(0:(n-1)), matrix, legal_value)
    matrix = reshape(matrix, (n, fld(length(matrix), n)))

    return sum(transpose(10 .^ collect((n-1):-1:0)) * matrix)
end

p043 = Problems.Problem(p043solution)

Problems.benchmark(p043, 10)