# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143?

include("Problems.jl")
include("factorization.jl")

function p003solution(n::Integer=600_851_475_143)::Integer
    return primefactors(n)[end]
end

p003 = Problems.Problem(p003solution)

Problems.benchmark(p003, 600_851_475_143)
