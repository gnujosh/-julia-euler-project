# It is possible to show that the square root of two can be expressed as an
# infinite continued fraction.
#
# √2=1+1/(2+1/(2+1/(2+...)))
#
# By expanding this for the first four iterations, we get:
# 
# 1+1/2 = 3/2 = 1.5
# 1+1/(2+1/2) = 7/5 = 1.4
# 1+1/(2+1/(2+1/2)) = 17/12 =1.41666...
# 1+1/(2+1/(2+1/(2+1/2))) = 41/29 = 1.41379...
# 
# The next three expansions are 99/70, 239/169, and 577/408, but the eighth
# expansion, 1393/985, is the first example where the number of digits in the
# numerator exceeds the number of digits in the denominator.
#
# In the first one-thousand expansions, how many fractions contain a numerator
# with more digits than the denominator?

using ProjectEulerSolutions

# Using Julia's built-in rational numbers only works up to n=47 or so, when we
# begin to run into over-runs.  Really this is a pattern matching game.  The 
# numerator for iteration i (n_i) and the denominator for iteration i (d_i)
# follow a pattern: d_i = n_{i-1} + d_{i-1}, n_i = d_i + d_{i-1}
function p057solution(n_max::Integer=100)::Integer
    
    num = BigInt(3)
    denom = BigInt(2)
    count = 0
    for n in 2:n_max
        denom, num = num + denom, num + 2*denom
        if ndigits(num) > ndigits(denom)
            count += 1
        end
    end
    return count
end


p057 = Problems.Problem(p057solution)

Problems.benchmark(p057, 1_000)
