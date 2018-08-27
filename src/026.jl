# A unit fraction contains 1 in the numerator. The decimal representation of
# the unit fractions with denominators 2 to 10 are given:

# 1/2 =   0.5
# 1/3 =   0.(3)
# 1/4 =   0.25
# 1/5 =   0.2
# 1/6 =   0.1(6)
# 1/7 =   0.(142857)
# 1/8 =   0.125
# 1/9 =   0.(1)
# 1/10    =   0.1
#
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
# seen that 1/7 has a 6-digit recurring cycle.
#
# Find the value of d < 1000 for which 1/d contains the longest recurring cycle
# in its decimal fraction part.

include("Problems.jl")

# Solve using greedy regex to pull out the longest repeated sequence of digits.
# Could be made slightly faster to consider only prime values between 2 and n.
function p026solution_regex(n::Integer=3)::Integer
    numdigits = 2500
    regexstring = r"(\d+?)\1"
    lengths = zeros(Integer, n)

    for i = 3:2:n
        stringnum = string(fld(BigInt(10)^numdigits,i))
        lengths[i] = mapreduce(m->length(m.captures[1]), max, eachmatch(regexstring, stringnum))
    end

    return findmax(lengths)[2]
end

# Cycles through a sequence of numbers building up larger numbers until it sees
# one it has seen before.  Could be made slightly faster to consider only prime
# values between 2 and n.
function p026solution_repeats(n::Integer=3)::Integer
    totalmax = 0
    maxind = 1
    for i = 3:2:n
        seennumbers = Set{Integer}()
        r = 10
        j = 0
        while ! in(r, seennumbers)
            if r == 0
                break
            end
            push!(seennumbers, r)
            r = 10 * (r % i)
            j += 1
        end

        if j > totalmax
            totalmax = j
            maxind = i
        end
    end

    return maxind
end

p026 = Problems.Problem(Dict("regex" => p026solution_regex,
                             "repeats" => p026solution_repeats))

Problems.benchmark(p026, 1000)