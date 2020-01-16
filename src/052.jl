# It can be seen that the number, 125874, and its double, 251748, contain
# exactly the same digits, but in a different order.
#
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
# contain the same digits.

using ProjectEulerSolutions

# Check sets of digits to see if they are equivalent, but the trick is to cut
# down the search range from 100 to 166, 1000 to 1666, etc.
function p052solution(n::Integer=3)::Integer

    for factor_power in 2:n
        # Number must start with a 1
        x_start = 10^factor_power
        # Upper bound must be the same number of digits
        x_end = div(10^(factor_power + 1), 6)
        for x in x_start:x_end
            digit_set = Set(digits(x))
            if digit_set == Set(digits(x * 2)) &&
               digit_set == Set(digits(x * 3)) &&
               digit_set == Set(digits(x * 4)) &&
               digit_set == Set(digits(x * 5)) &&
               digit_set == Set(digits(x * 6)) &&
                return(x)
            end
        end
    end
    return -1
end

p052 = Problems.Problem(p052solution)

Problems.benchmark(p052, 7)
