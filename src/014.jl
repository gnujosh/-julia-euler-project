# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
# It can be seen that this sequence (starting at 13 and finishing at 1) contains
# 10 terms. Although it has not been proved yet (Collatz Problem), it is thought
# that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.

include("Problems.jl")

function p014solution_memoize(num::Integer=500)::Integer
    # Memoization type solution to store intermediate results
    cache = Dict{Integer, Integer}(1 => 1)
    for k = 2:num
        n = k
        i = 1
        while !haskey(cache, n)
            if n % 2 == 0
                n = convert(Integer, n / 2)
            else
                n = 3 * n + 1
            end
            i += 1
        end
        cache[k] = get(cache, n, 0) + i - 1
    end

    maxkey, maxvalue = 0, 0
    for (key, value) in cache
        if value > maxvalue
            maxkey, maxvalue = key, value
        end
    end

    return maxvalue
end

function collatz!(cache::Dict{Integer, Integer}, n::Integer)::Integer
    # Dynamic programming type solution to store intermediate results
    if haskey(cache, n)
        return cache[n]
    else
        if n % 2 == 0
            cache[n] = collatz!(cache, convert(Integer, n / 2)) + 1
        else
            cache[n] = collatz!(cache, 3 * n + 1) + 1
        end
        return cache[n]
    end
end

function p014solution_recurse(num::Integer=500)::Integer
    cache = Dict{Integer, Integer}(1 => 1)
    for k = 2:num
        collatz!(cache, k)
    end

    maxkey, maxvalue = 0, 0
    for (key, value) in cache
        if value > maxvalue
            maxkey, maxvalue = key, value
        end
    end

    return maxvalue
end

p014 = Problems.Problem(Dict("recurse" => p014solution_recurse,
                             "memoize" => p014solution_memoize))

Problems.benchmark(p014, 1_000_000)
