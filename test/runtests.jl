push!(LOAD_PATH, "../src")

for test in vcat(1:43, [67])
	println("Problem ", test, ":")
    include("../src/" * lpad(test, 3, '0') * ".jl")
    println()
end