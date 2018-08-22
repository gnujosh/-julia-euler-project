
function fibonacci_bound(n::Integer=1000)::Array{Integer}
    a = 1
    b = 2
    fibs = zeros(Integer, 1)
    fibs[1] = 1
    while b < n
        (a, b) = (b, a + b)
        push!(fibs, a)
    end
    return fibs
end

function fibonacci_count(n::Integer=20)::Array{Integer}
    a = 1
    b = 2
    fibs = zeros(Integer, n)
    fibs[1] = 1
    index = 2
    while index <= n
        (a, b) = (b, a + b)
        @inbounds fibs[index] = a
        index += 1
    end
    return fibs
end

function seive_eratosthenes(n::Integer=500)::Array{Integer}
    primes = trues(n)
    primes[1] = false

    for i in 2:Integer(floor(sqrt(n)))
        if primes[i]
            @inbounds primes[(i+i):i:n] .= false
        end
    end
    return findall(primes)
end

function unique_products_of_ndigits(ndigits::Integer)::Array{Integer}
    maxnum = 10^ndigits - 1
    minnum = 10^(ndigits - 1)
    return [i*j for i in minnum:maxnum for j in minnum:maxnum if i < j]
end