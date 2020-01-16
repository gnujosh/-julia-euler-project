export Problems

module Problems

struct Problem
    solutions::Dict{String, Function}
    Problem(problems::Dict{String, Function}) = new(problems)
    Problem(func::Function) = new(Dict("Solution" => func))
end

function benchmark(p::Problem, x...)
    key = collect(keys(p.solutions))[1]
    sol = 0
    # Initial run with default small value
    for k in collect(keys(p.solutions))
        sol = p.solutions[k]()
    end
    for problem in p.solutions
        println("  ", problem[1], ":")
        print("  ")
        @time sol = problem[2](x...)
    end
    println("  Answer: ", sol)
end

end
