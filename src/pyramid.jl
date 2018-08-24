"""
Returns the max value of a path through a pyramid of integers.
"""
function max_path_through_pyramid(pyramid::Vector{Vector{Integer}})::Integer

    pyramid_best_paths = Vector{Vector{Integer}}()
    for i = 1:length(pyramid)
        push!(pyramid_best_paths, zeros(Integer, length(pyramid[i])))
        # Initialize edge values
        if i == 1
            pyramid_best_paths[i][1] = pyramid[i][1]
        else
            pyramid_best_paths[i][1] = pyramid_best_paths[i-1][1] + pyramid[i][1]
            pyramid_best_paths[i][end] = pyramid_best_paths[i-1][end] + pyramid[i][end]
        end
    end

    for i = 3:length(pyramid)
        for j = 2:length(pyramid[i])-1
            pyramid_best_paths[i][j] = max(pyramid_best_paths[i-1][j-1],
                                           pyramid_best_paths[i-1][j]) +
                                       pyramid[i][j]
        end
    end

    return maximum(pyramid_best_paths[end])
end