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

# Get the first n primes that sum to less than n, then start looking at the
# longest to the shortest summed sequences to see which sum is also prime.
function p050solution_iterative(n::Integer=1_000)::Integer

    # Bound the max length to be when the sum of the first primes surpasses n
    primes = Array{Integer}([2, 3])
    running_sum = 2
    upper_ind = 1
    test_val = 3
    while running_sum < n
        upper_ind += 1
        running_sum += primes[upper_ind]
        if length(primes) == upper_ind
            test_val += 1
            while !isprime(test_val)
                test_val += 1
            end
            append!(primes, test_val)
        end
    end

    start_val = sum(primes[1:upper_ind+1])
    for seqlength in upper_ind:-1:1 # sequence lengths to consider
        start_val -= primes[seqlength+1]
        # Even lengths can only work if they include the first prime
        if seqlength % 2 == 0 
            if isprime(start_val)
                return start_val
            end
            continue
        end
        prev_val = start_val
        i = 2
        while prev_val < n
            s = prev_val - primes[i-1] + primes[seqlength+i-1]
            if isprime(s)
                return s
            end
            prev_val = s
            i += 1
        end
    end
    return -1
end


# Use seive like before, but build up a cumulative sum so that you only need to
# subtract two numbers to get the sum of primes from index 1 to index j.
function p050solution_cumsum(n::Integer=1_000)::Integer

    primes = Array{Integer}([2, 3])

    cumsum = zeros(Integer, 1)
    cumsum[1] = primes[1]

    test_val = 3
    i = 2
    while cumsum[i-1] <= n
        if length(primes) == i
            test_val += 1
            while !isprime(test_val)
                test_val += 1
            end
            append!(primes, test_val)
        end
        append!(cumsum, cumsum[i-1] + primes[i])
        i += 1

    end

    upper_ind = min(i, length(primes)) - 1

    for seqlength in upper_ind:-1:1 # sequence lengths to consider
        # Even lengths can only work if they include the first prime
        s = cumsum[seqlength]
        if seqlength % 2 == 0
            if isprime(s)
                return s
            end
            continue
        end
        i = 1
        while s < n
            s = cumsum[seqlength + i] - cumsum[i]
            if isprime(s)
                return s
            end
            i += 1 
        end
    end

    return -1
end



p050 = Problems.Problem(Dict("Iterative" => p050solution_iterative,
                             "Cumulative sum" => p050solution_cumsum))


Problems.benchmark(p050, 1_000_000)
