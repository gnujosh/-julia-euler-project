# Consider quadratic Diophantine equations of the form:
#
# x^2 - D * y^2 = 1
#
# For example, when D=13, the minimal solution in x is 649^2 - 13 × 180^2 = 1.
#
# It can be assumed that there are no solutions in positive integers when D is
# square.
#
# By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the
# following:
#
# 3^2 - 2×2^2 = 1
# 2^2 - 3×1^2 = 1
# 9^2 - 5×4^2 = 1
# 5^2 - 6×2^2 = 1
# 8^2 - 7×3^2 = 1
#
# Hence, by considering minimal solutions in x for D ≤ 7, the largest x is
# obtained when D=5.
#
# Find the value of D ≤ 1000 in minimal solutions of x for which the largest
# value of x is obtained.

using ProjectEulerSolutions

# This format for a Diophantine equation is called Pell's Equation.  It turns
# out that the minimal solution for x given a particular D is identified by
# finding the continued fraction convergent that approximates sqrt(D), and
# substituting into Pell's equation until it equals 1.  It turns out that the
# minimal values of x can get very large, like for D=61
# (https://oeis.org/A002350).  Since a quick solution for the minimal value is
# x is found, just cycle through D values storing the D with the largest x.
function p066solution(n_max::Integer=3)::Integer

    x_max = 0
    d_max = 0
    for D in 2:n_max
        if sqrt(D) == floor(sqrt(D))  # No solution for D = perfect square
            continue
        end

        # Need to use BigInts since the numerators and denominators can get
        # quite large
        a0 = BigInt(floor(sqrt(D)))
        a = a0
        m = 0
        d = 1
        A = Array{BigInt,1}([1, a0])
        B = Array{BigInt,1}([0, 1])
        k = 1
        while A[end]*A[end] - D*B[end]*B[end] != 1
            m = d * a - m
            d = div(D - m * m, d)
            a = div(a0 + m, d)
            append!(A, a * A[k+1] + A[k])
            append!(B, a * B[k+1] + B[k])
            k += 1
        end
        if x_max < A[end]
            x_max = A[end]
            d_max = D
        end
    end
    return d_max
end

p066 = Problems.Problem(p066solution)

Problems.benchmark(p066, 1000)
