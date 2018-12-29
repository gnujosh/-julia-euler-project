export factors
export primefactors

"""
Return sorted list of unique factors for a number n.
"""
function factors(n::Integer)::Array{Integer}
    factors = Set{Integer}(1)
    for i in 2:Integer(floor(sqrt(n)))
        if n % i == 0
            push!(factors, i)
            push!(factors, div(n, i))
        end
    end
    return sort(collect(factors))
end

"""
Return sorted list of prime factors for number n.
"""
function primefactors(n::Integer)::Array{Integer}
    factors = ones(Integer, 0)

    # Store all of the factors of 2.
    while n % 2 == 0
        push!(factors, 2)
        n = fld(n, 2)
    end

    # Store all other prime factors, increasing to sqrt(n).
    for i in 3:2:Integer(floor(sqrt(n)))
        while n % i == 0
            push!(factors, i)
            n = fld(n, i)
        end
    end

    # Store last prime factor.
    if n > 1
        push!(factors, n)
    end

    return sort(factors)
end