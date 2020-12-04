function GetInput(path)::Array{Int}
    inputArray = []

    open(path) do file
        for line in eachline(file)
            push!(inputArray, line)
        end
    end

    return parseAsInt.(inputArray)
end

function parseAsInt(input)::Int
    return parse(Int, input)
end