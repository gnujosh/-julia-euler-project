# Euler's Totient function, φ(n) [sometimes called the phi function], is used
# to determine the number of numbers less than n which are relatively prime to
# n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively
# prime to nine, φ(9)=6.
# 
# n   Relatively Prime  φ(n)   n/φ(n)
# --------------------------------------
# 2   1                 1      2
# 3   1,2               2      1.5
# 4   1,3               2      2
# 5   1,2,3,4           4      1.25
# 6   1,5               2      3
# 7   1,2,3,4,5,6       6      1.1666...
# 8   1,3,5,7           4      2
# 9   1,2,4,5,7,8       6      1.5
# 10  1,3,7,9           4      2.5
#
# It can be seen that n=6 produces a maximum n / φ(n) for n ≤ 10.
#
# Find the value of n ≤ 1,000,000 for which n / φ(n) is a maximum.


using ProjectEulerSolutions

# Brute force solution, considering every value less than n.
function p069solution_bruteforce(n::Integer=1_000)::Integer

    max_val = 0.0
    max_index = 0
    for i in 2:n
        test_val = i / totient(i)
        if max_val < test_val
            max_val = test_val
            max_index = i
        end
    end

    return max_index
end

# Only consider values that are likely candidates, which are primodial numbers.
# Primodial numbers are the product of consecutive primes starting at 2, so
# 2, 6, 30, 210, etc.  We only consider primordial numbers up to that who's
# product more than n since they have maximal n / φ(n) values.
function p069solution_factors(n::Integer=1_000)::Integer

    primes = sieve_eratosthenes(30)
    index = 2
    p = primes[1]
    while p * primes[index] < n
        p *= primes[index]
        index += 1
    end
    return p
end


p069 = Problems.Problem(Dict("Brute force" => p069solution_bruteforce,
                             "Factors" => p069solution_factors))

Problems.benchmark(p069, 1_000_000)
