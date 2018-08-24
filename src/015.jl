# Starting in the top left corner of a 2×2 grid, and only being able to move to
# the right and down, there are exactly 6 routes to the bottom right corner.
#
# How many such routes are there through a 20×20 grid?

include("Problems.jl")

# Memoization type solution to store intermediate results.
function p015solution(n::Integer=20)::Integer
    counts = zeros(Integer, n+1, n+1)
    counts[1, :] .= 1  # There's only one way down.
    counts[:, 1] .= 1  # There's only one way to the right.

    # Count for a cell is the sum of the counts above and to the left.
    for i = 2:n+1
        for j = 2:n+1
            counts[i, j] = counts[i-1, j] + counts[i, j-1]
        end
    end

    return counts[end, end]
end

p015 = Problems.Problem(p015solution)

Problems.benchmark(p015, 20)