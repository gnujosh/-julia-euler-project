# There are exactly ten ways of selecting three from five, 12345:
# 
# 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
# 
# In combinatorics, we use the notation, (5 3)=10.
# 
# In general, (n r)=n!/(r!(n−r)!), where r≤n, n!=n×(n−1)×...×3×2×1, and 0!=10!=1.
# 
# It is not until n=23 that a value exceeds one-million: (23 10)=1144066.
#
# How many, not necessarily distinct, values of (n r) for 1≤n≤100, are greater
# than one-million?


using ProjectEulerSolutions

# We note that (n r) = (n (n-r)), and that when r = n/2, the value of (n r) is
# maximal.  Thus we calculate from (n r/2-k) for k until we get a value of more
# than 1 million.  We save more time by further constraining the range of k
# values.  This is mostly a book-keeping exercise.
function p053solution(n_max::Integer=3, thresh=1_000)::Integer
    n_min = 23
    r = 3

    total = 0
    for n in n_max:-1:n_min
        # The value of r where we surpass the threshold will only get larger
        while binomial(n, r) < thresh
            r += 1
        end
        total += (n - r * 2  + 1)
    end
    return total
end

p053 = Problems.Problem(p053solution)

Problems.benchmark(p053, 100, 1_000_000)
