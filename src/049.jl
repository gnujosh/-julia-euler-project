# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
# increases by 3330, is unusual in two ways: (i) each of the three terms are
# prime, and, (ii) each of the 4-digit numbers are permutations of one another.
# 
# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
# exhibiting this property, but there is one other 4-digit increasing sequence.
#
# What 12-digit number do you form by concatenating the three terms in this
# sequence?

using ProjectEulerSolutions

# Use Sieve of Eratosthenes and then loop through looking for primes that
# satisfy the specified criterion.
function p049solution(n::Integer=100)::Integer

    primes = Set(sieve_eratosthenes(n))

    for p in primes
        if p > 1488 && p + 3330 in primes && p + 6660 in primes
            d = Set(digits(p))
            if d == Set(digits(p + 3330)) && d == Set(digits(p + 6660))
                return p * 1e8 + (p + 3330) * 1e4 + p + 6660
            end
        end
    end

    return -1
end

p049 = Problems.Problem(p049solution)

Problems.benchmark(p049, 9999)