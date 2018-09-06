# In England the currency is made up of pound, £, and pence, p, and there are
# eight coins in general circulation:
#
# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:
#
# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# How many different ways can £2 be made using any number of coins?

include("Problems.jl")

# Recursive solution count coin combinations.  In general, the idea is to
# consider each coin type and see how many ways there are to make a sum with
# that coin and lower denominations.  Different solutions can solve the
# recursion in slightly different ways.  Memoization is used to store lower
# level computatons.

# Uses a double recursion.
function p031solution_double(units::Array{Integer}=ones(Integer, 1), value::Integer=5)::Integer
    cache = zeros(Integer, value, length(units))
    return countcoins2(cache, units, length(units), value)
end

# Uses a single recursion, makes less total recursive calls.
function p031solution_single(units::Array{Integer}=ones(Integer, 1), value::Integer=5)::Integer
    cache = zeros(Integer, value, length(units))
    return countcoins1(cache, units, length(units), value)
end

# Uses no recursion, solution from https://projecteuler.net/thread=31
function p031solution_dp(units::Array{Integer}=ones(Integer, 1), value::Integer=5)::Integer
    ways = zeros(Integer, value)
    ways[1] = 1
    for coin in units
        for j in (coin+1):value
            ways[j] += ways[j - coin]
        end
    end
    return ways[value]
end


# Most straightforward recursive solution.
function countcoins2(cache::Array{Integer,2}, units::Array{Integer}, coin::Integer, amount::Integer)::Integer
    if amount == 0 # Coin divides equally, add 1
        return 1
    end
    if coin < 1 || amount < 0 # Coins don't divide equally
        return 0
    end
    if cache[amount, coin] > 0
        return cache[amount, coin]
    end

    # Sum of solutions without coin and with coin
    val = countcoins2(cache, units, coin - 1, amount) +
          countcoins2(cache, units, coin, amount - units[coin])
    cache[amount, coin] = val
    return val
end


# Simple refactoring, less total recursive calls.
function countcoins1(cache::Array{Integer,2}, units::Array{Integer}, coin::Integer, amount::Integer)::Integer
    if amount == 0
        return 1
    end
    if cache[amount, coin] > 0
        return cache[amount, coin]
    end
    res = 0
    for i in coin:-1:2
        if amount - units[i] >= 0
            res += countcoins1(cache, units, i, amount - units[i])
        end
    end

    # Account for smallest coin evenly dividing into amount
    if amount % units[1] == 0
        res += 1
    end

    cache[amount, coin] = res
    return res
end

p031 = Problems.Problem(Dict("Double recusion" => p031solution_double,
                             "Single recusion" => p031solution_single,
                             "Dynamic programming" => p031solution_dp))

Problems.benchmark(p031, convert(Array{Integer}, [1, 2, 5, 10, 20, 50, 100, 200]), 200)
