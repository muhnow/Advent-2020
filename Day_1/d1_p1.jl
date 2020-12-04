include("../tools/input_generator.jl")

input = GetInput("./input.txt")

global numberFound = false
global numbersTuple

for (outerIndex, outerNum) in enumerate(input)
    for (innerIndex, innerNum) in enumerate(input[outerIndex + 1:length(input)])
        if (outerNum + innerNum == 2020)
            global numberFound = true
            global numbersTuple = (outerNum, innerNum)

            break
        end
    end

    if (numberFound)
        break
    end
end

println(numbersTuple)

println(numbersTuple[1] * numbersTuple[2])