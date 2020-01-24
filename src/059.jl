# Each character on a computer is assigned a unique code and the preferred
# standard is ASCII (American Standard Code for Information Interchange). For
# example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.
# 
# A modern encryption method is to take a text file, convert the bytes to
# ASCII, then XOR each byte with a given value, taken from a secret key. The
# advantage with the XOR function is that using the same encryption key on the
# cipher text, restores the plain text; for example, 65 XOR 42 = 107, then 107
# XOR 42 = 65.
#
# For unbreakable encryption, the key is the same length as the plain text
# message, and the key is made up of random bytes. The user would keep the
# encrypted message and the encryption key in different locations, and
# without both "halves", it is impossible to decrypt the message.
#
# Unfortunately, this method is impractical for most users, so the modified
# method is to use a password as a key. If the password is shorter than the
# message, which is likely, the key is repeated cyclically throughout the
# message. The balance for this method is using a sufficiently long password
# key for security, but short enough to be memorable.
#
# Your task has been made easy, as the encryption key consists of three lower
# case characters. Using p059_cipher.txt (right click and 'Save Link/Target
# As...'), a file containing the encrypted ASCII codes, and the knowledge that
# the plain text must contain common English words, decrypt the message and
# find the sum of the ASCII values in the original text.


using ProjectEulerSolutions

# Helper function for finding the most common element in an array.
function most_common(input::Array{Int8})::Int8
    d = Dict{eltype(input), Int}()
    for val in input
        if isa(val, Number) && isnan(val)
            continue
        end
        d[val] = get!(d, val, 0) + 1
    end
    top_key = 0
    most_val = 0
    for k in keys(d)
        if d[k] > most_val
            most_val = d[k]
            top_key = k
        end
    end
    return top_key
end


# Brute force solution, try all keys and keep the one with the most number
# of spaces.
function p059solution_bruteforce(path::String="")::Integer
    if !isfile(path)
        if path != ""
            println("Cannot find path: '", path, "'")
        end
        return -1
    end

    keylen = 3
    all_chars = [parse.(Int8, split(line, ',')) for line in eachline(path)][1]
    orig_len = length(all_chars)

    # Make a multiple of keylen for broadcasting our key
    diff_len = length(all_chars) % keylen
    for i in 1:diff_len
        push!(all_chars, 0)
    end
    all_chars = reshape(all_chars, keylen, :)

    start_keyval = Int8('a')
    end_keyval = Int8('z')
    key = fill(Int8(start_keyval), keylen)

    max_space = 0
    best_key = copy(key)
    for i in start_keyval:end_keyval
        key[1] = i
        for j in start_keyval:end_keyval
            key[2] = j
            for k in start_keyval:end_keyval
                key[3] = k
                x = all_chars .⊻ key
                count_space = sum(x .== Int8(' '))
                if count_space > max_space
                    max_space = count_space
                    best_key = copy(key)
                end
            end
        end
    end
    return sum(reshape(all_chars .⊻ best_key, length(all_chars), :)[1:orig_len])
end


# Here we assume that space is the most common character and xor the most common
# value from the file with ' ' for each section of the key to find the final key
# value.
function p059solution_xor(path::String="")::Integer
    if !isfile(path)
        if path != ""
            println("Cannot find path: '", path, "'")
        end
        return -1
    end

    keylen = 3
    all_chars = [parse.(Int8, split(line, ',')) for line in eachline(path)][1]
    orig_len = length(all_chars)
    # Make a multiple of keylen for broadcasting our key
    diff_len = length(all_chars) % keylen
    for i in 1:diff_len
        push!(all_chars, 0)
    end

    # Most likely char is a space.  XOR to find the key value that gives a space
    # for each key
    all_chars = reshape(all_chars, keylen, :)
    key = fill(Int8('a'), keylen)
    for i in 1:keylen
        key[i] = most_common(all_chars[i,:]) ⊻ Int8(' ')
    end

    return sum(reshape(all_chars .⊻ key, length(all_chars), :)[1:orig_len])
end


p059 = Problems.Problem(Dict("Brute Force" => p059solution_bruteforce,
                             "XOR" => p059solution_xor))

input_path = "data/p059_cipher.txt"

Problems.benchmark(p059, input_path)
