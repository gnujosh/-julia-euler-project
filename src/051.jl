# By replacing the 1st digit of the 2-digit number *3, it turns out that six of
# the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.
# 
# By replacing the 3rd and 4th digits of 56**3 with the same digit, this
# 5-digit number is the first example having seven primes among the ten
# generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663,
# 56773, and 56993. Consequently 56003, being the first member of this family,
# is the smallest prime with this property.
#
# Find the smallest prime which, by replacing part of the number (not
# necessarily adjacent digits) with the same digit, is part of an eight prime
# value family.

using ProjectEulerSolutions

# Use Seive to get set of primes, then make a list of possible indexes to
# substitute (we only go up to 6 digits).  Sustitute with new digits and cycle
# through testing for primality until a set of 8 occurs.
function p051solution(n::Integer=100)::Integer

    primes = sieve_eratosthenes(n)
    primeset = Set(primes)
    maxnumprimes = 0
    minprime = n
    checked = Set{Integer}()
    for p in primes
        # Don't need to check primes that have already been tested
        if p in checked
            continue
        end
        numdigs = max(2, ndigits(p))
        mult = (10 .^ (0:numdigs-1))
        # Can't change an even number of digits
        if numdigs == 2
            ss = [[2]]
        elseif numdigs == 3
            ss = [[2], [3]]
        elseif numdigs == 4
            ss = [[2], [3], [4], [2,3,4]]
        elseif numdigs == 5
            ss = [[2], [3], [4], [5], [2,3,4], [2,3,5], [2,4,5]]
        elseif numdigs == 6
            ss = [[2], [3], [4], [5], [6], [2,3,4], [2,3,5], [2,3,6], [2,4,5], [2,4,6], [2,5,6], [2,3,4,5,6]]
        end
        if p > 10
            # Don't use the "last" digit since it would have to include even
            # numbers, which aren't prime
            for s in ss
                d = digits(p)
                numprimes = 0
                minp = 0
                for j = 0:9
                    d[s] .= j
                    newp = sum(d .* mult)
                    if isprime(newp)
                        push!(checked, newp)
                        numprimes += 1
                        if minp == 0
                            minp = newp
                        end
                    end
                end
                if numprimes == 8
                    return minp
                end
            end
        end
    end
    return -1
end

p051 = Problems.Problem(p051solution)

Problems.benchmark(p051, 1_000_000)
