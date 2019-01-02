# The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
# 
# Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

using ProjectEulerSolutions

# Multiply using mods since only the last 10 digits matter.  Faster than the
# bigint solution after about n > 30,000, and uses much less memory.
function p048solution_mod(n::Integer=100)::Integer
    total = 1
    for i in 2:n
        s = i
        for j in 2:i
            s = mod(s * i, 10^10)
        end
        total = mod(total + s, 10^10)
    end
    return total
end

# Trivial with Julia's BigInt support, and fast.
function p048solution_bigint(n::Integer=100)::Integer
    return mod(mapreduce(x->x^x, +, BigInt.(1:n)), 10^10)
end

p048 = Problems.Problem(Dict("Modulus" => p048solution_mod,
                             "Bigint" => p048solution_bigint))

Problems.benchmark(p048, 1000)