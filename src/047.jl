# The first two consecutive numbers to have two distinct prime factors are:
#
# 14 = 2 × 7
# 15 = 3 × 5
#
# The first three consecutive numbers to have three distinct prime factors are:
#
# 644 = 2² × 7 × 23
# 645 = 3 × 5 × 43
# 646 = 2 × 17 × 19.
#
# Find the first four consecutive integers to have four distinct prime factors
# each. What is the first of these numbers?

using ProjectEulerSolutions
using DataStructures

# Calculate prime factors iterating through each number, maintaining a queue of
# four counts of prime factors.
function p047solution_upfront(n::Integer=100)::Integer

    q = Queue{Integer}()
    start = 645
    # Initialize it with first numbers
    total = 0
    for i in start:start+3
        enqueue!(q, length(Set(primefactors(i))))
        total += back(q)
    end

    # Start cycling through checking for every set for 4
    for i in start+4:n
        enqueue!(q, length(Set(primefactors(i))))
        total -= front(q)
        dequeue!(q)
        total += back(q)
        if total == 16 && all(q .== 4)
            return i - 3
        end
    end
    return -1
end

# Build up prime factors by interating through.
function p047solution_iterative(n::Integer=100)::Integer
    factors = zeros(Integer, n)
    for i in 2:n-4
        if factors[i] == 0
            factors[i:i:n] .+= 1
        end
        if all(factors[i:i+3] .== 4)
            return i
        end
    end
    return -1
end

p047 = Problems.Problem(Dict("Upfront" => p047solution_upfront,
                             "Iterative" => p047solution_iterative))

Problems.benchmark(p047, 150_000)