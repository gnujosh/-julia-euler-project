# The sum of the squares of the first ten natural numbers is,
#
# 1^2 + 2^2 + ... + 10^2 = 385
#
# The square of the sum of the first ten natural numbers is,
#
# (1 + 2 + ... + 10)^2 = 552 = 3025
#
# Hence the difference between the sum of the squares of the first ten natural
# numbers and the square of the sum is 3025 − 385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.

include("Problems.jl")

# Brute force solution, using Julia built-ins.
function p006solution_sequence(n::Integer=100)::Integer
    seq = 1:n
    return sum(seq)^2 - sum(seq.^2)
end

# Closed form solution for the sum of a sequence and the sum of a sequence of
# squares.
function p006solution_closedform(n::Integer=100)::Integer
    return (n*(n+1)/2)^2 - (n*(n+1)*(2n+1)/6)
end

p006 = Problems.Problem(Dict("closed form" => p006solution_closedform,
                             "sequence" => p006solution_sequence))

Problems.benchmark(p006, 100)