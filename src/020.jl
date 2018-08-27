# n! means n × (n − 1) × ... × 3 × 2 × 1
#
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!

include("Problems.jl")

# Trivial with Julia's built-in factorial and digits functions.
function p020solution(n::Integer=2)::Integer
    return sum(digits(factorial(BigInt(n))))
end

p020 = Problems.Problem(p020solution)

Problems.benchmark(p020, 100)