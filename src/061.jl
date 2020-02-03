# Triangle, square, pentagonal, hexagonal, heptagonal, and octagonal numbers are
# all figurate (polygonal) numbers and are generated by the following formulae:
# 
# Triangle    P3,n=n(n+1)/2    1, 3, 6, 10, 15, ...
# Square      P4,n=n2          1, 4, 9, 16, 25, ...
# Pentagonal  P5,n=n(3n−1)/2   1, 5, 12, 22, 35, ...
# Hexagonal   P6,n=n(2n−1)     1, 6, 15, 28, 45, ...
# Heptagonal  P7,n=n(5n−3)/2   1, 7, 18, 34, 55, ...
# Octagonal   P8,n=n(3n−2)     1, 8, 21, 40, 65, ...
#
# The ordered set of three 4-digit numbers: 8128, 2882, 8281, has three
# interesting properties.
# 1. The set is cyclic, in that the last two digits of each number is the first
# two digits of the next number (including the last number with the first).
# 2. Each polygonal type: triangle (P3,127=8128), square (P4,91=8281), and
# pentagonal (P5,44=2882), is represented by a different number in the set.
# 4. This is the only set of 4-digit numbers with this property.
#
# Find the sum of the only ordered set of six cyclic 4-digit numbers for which
# each polygonal type: triangle, square, pentagonal, hexagonal, heptagonal, and
# octagonal, is represented by a different number in the set.

using ProjectEulerSolutions

# Solve for n given x and s: P(s,n) = x.
function polygonal_inv(s::Integer, x::Integer)::Float32
    return (sqrt(8*(s-2)*x + (s-4)^2) + (s-4))/(2*(s-2))
end

# Implements polygonal number P(s,n) = x, where s is the number of sides.
function polygonal_number(s::Integer, n::Integer)::Integer
   return div((s - 2) * n * n - n * (s - 4), 2)
end

# Helper recursive function to find the numbers that match the beginning and
# ending pairs.
function find_loop!(numbers::Array{Integer,1}, used_polys::Array{Integer,1}, end_pair::Integer, polys::Array{Array{Integer,1},1})::Bool
    d = 10^(ndigits(numbers[1])-2)
    if length(numbers) == 6 && end_pair == div(numbers[1], d)
        return true
    end
    ks = filter(x -> !(x in used_polys), 2:length(polys))
    for k in ks
        push!(used_polys, k)
        for n in polys[k]
            if div(n, d) == end_pair
                push!(numbers, n)
                found = find_loop!(numbers, used_polys, n % 100, polys)
                if found
                    return true
                end
                pop!(numbers)
            end
        end
        pop!(used_polys)
    end
    return false
end


# This is a verbose solution primarily due to manipulating the data into the
# correct data structures.  Only cycle through 4 digit polygonal numbers, then
# recursively loop through collections, remembering which polygonal numbers
# have already been used.  There is probably a graph-based solution which find
# paths through a network (6-partite graph?).
function p061solution(ndig_start::Integer=4, ndig_end::Integer=4)::Integer

    min_n = 10^(ndig_start-1)
    max_n = 10^ndig_end-1

    polys = Array{Array{Integer,1},1}()
    # Initialize data structure, making use of vectorized instructions
    for s = 3:8
        min_num = Integer(ceil(polygonal_inv(s, min_n)))
        max_num = Integer(floor(polygonal_inv(s, max_n)))

        # Calculate all 4 digit polygonal numbers for s
        poly_s = polygonal_number.(s, min_num:max_num)

        # Only keep numbers whose lower halves have two digits
        lower_s = poly_s .% 100
        inds = lower_s .> 9
        push!(polys, poly_s[inds])
    end

    # Loop through potential starting points, starting with s = 3.  The order
    # doesn't matter since all polygonal values are eventually used.
    used_polys = Array{Integer,1}([1])
    numbers = Array{Integer,1}()
    for n in polys[1]
        push!(numbers, n)
        if find_loop!(numbers, used_polys, n % 100, polys)
             return sum(numbers)
        end
        pop!(numbers)
    end

    return -1
end

p061 = Problems.Problem(p061solution)

Problems.benchmark(p061, 4, 4)