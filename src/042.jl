# The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1);
# so the first ten triangle numbers are:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# By converting each letter in a word to a number corresponding to its
# alphabetical position and adding these values we form a word value. For
# example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value
# is a triangle number then we shall call the word a triangle word.
#
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
# containing nearly two-thousand common English words, how many are triangle
# words?

include("Problems.jl")

function p042solution()::Integer

    path = "../data/p042_words.txt"

    # Store reasonable set of triangular numbers
    max_triangular_number = 26*20

    trinumbers = Set{Integer}()
    i = 1
    trinumber = 1
    while trinumber < max_triangular_number
        trinumber = i * (i + 1) / 2
        push!(trinumbers, trinumber)
        i += 1
    end

    allwords = Vector{String}()
    if isfile(path)
        open(path) do file
            for row in eachline(file)
                rownames = split(row, ",")
                append!(allwords, [n[2:end-1] for n in rownames]) # Remove quotes
            end
        end
    end

    triangular_words = 0
    for word in allwords
        if sum(collect(word) .- 'A' .+ 1) in trinumbers
            triangular_words += 1
        end
    end

    return triangular_words
end

p042 = Problems.Problem(p042solution)

Problems.benchmark(p042)