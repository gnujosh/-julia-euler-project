
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

function primefactors(n::Integer)::Array{Integer}
    factors = ones(Integer, 0)
    while n % 2 == 0
        push!(factors, 2)
        n /= 2
    end

    for i in 3:2:Integer(floor(sqrt(n)))
        while n % i == 0
            push!(factors, i)
            n /= i
        end
    end

    if n > 1
        push!(factors, n)
    end

    return sort(factors)
end