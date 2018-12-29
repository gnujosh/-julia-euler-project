# A permutation is an ordered arrangement of objects. For example, 3124 is one
# possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
# are listed numerically or alphabetically, we call it lexicographic order. The
# lexicographic permutations of 0, 1 and 2 are:
#
# 012   021   102   120   201   210
#
# What is the millionth lexicographic permutation of the digits:
# 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

using ProjectEulerSolutions

# If the permutations are ordered, than we can calculate what percentage of the
# way 1,000,000 is through 10!.  We can extract the digit, find the remainder
# after subtracting from 1,000,000, then repeat for 9! then 8!, etc, extracting
# all the digits.
function p024solution(n::Integer=10)::String

    n = n - 1 # using one-indexing, not zero-indexing
    num_per_digit = factorial(10)

    digit_set = collect(0:9)

    perm = Vector{Integer}()
    for k = 0:9
        num_per_digit = fld(num_per_digit, length(digit_set))
        digit = digit_set[fld(n, num_per_digit)+1]
        push!(perm, digit)
        n -= num_per_digit * fld(n, num_per_digit)
        deleteat!(digit_set, findfirst(digit_set .== digit))
    end

    return mapreduce(x -> string(x), *, perm)
end

p024 = Problems.Problem(p024solution)

Problems.benchmark(p024, 1_000_000)