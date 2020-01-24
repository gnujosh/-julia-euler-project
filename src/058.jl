# Starting with 1 and spiralling anticlockwise in the following way, a square
# spiral with side length 7 is formed.
# 
# 37 36 35 34 33 32 31
# 38 17 16 15 14 13 30
# 39 18  5  4  3 12 29
# 40 19  6  1  2 11 28
# 41 20  7  8  9 10 27
# 42 21 22 23 24 25 26
# 43 44 45 46 47 48 49
# 
# It is interesting to note that the odd squares lie along the bottom right
# diagonal, but what is more interesting is that 8 out of the 13 numbers lying
# along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
# 
# If one complete new layer is wrapped around the spiral above, a square spiral
# with side length 9 will be formed. If this process is continued, what is the
# side length of the square spiral for which the ratio of primes along both
# diagonals first falls below 10%?


using ProjectEulerSolutions

# Create the sequence of corner values and check each for primeness.  Keep a
# running total to verify that the desired threshold has been met.
function p058solution(thresh::Float64=0.44)::Integer
    nprimes = 0
    total_tested = 1
    startindex = 3
    i = 2
    while i == 2 || nprimes / total_tested > thresh
        nprimes += sum(isprime.(collect(startindex .+ (0:i:i*3))))
        startindex = startindex + 4*i + 2
        total_tested += 4
        i += 2
    end
    return i - 1
end

p058 = Problems.Problem(p058solution)

Problems.benchmark(p058, 0.1)
