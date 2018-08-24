# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

include("Problems.jl")
include("sequence.jl")

# Run Seive of Eratosthenes to get primes and sum them.
function p010solution(n::Integer=1_999_999)::Integer
    return sum(seive_eratosthenes(n))
end

p010 = Problems.Problem(p010solution)

Problems.benchmark(p010, 1_999_999)