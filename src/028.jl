# Starting with the number 1 and moving to the right in a clockwise direction a
# 5 by 5 spiral is formed as follows:
#
# 21 22 23 24 25 26
# 20  7  8  9 10 27
# 19  6  1  2 11 28
# 18  5  4  3 12 29
# 17 16 15 14 13 30
#
# It can be verified that the sum of the numbers on the diagonals is 101.
#
# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
# formed in the same way?

using ProjectEulerSolutions

# Create and sum the sequence of corner values, then increment.
function p028solution_increment(n::Integer=5)::Integer
    val = 1
    startindex = 3
    for i = 2:2:n
        val += sum(collect(startindex .+ (0:i:i*3)))
        startindex = startindex + 4*i + 2
    end
    return val
end

# Closed form solution by noticing that the number in the top right corner is
# n^2 and the other corners as: n^2-n+1, n^2-2n+2, and n^2-3n+3.  Summing gives
# 4n^2-6n+6
function p028solution_broadcast(n::Integer=5)::Integer
    nset = 3:2:n
    vals = 4 .* nset .^ 2 .- 6 .* nset .+ 6
    return sum(vals) + 1
end

# Even more closed form solution solving for sum of series, which is:
# 2n^3/3 + n^2/2 + 4n/3 - 5/2.  Somehow it is not faster than either previous
# solution.
function p028solution_closedform(n::Integer=5)::Integer
    return fld(4 * n^3 + 3 * n^2 + 8 * n - 9, 6)
end

p028 = Problems.Problem(Dict("Incremental" => p028solution_increment,
                             "Broadcast"   => p028solution_broadcast,
                             "Closed form" => p028solution_closedform))

Problems.benchmark(p028, 1001)