module Problems

struct Problem
    solutions::Dict{String, Function}
    Problem(problems::Dict{String, Function}) = new(problems)
    Problem(func::Function) = new(Dict("Solution" => func))
end

function benchmark(p::Problem, x...)
    key = collect(keys(p.solutions))[1]
    println(string("Answer: ", p.solutions[key](x[1])))
    for problem in p.solutions
        println(string(problem[1], ":"))
        @time problem[2](x[1])
    end
end

end