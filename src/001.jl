# If we list all the natural numbers below 10 that are multiples of 3 or 5, we
# get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

include("Problems.jl")

function p001slow(n::Integer=999)::Integer
    total_sum = 0
    for i in 1:n
        if i % 3 == 0 || i % 5 == 0
            total_sum += i
        end
    end
    return total_sum
end

function p001fast(n::Integer=999)::Integer
    return  3 * (div(n, 3) + 1)  * div(n, 3) / 2 +
            5 * (div(n, 5) + 1)  * div(n, 5) / 2 -
           15 * (div(n, 15) + 1) * div(n, 15) / 2
end

p001 = Problems.Problem(Dict("fast" => p001fast, "slow" => p001slow))

Problems.benchmark(p001, 999)