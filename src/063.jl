# The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit
# number, 134217728=8^9, is a ninth power.
#
# How many n-digit positive integers exist which are also an nth power?

using ProjectEulerSolutions

# Brute for approach, cycling through nth powers on single digits until we see
# that no more signal digits have the right number of digits (using the built-in
# ndigits function).
function p063solution_bruteforce(max_n::Integer=10)::Integer

    digs = BigInt.(1:9)
    count = 0
    for n = 1:max_n
        c = sum(ndigits.(digs .^ n) .== n)
        if c == 0
           break
        end
        count += c
    end
    return count
end

# Recognize that a single digit number k will have n digits as long as 
# 10^(n-1) <= k^n < 10^n.  We know k^n < 10^n when k is 1:9.  Solve for k
# 10^((n-1) / n) <= k and cycle through n values to see the number of values for
# n where the relation holds.  Vectorize and try with k = 1:9 to solve the
# problem in a single line.
function p063solution_explicit_powers(max_n::Integer=10)::Integer
    return Integer(sum(9 .- floor.(10 .^((0:(max_n-1))./(1:max_n)))) + 1)
end

# Alternatively, solve directly for n: 10^(n-1) = k^n, (n-1) log(10) = n log(k),
# n = log(10) / (log(10) - log(k)), where we pass values for k = 1:9.
function p063solution_explicit_logs(max_n::Integer=10)::Integer
    return Integer(sum(floor.(log.(10)./(log.(10).-log.(1:9)))))
end

p063 = Problems.Problem(Dict("Brute-force" => p063solution_bruteforce,
                             "Explicit powers" => p063solution_explicit_powers,
                             "Explicit logs" => p063solution_explicit_logs))

Problems.benchmark(p063, 30)
