# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes
# and concatenating them in any order the result will always be prime. For 
# example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four
# primes, 792, represents the lowest sum for a set of four primes with this
# property.
# 
# Find the lowest sum for a set of five primes for which any two primes
# concatenate to produce another prime.

using ProjectEulerSolutions


# Fairly brute-force approach, start with Seive of Eratosthenes to get an
# initial set of primes, then start building up a combination of 5 that each
# satisfy the concatenated condition given all of the previous numbers.
# Short-cutting can be aided by upper bounding some prime number ranges based
# on previous best results.  Finally, the order you pass through the pairs
# matters, looping with the largest value on the outside loop finds the minimum
# set faster.  A recursive solution would look cleaner, but it wouldn't
# necessarily be faster.
#
# This seems like the kind of thing you can do by building a graph with edges
# representing legal concatenated pairs and then solving for the fully connected
# cliques of size 5.
function p060solution(n::Integer=1_000)::Integer
    primes = sieve_eratosthenes(n, 3)

    min_sum = 10_000_000
    n = length(primes)

    # Use a bitarray, but might need to like a Dict of Sets if the number of
    # primes is very large
    pairs = falses(n, n)
    ashift = typeof(primes[1])(10)

    # Find concatenated prime pairs
    for a in 1:n
        # Break early if the sum is too large
        if 5 * primes[a] > min_sum
            break
        end

        # Fill in the pairs bitarray
        prime_a = primes[a]
        jshift = typeof(prime_a)(10)
        if prime_a > ashift
            ashift *= 10
        end
        for j in a+1:n
            prime_j = primes[j]
            if prime_j > jshift
                jshift *= 10
            end
            if isprime(ashift * prime_j + prime_a) && isprime(jshift * prime_a + prime_j)
                pairs[a,j] = true
            end
        end

        # Start looking for legal combinations of 2, 3, 4, and 5 primes
        for b in 4:a-1
            if !pairs[b,a]
                continue
            end

            for c in 3:b-1
                if !pairs[c,a] || !pairs[c,b]
                    continue
                end

                for d in 2:c-1
                    if !pairs[d,a] || !pairs[d,b] || !pairs[d,c]
                        continue
                    end

                    for e in 1:d-1
                        if pairs[e,a] && pairs[e,b] && pairs[e,c] && pairs[e,d]
                            min_sum = primes[a] + primes[b] + primes[c] + primes[d] + primes[e]
                        end
                    end
                end
            end
        end
    end

    return min_sum
end


p060 = Problems.Problem(p060solution)

Problems.benchmark(p060, 10_000)
