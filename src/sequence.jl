"""
Returns an array of the Fibonacci numbers up to a bound n.
"""
function fibonacci_bound(n::BigInt=1000)::Array{BigInt}
    a = BigInt(1)
    b = BigInt(2)
    fibs = zeros(BigInt, 1)
    fibs[1] = 1
    while a < n
        (a, b) = (b, a + b)
        push!(fibs, a)
    end
    return fibs
end

"""
Returns an array of the first n Fibonacci numbers.
"""
function fibonacci_count(n::Integer=20)::Array{BigInt}
    a = BigInt(1)
    b = BigInt(2)
    fibs = zeros(BigInt, n)
    fibs[1] = 1
    for i in 2:n
        (a, b) = (b, a + b)
        @inbounds fibs[i] = a
    end
    return fibs
end

"""
Return a list of products of numbers with "ndigit" digits.
"""
function unique_products_of_ndigits(n_digits::Integer)::Array{Integer}
    maxnum = 10^n_digits - 1
    minnum = 10^(n_digits - 1)
    return [i * j for i in minnum:maxnum for j in minnum:maxnum if i < j]
end

"""
Return a multiset (combinations with replacement, order doesn't matter).  Uses
a recursive solution to build up a full set of indexes.
"""
function multiset_combination!(storage::Array{Int8,2},
                               digit_index::Integer,
                               index::Integer,
                               rstart::Integer,
                               rend::Integer)
    if digit_index == 0
        storage[:, index + 1] = storage[:, index]
        return index + 1
    end

    for i in rstart:rend
        storage[digit_index, index] = i
        index = multiset_combination!(storage, digit_index - 1, index, i, rend)
    end
    return index
end