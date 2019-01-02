push!(LOAD_PATH, "../src")

tests = ARGS
if length(ARGS) == 0
    tests = vcat(1:46, [67])
end

for test in tests
	println("Problem ", test, ":")
    include("../src/" * lpad(test, 3, '0') * ".jl")
    println()
end