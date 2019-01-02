# The prime 41, can be written as the sum of six consecutive primes:
#
# 41 = 2 + 3 + 5 + 7 + 11 + 13
#
# This is the longest sum of consecutive primes that adds to a prime below
# one-hundred.
#
# The longest sum of consecutive primes below one-thousand that adds to a prime,
# contains 21 terms, and is equal to 953.
# 
# Which prime, below one-million, can be written as the sum of the most
# consecutive primes?

using ProjectEulerSolutions

# Use Sieve of Eratosthenes to get primes then start looking at the longest to
# the shortest summed sequences to see which sum is also prime.
function p050solution(n::Integer=1_000_000)::Integer

    primes = sieve_eratosthenes(n)
    primeset = Set(primes)

    # bound the max length to be 545 since the sum of the first 547 primes is
    # over 1 million
    for seqlength in 545:-2:21 # sequence lengths to consider
        for i in 1:(length(primes) - seqlength)
            if primes[i] < fld(n, seqlength) # loose constraint on ranges
                s = sum(primes[i .+ (0:seqlength-1)])
                if s in primeset
                    return s
                end
            end
        end
    end
    return -1
end

p050 = Problems.Problem(p050solution)

Problems.benchmark(p050, 1_000_000)