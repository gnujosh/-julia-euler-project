# Euler discovered the remarkable quadratic formula:
#
#   n^2+n+41
#
# It turns out that the formula will produce 40 primes for the consecutive
# integer values 0≤n≤39. However, when n=40, 40^2+40+41=40(40+1)+41 is
# divisible by 41, and certainly when n=41,41^2+41+41 is clearly divisible by
# 41.
#
# The incredible formula n^2−79n+1601 was discovered, which produces 80 primes
# for the consecutive values 0≤n≤79. The product of the coefficients, −79 and
# 1601, is −126479.
#
# Considering quadratics of the form:
#
# n^2+an+b, where |a|<1000 and |b|≤1000
#
# where |n| is the modulus/absolute value of n
# e.g. |11|=11 and |−4|=4
#
# Find the product of the coefficients, a and b, for the quadratic expression
# that produces the maximum number of primes for consecutive values of n,
# starting with n=0.

include("Problems.jl")
include("sequence.jl")

# We know that the b values must be primes, and after experimenting a bit we
# see that a values are all negative.  Estimate upper bound of primes then
# cycle through and store the ones with the longest n sequence.
function p027solution(abound::Integer=5, bbound::Integer=5)::Integer
    bs = seive_eratosthenes(bbound)
    primes = Set{Integer}(seive_eratosthenes(3*max(abound, bbound)))
    maxtuple = Tuple{Integer, Integer}((1, 1))
    maxn = 1
    mval = 0
    for a in -abound:1
        for b in bs
            n = 0
            while in(n*n + a*n + b, primes)
                n += 1
            end
            if n > maxn
                maxn = n
                maxtuple = (a, b)
            end
        end
    end

    return maxtuple[1] * maxtuple[2]
end

p027 = Problems.Problem(p027solution)

Problems.benchmark(p027, 1000, 1000)