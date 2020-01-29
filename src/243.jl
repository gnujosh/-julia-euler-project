# A positive fraction whose numerator is less than its denominator is called a
# proper fraction. For any denominator, d, there will be d−1 proper fractions;
# for example, with d = 12: 1/12, 2/12, 3/12, 4/12, 5/12, 6/12, 7/12, 8/12,
# 9/12, 10/12, 11/12.
#
# We shall call a fraction that cannot be cancelled down a resilient fraction.
# Furthermore we shall define the resilience of a denominator, R(d), to be the
# ratio of its proper fractions that are resilient; for example, R(12) = 4/11.
# In fact, d = 12 is the smallest denominator having a resilience R(d) < 4/10.
#
# Find the smallest denominator d, having a resilience R(d) < 15499/94744.

using ProjectEulerSolutions


# Slower, explicitly calculate the gcd for each fraction, skipping some when
# the number is a multiple of 2.  This is quite slow when n gets large, so we
# will not use it in the benchmarking.
function resilience_slow(n::Integer)::Float64
    count = 1
    step = 1
    if rem(n,2) == 0
        step = 2
    end
    for i in 1:step:n-2
        if gcd(i,n) == 1
            count += 1
        end
    end
    return count / (n-1)
end

# We are actually finding the solution to Euler's totient function divided by
# n-1.
function resilience_fast(n::Integer)::Float64
    return totient(n) / (n - 1)
end

# Brute force approach, with some logic.  The minimum resilience values will be
# when the denominator is a multiple of primes.  We find which multiple
# satisfies the initial constraint and then iterate through smaller
# multiplicative values.
function p243solution(thresh::Float64=0.4)::Integer
    primes = sieve_eratosthenes(30)
    index = 2
    while resilience_fast(prod(primes[1:index])) > thresh
        index += 1
    end
    starting_val = prod(primes[1:index-1])
    mult = 2
    while resilience_fast(mult * starting_val) > thresh
        mult += 1
    end
    return mult * starting_val
end

p243 = Problems.Problem(p243solution)

Problems.benchmark(p243, 15499/94744)
