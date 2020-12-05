include("../tools/input_generator.jl")

mapLines = GetInput("./input.txt")

global lineSize = length(mapLines[1])

function getTreesCountered(run, rise)::Int
    x = run + 1
    treeCount = 0
    
    for (index, line) in enumerate(mapLines[2:end])
        if (rise == 2 && index % rise != 0) continue; end;
        
        treeExists = line[x] == '#'

        if (treeExists)
            treeCount += 1
        end

        x += run

        if (x > lineSize)
            x = x % lineSize
        end
    end

    return treeCount
end

right_1 = getTreesCountered(1,1)
right_3 = getTreesCountered(3,1)
right_5 = getTreesCountered(5,1)
right_7 = getTreesCountered(7,1)
right_1_down_2 = getTreesCountered(1,2)


println("$right_1 $right_3 $right_5 $right_7 $right_1_down_2")
