# A googol (10^100) is a massive number: one followed by one-hundred zeros;
# 100^100 is almost unimaginably large: one followed by two-hundred zeros.
# Despite their size, the sum of the digits in each number is only 1.
# 
# Considering natural numbers of the form, a^b, where a, b < 100, what is the
# maximum digital sum?

using ProjectEulerSolutions

# Mostly an exercise in constraining the search space since the digits and
# sum built-in functions do most of the work when using BigInts.
function p056solution(n_max::Integer=10)::Integer
    
    # Assume that max value will be when a^b is many digits long, so select
    # a and b starting values to be 80% of their maxes.
    a_start = floor(BigInt, n_max * 0.8)
    b_start = floor(BigInt, n_max * 0.8)
    max_sum = 0
    for a in a_start:n_max
        for b in b_start:n_max
            max_sum = max(max_sum, sum(digits(a ^ b)))
        end
    end
    return max_sum
end


p056 = Problems.Problem(p056solution)

Problems.benchmark(p056, 100)
