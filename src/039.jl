# If p is the perimeter of a right angle triangle with integral length sides,
# {a,b,c}, there are exactly three solutions for p = 120.
#
# {20,48,52}, {24,45,51}, {30,40,50}
#
# For which value of p ≤ 1000, is the number of solutions maximised?

include("Problems.jl")

# Simple approach that cycles through legal ranges for a and b and storing
# counts of integer values of c.  Solution is the max of that array.  An even
# faster solution would involve directly generating Pythagorean triplets.
function p039solution(n::Integer=12)::Integer
    solutions = zeros(Integer, n)

    for a in 3:fld(n,3) # Range between 3 and n/3 (3 could be larger)
        for b in (a+1):fld(n,2)
            c = sqrt(a * a + b * b)
            if c - floor(c) == 0 && a + b + c <= n
                solutions[Integer(a + b + c)] += 1
            end
        end
    end

    return findmax(solutions)[2]
end

p039 = Problems.Problem(p039solution)

Problems.benchmark(p039, 10000)