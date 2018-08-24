"""
Returns whether a number is a palindrome or not, using String operations
to pull out digits.
"""
function ispalindrome_string(n::Integer)::Bool
    stringval = string(n)
    return stringval == reverse(stringval)
end

"""
Returns whether a number is a palindrome or not, using normal integer
operations (floor, mod) to pull out digits
"""
function ispalindrome_integer(n::Integer)::Bool

    numdigits = floor(Integer, log10(n) + 1)
    @simd for d in (numdigits - 1):-2:1
        if fld(n, 10^d) != mod(n, 10)
            return false
        end
        n = fld(n - fld(n, 10^d) * 10^d, 10)
    end

    return true
end

"""
Returns whether a number is a palindrome or not, using Julia's built-in digits
function.
"""
function ispalindrome(n::Integer)::Bool
    ds = digits(n)
    for d in 1:fld(length(ds), 2)
        if ds[d] == ds[length(ds)-d]
            return false
        end
    end

    return true
end

"""
Returns a plain English string version of a number.
"""
function integer_to_string(n::Integer)::String
    ones_words = Dict{Integer, String}(1=>"one",
                                       2=>"two",
                                       3=>"three",
                                       4=>"four",
                                       5=>"five",
                                       6=>"six",
                                       7=>"seven",
                                       8=>"eight",
                                       9=>"nine")
    teen_words = Dict{Integer, String}(11=>"eleven",
                                       12=>"twelve",
                                       13=>"thirteen",
                                       14=>"fourteen",
                                       15=>"fifteen",
                                       16=>"sixteen",
                                       17=>"seventeen",
                                       18=>"eighteen",
                                       19=>"nineteen")
    tens_words = Dict{Integer, String}(10=>"ten",
                                       20=>"twenty",
                                       30=>"thirty",
                                       40=>"fourty",
                                       50=>"fifty",
                                       60=>"sixty",
                                       70=>"seventy",
                                       80=>"eighty",
                                       90=>"ninety")
    short_scale_words = Dict{Integer, String}(4 => "thousand",
                                              7 => "million",
                                              10 => "billion",
                                              13 => "trillion",
                                              16 => "quadrillion")
    hundred_word = "hundred"
    connector_word = "and"
    hyphen = "-"

    # Split each group of 3 digits in a large number into groups of 2 and 1
    # digits. So 234_423_032_001 will become [(2, 34), (4, 23), (0, 32), (0, 1)]
    # Rules for labeling are the same within each group of digit triplet.
    desc = ""
    for ndig in 1:3:ndigits(n)
        hundreds_digit = mod(fld(n, 100), 10)
        tens_digits = mod(n, 100)
        triplet_desc = ""
        if haskey(ones_words, hundreds_digit)
            triplet_desc = triplet_desc * ones_words[hundreds_digit] *
                           " $hundred_word "
            if (tens_digits > 0)
                triplet_desc = triplet_desc * "$connector_word "
            end
        end
        if haskey(tens_words, tens_digits)
            # Ends in a multiple of ten
            triplet_desc = triplet_desc * tens_words[tens_digits] * " "
        elseif haskey(teen_words, tens_digits)
            # Ends in a teen
            triplet_desc = triplet_desc * teen_words[tens_digits] * " "
        else
            # Ends in something else
            ones_digit = mod(n, 10)
            tens_digit = tens_digits - ones_digit
            tens_suffix = ""
            if haskey(tens_words, tens_digit)
                if haskey(ones_words, ones_digit)
                    tens_suffix = tens_words[tens_digit] * "$hyphen"
                else
                    tens_suffix = tens_words[tens_digit] * " "
                end
            end
            if haskey(ones_words, ones_digit)
                tens_suffix = tens_suffix * ones_words[ones_digit] * " "
            end
            triplet_desc = triplet_desc * tens_suffix
        end
        if haskey(short_scale_words, ndig)
            triplet_desc = triplet_desc * short_scale_words[ndig] * " "
        end
        desc = triplet_desc * desc
        n = fld(n, 1000)
    end
    return desc
end