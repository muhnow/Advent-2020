include("../tools/input_generator.jl")
input = GetInputAsInt("./input.txt")

global numberFound = false
global numbersTuple = ()

function main()
    for (x_index, x) in enumerate(input)
        for (y_index, y) in enumerate(input[x_index + 1:length(input)])
            for (z_index, z) in enumerate(input[x_index + 2:length(input)])
                if (x + y + z == 2020)
                    println("$x $y $z")
                    @goto done
                end
            end
        end
    end

    @label done
end

@time begin
main()
end