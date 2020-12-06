include("../tools/input_generator.jl")

groupAnswers = GetInput("./input.txt")

global answers = []
global answerCount = 0

function main()
    while length(groupAnswers) > 0
        answer = popfirst!(groupAnswers)

        if (answer == "")
            countUniqueAnswers()
            continue
        end

        getIndividualAnswers(answer)
    end

    # last group is counted here
    countUniqueAnswers()

    println(answerCount)
end

function countUniqueAnswers()
    global answerCount += length(Set(answers))

    global answers = []
end


function getIndividualAnswers(answer)
    individualAnswers = split(answer, "")

    global answers = vcat(answers, individualAnswers)
end

main()

