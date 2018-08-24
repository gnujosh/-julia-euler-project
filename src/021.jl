# Let d(n) be defined as the sum of proper divisors of n (numbers less than n
# which divide evenly into n).  If d(a) = b and d(b) = a, where a ≠ b, then a
# and b are an amicable pair and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
# 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
# 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.

include("Problems.jl")
include("factorization.jl")

# Use factor function and cache values so you don't recalculate.  Store in a
# set so you get unique values.
function p021solution(n::Integer=10_000)::Integer
    factor_sums = zeros(Integer, 5*n) # Initialize to some large size
    # I tried a dictionary and it was slower for this problem
    amicable_numbers = Set{Integer}()
    for i in 2:n
        s1 = factor_sums[i]
        if s1 == 0
            s1 = sum(factors(i))
            factor_sums[i] = s1
        end
        s2 = factor_sums[s1]
        if s2 == 0
            s2 = sum(factors(s1))
            factor_sums[s1] = s2
        end
        if s2 == i && s1 != s2
            push!(amicable_numbers, s1)
            push!(amicable_numbers, s2)
        end
    end
    return sum(amicable_numbers)
end

p021 = Problems.Problem(p021solution)

Problems.benchmark(p021, 10_000)