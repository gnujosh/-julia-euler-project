# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
#
# Find the sum of all numbers, less than one million, which are palindromic in
# base 10 and base 2.
#
# (Please note that the palindromic number, in either base, may not include
# leading zeros.)

using ProjectEulerSolutions

# Simple using Julia's builtin bitstring and parse functions (with BigInt).
function p036solution(n::Integer=10)::Integer
    sums = 0
    for i in 1:n
        if ispalindrome_integer(i) && ispalindrome(parse(BigInt, bitstring(i)))
            sums += i
        end
    end
    return sums
end

p036 = Problems.Problem(p036solution)

Problems.benchmark(p036, 1_000_000)
