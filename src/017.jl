# If the numbers 1 to 5 are written out in words: one, two, three, four, five,
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out
# in words, how many letters would be used?
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
# letters. The use of "and" when writing out numbers is in compliance with
# British usage.

include("Problems.jl")
include("digit.jl")

# Convert integer to string, remove hyphens and spaces, then add up lengths.
function p017solution(n::Integer=1000)::Integer

    total_length = 0
    for i = 1:n
        total_length += length(replace(integer_to_string(i), r"[- ]" => s""))
    end

    return total_length
end

p017 = Problems.Problem(p017solution)

Problems.benchmark(p017, 1_000)