# In the 5 by 5 matrix below, the minimal path sum from the top left to the
# bottom right, by only moving to the right and down, is indicated in bold red
# and is equal to 2427.
#
# 131 673 234 103 18
# 201 96  342 965 150
# 630 803 746 422 111
# 537 699 497 121 956
# 805 732 524 37  331
#
# Find the minimal path sum from the top left to the bottom right by only moving
# right and down in matrix.txt (right click and "Save Link/Target As..."), a 31K
# text file containing an 80 by 80 matrix.

using ProjectEulerSolutions


# Simple dynamic programming solution to fill in a matrix starting with the
# corner and then picking the min path to each consecutive cell.
function p081solution(path::String="")::Integer

    if !isfile(path)
        if path != ""
            println("Cannot find path: '", path, "'")
        end
        return -1
    end

    # Read in matrix from file
    matrix = reduce(hcat, [parse.(Int32, split(line, ',')) for line in eachline(path)])
    n, m = size(matrix)

    best_path = zeros(Integer, size(matrix))
    best_path[1,1] = matrix[1,1]

    # Initialize the edges since they only have a single path.  Make use of the
    # built-in cumulative sum function
    best_path[:,1] = cumsum(matrix[:,1])
    best_path[1,:] = cumsum(matrix[1,:])

    # Very simple dynamic programming solution for the rest
    for i = 2:n
        for j = 2:m
            best_path[i,j] = min(best_path[i-1,j], best_path[i,j-1]) + matrix[i,j]
        end
    end

    return best_path[end,end]
end

p081 = Problems.Problem(p081solution)

input_path = "data/p081_matrix.txt"

Problems.benchmark(p081, input_path)
