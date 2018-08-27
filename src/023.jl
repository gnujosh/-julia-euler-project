# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors of
# 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
#
# A number n is called deficient if the sum of its proper divisors is less than
# n and it is called abundant if this sum exceeds n.
#
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit
# cannot be reduced any further by analysis even though it is known that the
# greatest number that cannot be expressed as the sum of two abundant numbers
# is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the sum
# of two abundant numbers.

include("Problems.jl")

# Uses the same approach as in 021.jl to build up array of factor sums, testing
# for abundant numbers and storing them.  Then filters out sums of abundant
# numbers.
function p023solution(n::Integer=28_123)::Integer
    abundant_numbers = Array{Integer, 1}()

    factor_sums = ones(Integer, n)
    for i = 2:n
        for j = 2*i:i:n
            factor_sums[j] += i
        end
        if i < factor_sums[i]
            push!(abundant_numbers, i)
        end
    end

    # Loop over pairs of abundant numbers and filter them.
    not_sum_of_abundant_numbers = trues(fld(3*n, 2))
    for a in abundant_numbers
        if a < n/2
            not_sum_of_abundant_numbers[abundant_numbers .+ a] .= false
        end
    end

    return sum((1:n)[not_sum_of_abundant_numbers[1:n]])
end

p023 = Problems.Problem(p023solution)

Problems.benchmark(p023, 28_123)