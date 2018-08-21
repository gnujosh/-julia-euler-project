# If we list all the natural numbers below 10 that are multiples of 3 or 5, we
# get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

include("Problems.jl")

function p001_slow(N::Integer=999)::Integer
    total_sum = 0
    for n in 1:N
        if n % 3 == 0 || n % 5 == 0
            total_sum += n
        end
    end
    return total_sum
end

function p001_fast(N::Integer=999)::Integer
    return  3 * (div(N, 3) + 1)  * div(N, 3) / 2 +
            5 * (div(N, 5) + 1)  * div(N, 5) / 2 -
           15 * (div(N, 15) + 1) * div(N, 15) / 2
end

p001 = Problems.Problem(Dict("fast" => p001_fast, "slow" => p001_slow))

Problems.benchmark(p001, 999)