# The Fibonacci sequence is defined by the recurrence relation:
#
# F_n = F_n−1 + F_n−2, where F_1 = 1 and F_2 = 1.
# Hence the first 12 terms will be:
#
# F_1 = 1
# F_2 = 1
# F_3 = 2
# F_4 = 3
# F_5 = 5
# F_6 = 8
# F_7 = 13
# F_8 = 21
# F_9 = 34
# F_10 = 55
# F_11 = 89
# F_12 = 144
# The 12th term, F_12, is the first term to contain three digits.
#
# What is the index of the first term in the Fibonacci sequence to contain 1000
# digits?

include("Problems.jl")
include("sequence.jl")

# There's a pattern in the number of digits in Fibonacci numbers.  It appears
# to be a new digit every 5 numbers or so.  We use that to estimate the upper
# bound for how far to generate numbers.
#
# map(x -> floor(Integer, log10(x)) + 1, fibonacci_count(48))
# [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5,
#  6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10]
function p025solution(n_digits::Integer=1000)::Integer

    fibs = fibonacci_bound(BigInt(10)^(n_digits-1))
    n = length(fibs) + 1

    if floor(Integer, log10(fibs[end])) + 1 < n_digits
        return n + 1
    else
        return n
    end
end

p025 = Problems.Problem(p025solution)

Problems.benchmark(p025, 1000)