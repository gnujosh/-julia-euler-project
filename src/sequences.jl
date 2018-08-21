
function fibonacci_bound(N::Integer=1000)::Array{Integer}
    a = 1
    b = 2
    fibs = zeros(Integer, 1)
    fibs[1] = 1
    while b < N
        (a, b) = (b, a + b)
        push!(fibs, a)
    end
    return fibs
end

function fibonacci_count(N::Integer=20)::Array{Integer}
    a = 1
    b = 2
    fibs = zeros(Integer, N)
    fibs[1] = 1
    index = 2
    while index <= N
        (a, b) = (b, a + b)
        @inbounds fibs[index] = a
        index += 1
    end
    return fibs
end

function prime_seive_eratosthenes(N::Integer=500)::Array{Integer}
    primes = fill(true, N)

    for i in 2:Integer(floor(sqrt(N)))
        if primes[i]
            inds = (i+i):i:N
            primes[inds] = fill(false, length(inds))
            # why doesn't primes[inds] = false work?  Not broadcasting scalars properly?
        end
    end
    return findall(primes)
end


function get_factors(N::Integer)::Array{Integer}
    factors = Set{Integer}(1)
    for i in 2:Integer(floor(sqrt(N)))
        if N % i == 0
            push!(factors, i)
            push!(factors, div(N, i))
        end
    end
    return sort(collect(factors))
end

function get_prime_factors(N::Integer)::Array{Integer}
    factors = ones(Integer, 0)
    if N % 2 == 0
        push!(factors, 2)
        N /= 2
    end

    for i in 3:2:Integer(floor(sqrt(N)))
        if N % i == 0
            push!(factors, i)
            N /= i
        end
    end

    if N > 2
        push!(factors, N)
    end

    return sort(factors)
end

