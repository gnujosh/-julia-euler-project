# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#
# Find the sum of all numbers which are equal to the sum of the factorial of
# their digits.
#
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

include("Problems.jl")

# Precompute one digit factorials, use mapreduce to quickly calculate sums of
# factorials of digits.
function p034solution()::Integer
    facs = map(factorial, 0:9) # precompute digit factorials

    sums = 0
    for i in 11:99999 # Arbitrary upper bound?
        if mapreduce(x -> facs[x + 1], +, digits(i)) == i
            sums += i
        end
    end
    return sums
end

p034 = Problems.Problem(p034solution)

Problems.benchmark(p034)