# You are given the following information, but you may prefer to do some
# research for yourself.
#
# * 1 Jan 1900 was a Monday.
# * Thirty days has September,
#   April, June and November.
#   All the rest have thirty-one,
#   Saving February alone,
#   Which has twenty-eight, rain or shine.
#   And on leap years, twenty-nine.
# * A leap year occurs on any year evenly divisible by 4, but not on a century
#   unless it is divisible by 400.
#
# How many Sundays fell on the first of the month during the twentieth century
# (1 Jan 1901 to 31 Dec 2000)?

import Dates
include("Problems.jl")

# Trivial with the Dates module
function p019solution(first_year::Integer=1901, last_year::Integer=2000)::Integer
    total_days = 0
    for y in 1901:2000
        for m in 1:12
            if Dates.dayofweek(Dates.Date("$y-$m-1")) == 7
                total_days += 1
            end
        end
    end
    return total_days
end

p019 = Problems.Problem(p019solution)

Problems.benchmark(p019, 1901, 2000)