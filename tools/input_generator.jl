function GetInput(path)::Array{String}
    inputArray = []

    open(path) do file
        for line in eachline(file)
            push!(inputArray, line)
        end
    end

    return inputArray
end

function GetInputAsInt(path)::Array{Int}
    inputArray = GetInput(path)

    return parseAsInt.(inputArray)
end

function parseAsInt(input)::Int
    return parse(Int, input)
end