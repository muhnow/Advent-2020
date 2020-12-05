include("../tools/input_generator.jl")

passports = GetInput("./input.txt")

birthYearRegex = r"(byr:)(?<year>\d{4})"
issueYearRegex = r"(iyr:)(?<year>\d{4})"
expirationYearRegex = r"(eyr:)(?<year>\d{4})"
heightRegex = r"(hgt:)(?<height>\d+)(?<unit>cm|in)"
hairColorRegex = r"(hcl:)(#(?<haircolor>(a|b|c|d|e|f|\d){6}))"
eyeColorRegex = r"(ecl:)(?<eyecolor>amb|blu|brn|gry|grn|hzl|oth)"
passportIDRegex = r"pid:(?<id>\d{9})"

global validPassports = 0

# Dictionary{string, any}
global currPassportData

function main()
    global currPassportData = Dict{String, Bool}()

    while length(passports) > 0
        passportLine = popfirst!(passports)
        # empty strings represent the end of a "stream" of passport data
        # here we need to determine if we've collected enough data
        if(passportLine == "")
            determinePassportValidity()
            continue;
        end
        
        getPassportData(passportLine)
    end

    determinePassportValidity()

    # this solution is off by 1, not entirely sure how
    println(validPassports)
    # determine if the very last passport data stream is valid 
end   


function determinePassportValidity()
    missingData = filter(key->currPassportData[key]==false, collect(keys(currPassportData)))

    if (length(missingData) == 0)
        println(missingData)
        global validPassports += 1
    end

    global currPassportData = Dict{String, Bool}()
end

function getPassportData(passportLine)
    issueYear = match(issueYearRegex, passportLine)
    expirationYear = match(expirationYearRegex, passportLine)
    height = match(heightRegex, passportLine)
    hairColor = match(hairColorRegex, passportLine)
    eyeColor = match(eyeColorRegex, passportLine)
    passportID = match(passportIDRegex, passportLine)
    
    global currPassportData["birthYear"] = birthYearIsValid(passportLine)
    global currPassportData["issueYear"] = issueYearIsValid(passportLine)
    global currPassportData["expirationYear"] = notExpired(passportLine)
    global currPassportData["height"] = heightIsValid(passportLine)
    global currPassportData["hairColor"] = hairColorIsValid(passportLine)
    global currPassportData["eyeColor"] = eyeColorIsValid(passportLine)
    global currPassportData["passportID"] = passportIdIsValid(passportLine)
end

function birthYearIsValid(passportLine)::Bool 
    if (haskey(currPassportData, "birthYear") && currPassportData["birthYear"] != false)
        return true
    end

    birthYearMatch = match(birthYearRegex, passportLine)

    if(birthYearMatch != nothing)
        birthYear = parse(Int, birthYearMatch[:year])

        return birthYear >= 1920 && birthYear <= 2002
    end

    return false
end

function issueYearIsValid(passportLine)::Bool 
    if (haskey(currPassportData, "issueYear") && currPassportData["issueYear"] != false)
        return true
    end

    issueYearMatch = match(issueYearRegex, passportLine)

    if(issueYearMatch != nothing)
        issueYear = parse(Int, issueYearMatch[:year])

        return issueYear >= 2010 && issueYear <= 2020
    end

    return false
end

function notExpired(passportLine)::Bool 
    if (haskey(currPassportData, "expirationYear") && currPassportData["expirationYear"] != false)
        return true
    end

    expirationYearMatch = match(expirationYearRegex, passportLine)

    if(expirationYearMatch != nothing)
        expirationYear = parse(Int, expirationYearMatch[:year])

        return expirationYear >= 2020 && expirationYear <= 2030
    end

    return false
end

function heightIsValid(passportLine)::Bool
    if (haskey(currPassportData, "height") && currPassportData["height"] != false)
        return true
    end

    heightMatch = match(heightRegex, passportLine)

    if (heightMatch != nothing)
        height = parse(Int, heightMatch[:height])
        units = heightMatch[:unit]

        if (units == "cm")
            return height >= 150 && height <= 193
        elseif (units == "in")
            return height >= 59 && height <= 76
        end
    end

    return false
end

function hairColorIsValid(passportLine)::Bool
    if (haskey(currPassportData, "hairColor") && currPassportData["hairColor"] != false)
        return true
    end

    hairColorMatch = match(hairColorRegex, passportLine)

    return hairColorMatch != nothing
end

function eyeColorIsValid(passportLine)::Bool
    if(haskey(currPassportData, "eyeColor") && currPassportData["eyeColor"] != false)
        return true
    end

    eyeColorMatch = match(eyeColorRegex, passportLine)

    return eyeColorMatch != nothing
end

function passportIdIsValid(passportLine)::Bool
    if(haskey(currPassportData, "passportID") && currPassportData["passportID"] != false)
        return true
    end

    pidMatch = match(passportIDRegex, passportLine)

    return pidMatch != nothing
end



main()