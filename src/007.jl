# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
# that the 6th prime is 13.
#
# What is the 10,001st prime number?

include("Problems.jl")
include("sequence.jl")

function p007solution(n::Integer=10_001)::Integer

    # Roughly estimate the values of the n'th prime
    x = floor(Integer, n^(1.2))
    while x / log(x) < n
        x += n
    end

    res = seive_eratosthenes(x)
    return res[n]
end

p007 = Problems.Problem(p007solution)

Problems.benchmark(p007, 10_001)