# 2520 is the smallest number that can be divided by each of the numbers from 1
# to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the
# numbers from 1 to 20?

include("Problems.jl")
include("factorization.jl")

function p005solution(n::Integer=20)::Integer

    # Find the number of prime factors for each number between 2 and n.  Store
    # the count of each prime factor, and then take the max number of that
    # prime factor for each number.  Multiply all the factors (exponentiated by
    # their max number) to ensure the result is evenly divisible.
    counts = zeros(Integer, n)
    for i in 2:n
        subcounts = Dict{Integer, Integer}()
        for j in primefactors(i)
            subcounts[j] = get(subcounts, j, 0) + 1
        end
        for k in subcounts
            counts[k[1]] = max(counts[k[1]], k[2])
        end
    end

    result = 1
    for i in 2:n
        if counts[i] > 0
            result = result * (i ^ counts[i])
        end
    end

    return result
end

p005 = Problems.Problem(p005solution)

Problems.benchmark(p005, 20)
