# Euler's Totient function, φ(n) [sometimes called the phi function], is used to
# determine the number of positive numbers less than or equal to n which are
# relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than
# nine and relatively prime to nine, φ(9)=6.
#
# The number 1 is considered to be relatively prime to every positive number, so
# φ(1)=1.
#
# Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation
# of 79180.
#
# Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and
# the ratio n/φ(n) produces a minimum.

using ProjectEulerSolutions

# Brute force approach to cycle through numbers calculating totients
function p070solution_bruteforce(n_max::Integer=100)::Integer
    min_ratio = 100.0
    nmin = 1
    n_start = Integer(floor(n_max * 0.8))
    for n in n_start:n_max
        digs = digits(n)
        tot = digits(totient(n))
        sort!(digs)  # Sort in place to save time / memory alloc
        sort!(tot)
        if digs == tot
            ratio = n / totient(n)
            if ratio < min_ratio
                nmin = n
                min_ratio = ratio
            end
        end
    end

    return nmin
end

# When φ(n) is very close to n, that's when we get the minimum values.  Thus,
# we want to consider numbers that have the fewest factors (1 - 1/f1)*(1 - 1/f2),
# will tend to give smaller ratios than 3 or 4 factors.  Additionally, we want
# the largest factors possible.  So we consider only numbers that have two prime
# factors, each as close to sqrt(10_000_000) as possible.
function p070solution_factors(n_max::Integer=100)::Integer
    root = sqrt(n_max)
    n_start = Integer(floor(root * 0.5))
    n_end = div(n_max, n_start)
    primes = sieve_eratosthenes(n_end, n_start)

    nmin = 1
    min_ratio = 100.0
    for i in 1:div(length(primes), 2)
        for j in i+1:length(primes)
            n = primes[i] * primes[j]
            if n > n_max
                break
            end
            tot = Integer(round(n * (1 - 1 / primes[i]) * (1 - 1 / primes[j])))
            tot_digs = digits(tot)
            n_digs = digits(n)
            sort!(tot_digs)  # Sort in place to save time / memory alloc
            sort!(n_digs)
            if n_digs == tot_digs
                ratio = n / tot
                if ratio < min_ratio
                    min_ratio = ratio
                    nmin = n
                end
            end
        end
    end

    return nmin
end

p070 = Problems.Problem(Dict("Brute force" => p070solution_bruteforce,
                             "Factors" => p070solution_factors))

Problems.benchmark(p070, 10_000_000)
