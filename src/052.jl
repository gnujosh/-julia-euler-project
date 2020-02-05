# It can be seen that the number, 125874, and its double, 251748, contain
# exactly the same digits, but in a different order.
#
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
# contain the same digits.

using ProjectEulerSolutions

# Check sets of digits to see if they are equivalent, but the trick is to cut
# down the search range from 100 to 166, 1000 to 1666, etc.  This becomes much
# simpler with the use of sort and the built-in digits function.
function p052solution_builtins(n::Integer=3)::Integer

    for factor_power in 2:n
        # Number must start with a 1
        x_start = 10^factor_power
        # Upper bound must be the same number of digits
        x_end = div(10^(factor_power + 1), 6)
        for x in x_start:x_end
            digit_set = sort(digits(x * 2))
            if digit_set == sort(digits(x * 3)) &&
               digit_set == sort(digits(x * 4)) &&
               digit_set == sort(digits(x * 5)) &&
               digit_set == sort(digits(x * 6))
                return x
            end
        end
    end
    return -1
end


# Explicitly handles the digit checking rather than using built-ins.  Faster,
# but more complicated.
function p052solution_explicit(n::Integer=3)::Integer
    for n_digits in 3:n
        # Number must start with a 1
        x_start = 10^(n_digits - 1)
        # Upper bound must be the same number of digits
        x_end = div(10^n_digits, 6)
        digs = zeros(Int8, 10)
        for x in x_start:x_end
            fill!(digs, 0)
            broke_early = false
            for m in 1:5
                num = x * (m + 1)
                for j in 1:n_digits
                    num2 = (num % 10) + 1
                    digs[num2] += 1
                    # Break early if one of the multipliers doesn't match
                    if digs[num2] != m
                        broke_early = true
                        break
                    end
                    num = div(num, 10)
                end
                if broke_early  # Inner loop broke early
                    break
                end
            end
            if ! broke_early
                return x
            end
        end
    end
    return -1
end

p052 = Problems.Problem(Dict("Built-ins" => p052solution_builtins,
                             "Explicit" => p052solution_explicit))


Problems.benchmark(p052, 7)
