# The number 3797 has an interesting property. Being prime itself, it is
# possible to continuously remove digits from left to right, and remain prime
# at each stage: 3797, 797, 97, and 7. Similarly we can work from right to
# left: 3797, 379, 37, and 3.
#
# Find the sum of the only eleven primes that are both truncatable from left to
# right and right to left.
#
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

include("Problems.jl")
include("sequence.jl")

# Helper function to generate an array of truncated integers given an input
# integer.
function truncatednumbers(n::Integer)::Array{Integer}
    numdigits = ndigits(n) - 1

    n_left = n
    n_right = n
    trunc_nums = Integer[]

    while numdigits > 0
        n_left = fld(n_left, 10)
        n_right = n_right % (10^numdigits)
        push!(trunc_nums, n_left)
        push!(trunc_nums, n_right)
        numdigits -= 1
    end

    return trunc_nums
end

# Use Seive of Eratosthenes to get primes, store in set, then cycle through
# them creating truncated numbers and checking whether all truncated numbers
# are prime.  If so, move the prime into the verified set.
function p037solution(n::Integer=10)::Integer

    primes = Set{Integer}(seive_eratosthenes(1_000_000))
    verified = Set{Integer}()

    num_truncs = 0
    for prime in primes
        if num_truncs == n
            break
        end
        if ndigits(prime) > 1
            digs = digits(prime)
            if digs[end] == 9 || mapreduce(x-> x % 2, *, digs[1:end-1]) == 0
                # If any digit (other than the first) is even or first digit is
                # a 9, ignore number
                continue
            end

            truncnums = truncatednumbers(prime)
            if mapreduce(prime -> in(prime, primes), &, truncnums)
                push!(verified, prime)
                num_truncs += 1
            end
        end
    end

    return sum(verified)
end

p037 = Problems.Problem(p037solution)

Problems.benchmark(p037, 11)