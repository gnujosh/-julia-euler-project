# We shall say that an n-digit number is pandigital if it makes use of all the
# digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
# also prime.
#
# What is the largest n-digit pandigital prime that exists?

using ProjectEulerSolutions

# Helper function for testing primality
function testprime(vals::Array)
    return isprime(sum(vals .* (10 .^ (0:length(vals)-1))))
end

# Creates pandigital permutations, and tests for primality.  Pandigitals of
# length 8 and 9 are divisible by 3 and thus cannot be prime.
function p041solution_permutation()::Integer
    for n in 7:-1:1
        matrix = zeros(Integer, 0)
        permutation_matrix!(collect(1:n), matrix, testprime)
        primes = transpose(10 .^ (0:n-1)) * reshape(matrix, (n, fld(length(matrix), n)))
        return maximum(primes)
    end
    return -1
end

# Brute force solution, checking every prime up to 7,654,321, since all
# pandigitals of length 8 and 9 are divisible by 3 and thus cannot be prime.
function p041solution_sieve()::Integer
    n = 7_654_321
    primes = sieve_eratosthenes(n)
    max_pandigital_prime = 2143
    lower_bound = 1e6

    for p in primes
        digs = digits(p)
        # max digit = length, min digit = 1, and every digit unique
        if length(digs) == maximum(digs) && minimum(digs) == 1 && length(Set(digs)) == length(digs)
            max_pandigital_prime = p
        end
    end

    return max_pandigital_prime
end

p041 = Problems.Problem(Dict("Permutation" => p041solution_permutation,
                             "Sieve" => p041solution_sieve))

Problems.benchmark(p041)
