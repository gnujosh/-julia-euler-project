# If we list all the natural numbers below 10 that are multiples of 3 or 5, we
# get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

using ProjectEulerSolutions

# Brute force approach, loop through checking for multiples.
function p001solution_loop(n::Integer=9)::Integer
    total_sum = 0
    @simd for i in 1:n
        if i % 3 == 0 || i % 5 == 0
            total_sum += i
        end
    end
    return total_sum
end

# Faster approach, sum of real numbers in a sequence is n*(n+1)/2, just scale
# and remove double counts.
function p001solution_closedform(n::Integer=9)::Integer
    n3  = div(n, 3)
    n5  = div(n, 5)
    n15 = div(n, 15)
    return  3 * div(n3 * (n3 + 1), 2) +
            5 * div(n5 * (n5 + 1), 2) -
           15 * div(n15 * (n15 + 1), 2)
end

p001 = Problems.Problem(Dict("Closed form" => p001solution_closedform,
                             "Loop" => p001solution_loop))

Problems.benchmark(p001, 999)