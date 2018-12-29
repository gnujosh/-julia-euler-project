# The fraction 49/98 is a curious fraction, as an inexperienced mathematician
# in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which
# is correct, is obtained by cancelling the 9s.
#
# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
#
# There are exactly four non-trivial examples of this type of fraction, less
# than one in value, and containing two digits in the numerator and denominator.
#
# If the product of these four fractions is given in its lowest common terms,
# find the value of the denominator.

using ProjectEulerSolutions

# Cycle through numbers using Julia's built-in digits, and store the fractions
# as rationals.  Julia's built-in rationals solve the common denominator
# problem easily.
function p033solution()::Integer
    rationals = Rational[]
    for a in 10:98
        for b in (a+1):99
            if a != b
                val = a / b
                da = digits(a)
                db = digits(b)
                if da[1] == db[1] && da[1] != 0 && da[2] / db[2] == val
                    push!(rationals, a // b)
                elseif da[1] == db[2] && da[2] / db[1] == val
                    push!(rationals, a // b)
                elseif da[2] == db[1] && da[1] / db[2] == val
                    push!(rationals, a // b)
                elseif da[2] == db[2] && da[1] / db[1] == val
                    push!(rationals, a // b)
                end
            end
        end
    end
    return denominator(prod(rationals))
end

p033 = Problems.Problem(p033solution)

Problems.benchmark(p033)