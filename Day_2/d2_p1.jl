include("../tools/input_generator.jl")

global policies = GetInputAsInt("./input.txt")
global charLimitRegex = r"(?<min>\d*)-(?<max>\d*)"
global charToLimitRegex = r"\s(?<char>\w+):"

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

    # this isn't immediately obvious, but eachmatch will give us an iterator for all of the matches
    # found. We can then use list comprehension to grab the offset (index of occurence) and then count
    # that resulting list to get our character count. This was done because Julia doesn't really have a 
    # good way of counting characters in strings.
    charCount = length([x.offset for x in eachmatch(Regex(charToLimit), password)])

    return charCount <= charMax && charCount >= charMin
end


main()




