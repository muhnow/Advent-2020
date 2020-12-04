function GetInput(path, asInt)::Array
    inputArray = []

    open(path) do file
        for line in eachline(file)
            push!(inputArray, line)
        end
    end

    if (asInt)
        return parseAsInt.(inputArray)
    end

    return inputArray
end

function parseAsInt(input)::Int
    return parse(Int, input)
end