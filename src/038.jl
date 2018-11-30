# Take the number 192 and multiply it by each of 1, 2, and 3:
#
# 192 × 1 = 192
# 192 × 2 = 384
# 192 × 3 = 576
#
# By concatenating each product we get the 1 to 9 pandigital, 192384576. We
# will call 192384576 the concatenated product of 192 and (1,2,3)
#
# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
# and 5, giving the pandigital, 918273645, which is the concatenated product of
# 9 and (1,2,3,4,5).
#
# What is the largest 1 to 9 pandigital 9-digit number that can be formed as
# the concatenated product of an integer with (1,2, ... , n) where n > 1?

include("Problems.jl")

# Simple using Julia's builtin digits function.
function p038solution(n::Integer=10)::Integer
    pandigitals = Integer[]
    # Loop through initial multipliers and grab digits
    for i in 1:n
        digs = digits(i)
        prepend!(digs, digits(i * 2))
        mult = i * 3
        j = 3
        while ndigits(mult) <= 9 - length(digs)
            prepend!(digs, digits(mult))
            j += 1
            mult = i * j
        end
        # Turn into set to make sure there are 9 digits and none are 0
        digitset = Set(digs)
        if length(digitset) == 9 && ! in(0, digitset)
            # Convert back into integer
            append!(pandigitals, sum([digs[k+1] * 10^k for k in 0:8]))
        end
    end
    sort!(pandigitals, rev=true)
    return pandigitals[1]
end

p038 = Problems.Problem(p038solution)

Problems.benchmark(p038, 9999)
