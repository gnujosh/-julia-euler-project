# An irrational decimal fraction is created by concatenating the positive
# integers:
#
# 0.123456789101112131415161718192021...
#
# It can be seen that the 12th digit of the fractional part is 1.
#
# If dn represents the nth digit of the fractional part, find the value of the
# following expression.
#
# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

using ProjectEulerSolutions

# Estimate the number of digits of the positive integer that n lies in, then
# calculate the positive integer that n lies in, then calculate what digit of
# that number n indexes into.
function get_nth_digit(n::Integer=10)::Integer

    # Note the following patterns for numbers ndig long:
    #
    # ndig  len(seq)  start    end
    #  1     9         1        9
    #  2     90        10       99
    #  3     900       100      999
    #  4     9000      1000     9999
    #  5     90000     10000    99999

    # Find out the number of digits long the positive integers that n lies in.
    if n < 9
        return n
    end
    k = n
    ndig = 1
    while k > ndig * 9 * 10^(ndig - 1)
        k -= (ndig * 9 * 10^(ndig - 1))
        ndig += 1
    end

    startnum = 10^(ndig-1)
    innum = startnum + fld(k, ndig)
    digitsin = mod(k, ndig)
    return digitindex(innum, mod(k, ndig))
end

function p040solution(n::Integer=3)::Integer

    return prod(map(get_nth_digit, 10 .^ (0:n)))
end

p040 = Problems.Problem(p040solution)

Problems.benchmark(p040, 6)