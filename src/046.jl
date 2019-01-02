# It was proposed by Christian Goldbach that every odd composite number can be
# written as the sum of a prime and twice a square.
#
# 9 = 7 + 2×1^2
# 15 = 7 + 2×2^2
# 21 = 3 + 2×3^2
# 25 = 7 + 2×3^2
# 27 = 19 + 2×2^2
# 33 = 31 + 2×1^2
#
# It turns out that the conjecture was false.
#
# What is the smallest odd composite that cannot be written as the sum of a
# prime and twice a square?

using ProjectEulerSolutions

# Make a resonable list of twice squares and primes, then sum combinations of
# them and make a set that you compare against the set of odd composite
# numbers.  Would probably be faster to not calculate all the prime numbers
# and odd composite numbers upfront.
function p046solution(n::Integer=100)::Integer
    primearray = sieve_eratosthenes(n)
    primeset = Set(primearray)
    oddnumset = Set(9:2:n)
    oddcompositeset = setdiff(oddnumset, primeset)

    twicesquares = 2 .* (1:Integer(floor(0.75*sqrt(n)))).^2

    sums = Set()
    for ts in twicesquares
        union!(sums, Set(ts .+ primearray))
    end

    oddcomp = setdiff(oddcompositeset, sums)
    if length(oddcomp) > 0
        return minimum(oddcomp)
    else
        return -1
    end
end

p046 = Problems.Problem(p046solution)

Problems.benchmark(p046, 10_000)