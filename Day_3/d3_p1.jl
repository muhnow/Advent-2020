include("../tools/input_generator.jl")

mapLines = GetInput("./input.txt")

global x = 4
global treeCount = 0
global lineSize = length(mapLines[1])

for line in mapLines[2:end]
    treeExists = line[x] == '#'

    if (treeExists)
        global treeCount += 1
    end

    global x += 3

    if (x > lineSize)
        x = x % lineSize
    end
end

println(treeCount)
