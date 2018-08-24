# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
# containing over five-thousand first names, begin by sorting it into
# alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a name
# score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which is
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
# would obtain a score of 938 × 53 = 49714.
#
# What is the total of all the name scores in the file?

include("Problems.jl")

# Use sort then map and collect to order names then convert to char array then
# difference from the char 'A'.
function p022_solution(path::String)::Integer
    all_names = Vector{String}()
    open(path) do file
        for row in eachline(file)
            rownames = split(row, ",")
            append!(all_names, [n[2:end-1] for n in rownames]) # Remove quotes
        end
    end
    sort!(all_names)

    return sum(map(x->sum(collect(x[2]).-'A'.+1)*x[1], enumerate(all_names)))
end

p022 = Problems.Problem(p022_solution)

input_path = "../data/p022_names.txt"

Problems.benchmark(p022, input_path)