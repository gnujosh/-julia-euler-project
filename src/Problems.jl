module Problems

struct Problem
    solutions::Dict{String, Function}
    Problem(problems::Dict{String, Function}) = new(problems)
    Problem(func::Function) = new(Dict("Solution" => func))
end

function benchmark(p::Problem, x...)
    key = collect(keys(p.solutions))[1]
    for k in collect(keys(p.solutions))
        p.solutions[k]()
    end
    sol = 0
    for problem in p.solutions
        println(string(problem[1], ":"))
        @time sol = problem[2](x...)
    end
    println(string("Answer: ", sol))
end

end