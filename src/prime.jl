"""
Creates permutations of numbers and returns when the first prime value is reached.
"""
function first_permuted_prime(elementlist::Array, multiplier::Array, k::Integer=1)
    if k == length(elementlist)
        if elementlist[end] % 2 == 1
            val = sum(elementlist .* multiplier)
            if isprime(val)
                return val
            else
                return -1
            end
        else
            return -1
        end
    else
        for i in k:length(elementlist)
            elementlist[k], elementlist[i] = elementlist[i], elementlist[k]
            v = first_permuted_prime(elementlist, multiplier, k + 1)
            if v > 0
                return v
            end
            elementlist[k], elementlist[i] = elementlist[i], elementlist[k]
        end
    end
    return -1
end

"""
Reasonably fast test for primality.
"""
function isprime(n)
    if n == 2 || n == 3
        return true
    end
    if n < 2 || n % 2 == 0
        return false
    end
    if n < 9
        return true
    end
    if n % 3 == 0
        return false
    end
    r = typeof(n)(floor(sqrt(n)))
    f = 5
    while f <= r
        if n % f == 0
            return false
        end
        if n % (f + 2) == 0
            return false
        end
        f += 6
    end
    return true
end

"""
Implements the Seive of Eratosthenes to return all prime numbers up "n".
https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
"""
function seive_eratosthenes(n::Integer=500)::Array{Integer}
    primes = trues(n)
    primes[1] = false

    for i in 2:floor(Integer, sqrt(n))
        if primes[i]
            @inbounds primes[(i+i):i:n] .= false
        end
    end
    return findall(primes)
end