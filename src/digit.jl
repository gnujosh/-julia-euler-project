
function ispalindrome_string(n::Integer)::Bool
    stringval = string(n)
    return stringval == reverse(stringval)
end

function ispalindrome(n::Integer)::Bool

    numdigits = ceil(Integer, log10(n))
    for d in (numdigits - 1):-2:1
        if (floor(n / 10^d) != mod(n, 10))
            return false
        end
        n = floor(Integer, (n - floor(n / 10^d) * 10^d) / 10)
    end
    return true
end