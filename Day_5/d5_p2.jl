include("../tools/input_generator.jl")

directions = GetInput("./input.txt")

global seatIDs = []

for direction in directions
    chosenRow = 0
    chosenCol = 0

    maxRow = 127
    minRow = 0
    maxCol = 7
    minCol = 0

    rules = split(direction, "")

    # parsing the rule
    for rule in rules
        if (rule == "F")
            maxRow -= round((maxRow - minRow) / 2)
            chosenRow = minRow
        elseif (rule == "B")
            minRow += round((maxRow - minRow) / 2)
            chosenRow = maxRow 
        elseif (rule == "R")
            minCol += round((maxCol - minCol) / 2)
            chosenCol = maxCol
        elseif (rule == "L")
            maxCol -= round((maxCol - minCol) / 2)
            chosenCol = minCol
        end

    end

    result = (chosenRow * 8) + chosenCol

    push!(seatIDs, result)
end

maxSeatID = maximum(seatIDs)

seatIDs = sort(seatIDs)

for (index, ID) in enumerate(seatIDs[1:end-1])
    if (index == 1) continue; end;

    prevID = seatIDs[index - 1]
    nextID = seatIDs[index + 1]

    if (nextID - prevID == 3) 
        # if the last and next ID have a difference of 3, that means that
        # our seat ID is the current ID + 1
        println(ID + 1)
        break;
    end
end

# take upper half = update min
# min += (max - min) / 2 (rounded up)

# take lower half = update max 
# max -= (max - min) / 2  (rounded down)