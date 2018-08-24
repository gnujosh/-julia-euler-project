# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.

include("Problems.jl")
include("digit.jl")
include("sequence.jl")

# Treat numbers as strings and test by reversing them.
function p004string(ndigits::Integer=3)::Integer
    testnums = sort(unique_products_of_ndigits(ndigits), rev=true)
    for i in testnums
        if ispalindrome_string(i)
            return i
        end
    end
    return 0
end

# Treat numbers as integers and test by reversing them using modulus and floor
# to pull out individual digits.
function p004integer(ndigits::Integer=3)::Integer
    testnums = sort(unique_products_of_ndigits(ndigits), rev=true)
    for i in testnums
        if ispalindrome(i)
            return i
        end
    end
    return 0
end

# Same as previous, but no initial list construction using list comprehension.
function p004integer_fast(ndigits::Integer=3)::Integer
    maxnum = 10^ndigits - 1
    minnum = 10^(ndigits - 1) # Can probably assume this can be larger
    maxval = 0
    for i in minnum:maxnum
        for j in minnum:maxnum
            if j > i && ispalindrome(i*j)
                maxval = max(maxval, i*j)
            end
        end
    end
    return maxval
end

p004 = Problems.Problem(Dict("string reversal" => p004string,
                             "integer math" => p004integer,
                             "integer math fast" => p004integer_fast))

Problems.benchmark(p004, 3)