# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

include("Problems.jl")
include("sequences.jl")

function p004_sol(N::Integer=600_851_475_143)::Integer
    return get_prime_factors(N)[end]
end

p004 = Problems.Problem(p004_sol)

Problems.benchmark(p004, 600_851_475_143)