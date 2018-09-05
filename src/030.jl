# Surprisingly there are only three numbers that can be written as the sum of
# fourth powers of their digits:
#
# 1634 = 1^4 + 6^4 + 3^4 + 4^4
# 8208 = 8^4 + 2^4 + 0^4 + 8^4
# 9474 = 9^4 + 4^4 + 7^4 + 4^4
#
# As 1 = 1^4 is not a sum it is not included.
#
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
#
# Find the sum of all the numbers that can be written as the sum of fifth
# powers of their digits.

include("Problems.jl")

# Brute force, but precalculate the digit powers.  Just use a guess for number
# ranges to consider.
function p030solution_brute(pow::Integer=2)::Integer
    powers = Array{Integer}([n^pow for n in 0:9])
    total = 0
    for k in 10^(pow-2):10^(pow+1)
        if sum(powers[digits(k) .+ 1]) == k
            total += k
        end
    end
    return total
end

# Create a multiset (combinations with replacement, order doesn't matter).
# Uses a recursive solution to build up a full set.
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

# Helper function which creates multiset combinations for digits.
function create_digit_multiset(choose::Integer)::Array{Int8,2}
    # Size of multiset combinations, (combinations with replacement)
    s = fld(factorial(9 + choose), factorial(choose) * factorial(9)) + 1
    storage = zeros(Int8, choose, s)
    multiset_combination!(storage, choose, 1, 0, 9)
    return storage
end

# Uses multisets to only consider the unique set of digits for each set of p
# digits.  Then sorts them and compares sorted sets to the sorted digits of the
# sum of powers.
function p030solution_multiset(pow::Integer=2)::Integer
    total = 0
    powers = Array{Integer}([n^pow for n in 0:9])
    for numdigits in max(2, pow-2):pow+1
        storage = create_digit_multiset(numdigits)
        storage = sort(storage, dims=1, rev=true) # sort! doesn't support multi-dim arrays
        sums = sum(powers[storage .+ 1], dims=1)
        for (i, s) in enumerate(sums)
            if ndigits(s) == numdigits && sort(digits(s), rev=true) == storage[:,i]
                total += s
            end
        end
    end
    return total
end

p030 = Problems.Problem(Dict("brute force" => p030solution_brute,
                             "multiset" => p030solution_multiset))

Problems.benchmark(p030, 5)