include("../tools/input_generator.jl")

global policies = GetInputAsInt("./input.txt")
global charLimitRegex = r"(?<min>\d*)-(?<max>\d*)"
global charToLimitRegex = r"\s(?<char>\w+):";

function main()
    validPasswords = 0

    for policy in policies
        passwordIsValid = isPasswordValid(policy)

        if (passwordIsValid)
            validPasswords += 1
        end
    end

    println(validPasswords)
end

function isPasswordValid(passwordPolicy)
    charMin = parse(Int, match(charLimitRegex, passwordPolicy)[:min])
    charMax = parse(Int, match(charLimitRegex, passwordPolicy)[:max])
    
    passwordPolicy = replace(passwordPolicy, charLimitRegex=>"")
    
    charToLimit = match(charToLimitRegex, passwordPolicy)[:char]
    
    passwordPolicy = replace(passwordPolicy, charToLimitRegex=>"")
    
    password = lstrip(passwordPolicy)

    firstOccurrence = string(password[charMin])
    secondOccurence = string(password[charMax])

    return xor(firstOccurrence == charToLimit, secondOccurence == charToLimit)
end


main()




