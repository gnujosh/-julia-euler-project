push!(LOAD_PATH, "../src")

tests = ARGS
if length(ARGS) == 0
    files = readdir("../src")

    tests = Array{Integer,1}()
    for file in files
        m = match(r"(\d+)\.jl", file)
        if m != nothing
            append!(tests, parse(Int32, m.captures[1]))
        end
    end
end

for test in tests
    println("Problem ", test, ":")
    include("../src/" * lpad(test, 3, '0') * ".jl")
    println()
end