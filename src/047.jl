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

# Calculate prime factors iterating through each number, maintaining an array
# of four counts of prime factors.
function p047solution_upfront(n::Integer=100)::Integer
    q = zeros(Integer, 4)
    index = 1
    start = 645

    # Initialize it with first numbers
    for i in start:start+3
        q[index] = length(Set(primefactors(i)))
        index = mod(index, 4) + 1
    end

    # Start cycling through checking for every set for length 4
    for i in start+4:n
        q[index] = length(Set(primefactors(i)))
        index = mod(index, 4) + 1
        # This is faster than all(q .== 4)
        if q[1] == 4 && q[2] == 4 && q[3] == 4 && q[4] == 4
            return i - 3
        end
    end

    return -1
end

# Build up prime factors by iterating through.
function p047solution_iterative(n::Integer=100)::Integer
    factors = zeros(Integer, n)
    for i in 2:n-4
        if factors[i] == 0
            factors[i:i:n] .+= 1
        end
        # This is faster than all(factors[i:i+3] .== 4)
        if factors[i] == 4 && factors[i+1] == 4 && factors[i+2] == 4 && factors[i+3] == 4
            return i
        end
    end
    return -1
end

p047 = Problems.Problem(Dict("Upfront" => p047solution_upfront,
                             "Iterative" => p047solution_iterative))

Problems.benchmark(p047, 150_000)