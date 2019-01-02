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

using ProjectEulerSolutions

# Uses the same approach as in 021.jl to build up array of factor sums, testing
# for abundant numbers and storing them.  Then filters out sums of abundant
# numbers.
function p023solution(n::Integer=10)::Integer
    abundant_numbers = Array{Integer, 1}()

    # Store abundant_numbers
    factor_sums = ones(Integer, n)
    for i = 2:n
        factor_sums[2*i:i:n] .+= i
        if i < factor_sums[i]
            push!(abundant_numbers, i)
        end
    end

    # Check for sums of abundant_numbers
    sum_of_abundant_numbers = falses(n)
    for i in 1:length(abundant_numbers)
        for j in i:length(abundant_numbers)
            h = abundant_numbers[i] + abundant_numbers[j]
            if h > n
                break
            end
            sum_of_abundant_numbers[h] = true
        end
    end

    # Invert the bitarray to get values that are not sums of abundant numbers
    return sum(findall(.!sum_of_abundant_numbers))
end

p023 = Problems.Problem(p023solution)

Problems.benchmark(p023, 28_123)