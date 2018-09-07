# We shall say that an n-digit number is pandigital if it makes use of all the
# digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1
# through 5 pandigital.
#
# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
# multiplicand, multiplier, and product is 1 through 9 pandigital.
#
# Find the sum of all products whose multiplicand/multiplier/product identity
# can be written as a 1 through 9 pandigital.
#
# HINT: Some products can be obtained in more than one way so be sure to only
# include it once in your sum.

include("Problems.jl")
include("factorization.jl")

# Uses factorization to find sets of digits from the products.  Shortcuts full
# comparisons when the total number of digits is incorrect.
function p032solution_factors(n::Integer=3)::Integer

    startval = 10^(fld(n, 2) - 1)
    endval = 10^fld(n, 2)

    desired_digits = Set{Integer}(1:n)
    products = Integer[]
    for k in startval:endval
        facs = factors(k)
        factorlen = length(facs)
        numdigits = map(ndigits, facs[2:end])
        numdigits = numdigits .+ reverse(numdigits) .+ ndigits(k)
        # Only look at half the factors
        for i in 2:cld(factorlen, 2)
            if numdigits[i-1] == n
                alldigits = Set(vcat(digits(facs[i]),
                                     digits(facs[factorlen - i + 2]),
                                     digits(k)))
                if (desired_digits == alldigits)
                    push!(products, k)
                end
            end
        end
    end
    return sum(Set(products))
end

# Uses a digits from multipliers of the correct lengths.  If a, b, c are the
# number of digits in the multiplicands and product, then a + b + c = n.  We
# know that a + b < c < a + b + 1, so 2(a + b) < n < 2(a + b) + 1.  So we pick
# a: 1 < a < 0.5*n and b: 0.5*n - 0.5 - a < b < 0.5*n - a
function p032solution_multipliers(n::Integer=5)::Integer
    products = Integer[]
    desired_digits = Set{Integer}(1:n)
    r = n / 2
    as = 2:floor(Integer, 10^r)
    for a in as
        na = ndigits(a)
        minb = max(10, floor(Integer, 10^(r - 0.5 - na)))
        maxb = max(minb, floor(Integer, 10^(r - na)))

        for b in minb:maxb
            c = a * b
            if na + ndigits(b) + ndigits(c) == n
                alldigits = Set(vcat(digits(a), digits(b), digits(c)))
                if (desired_digits == alldigits)
                    push!(products, c)
                end
            end
        end
    end
    return sum(Set(products))
end

p032 = Problems.Problem(Dict("factors" => p032solution_factors,
                             "multipliers" => p032solution_multipliers))

Problems.benchmark(p032, 9)