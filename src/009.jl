# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
#
# a^2 + b^2 = c^2
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

include("Problems.jl")

# Cycle through (from n down to n/2) to find sets of a and b that satisfy
# a + b + c = n.
function p009solution(n::Integer=4)::Integer

    maxval = fld(n, 2)
    for a = maxval:-1:2
        for b = maxval:-1:2
            c = sqrt(a*a + b*b)
            if c == floor(c) && a + b + c == n
                return a * b * c
            end
        end
    end

    # Should never happen
    return -1
end

# Note, there are probably faster options which use triplet generators.

p009 = Problems.Problem(p009solution)

Problems.benchmark(p009, 1000)