# The number, 197, is called a circular prime because all rotations of the
# digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
# 73, 79, and 97.
#
# How many circular primes are there below one million?

include("Problems.jl")
include("prime.jl")

# Helper function to generate an array of circular shifts given an input
# integer.
function circularnumbers(n::Integer)::Array{Integer}
    digs = digits(n)
    numdigits = length(digs)
    multipliers = 10 .^ (0:numdigits-1)

    circular_nums = Integer[]
    for i in 1:numdigits-1
        push!(circular_nums, sum(multipliers .* circshift(digs, i)))
    end
    return circular_nums
end

# Use Seive of Eratosthenes to get primes, store in set, then cycle through
# them creating circular shifts and checking whether all shifts are prime.  If
# so, perform some set magic to move those primes into the verified set and
# remove from the potential circular primes set.
function p035solution(n::Integer=100)::Integer
    primes = Set{Integer}(seive_eratosthenes(n))
    verified = Set{Integer}()

    for prime in primes
        if ndigits(prime) == 1
            push!(verified, prime)
        else
            if mapreduce(x-> x % 2, *, digits(prime)) == 0
                # If any digit is even, ignore number
                continue
            end

            circnums = circularnumbers(prime)
            if mapreduce(prime -> in(prime, primes), &, circnums)
                push!(verified, prime)
                union!(verified, circnums)
                delete!(primes, prime)
                setdiff!(primes, circnums)
            end
        end
    end

    return length(verified)
end

p035 = Problems.Problem(p035solution)

Problems.benchmark(p035, 1_000_000)