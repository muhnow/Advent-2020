include("../tools/input_generator.jl")

passports = GetInput("./input.txt")

birthYearRegex = r"byr:"
issueYearRegex = r"iyr:"
expirationYearRegex = r"eyr:"
heightRegex = r"hgt:"
hairColorRegex = r"hcl:"
eyeColorRegex = r"ecl:"
passportIDRegex = r"pid:"

global validPassports = 0

# Dictionary{string, any}
global currPassportData

function main()
    global currPassportData = Dict{String, Any}()

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
    println(validPassports)
    # determine if the very last passport data stream is valid 
end   


function determinePassportValidity()
    missingData = filter(i->i==nothing, collect(values(currPassportData)))

    if (length(missingData) == 0)
        global validPassports += 1
    end

    global currPassportData = Dict{String, Any}()
end

function getPassportData(passportLine)
    birthYear = match(birthYearRegex, passportLine)
    issueYear = match(issueYearRegex, passportLine)
    expirationYear = match(expirationYearRegex, passportLine)
    height = match(heightRegex, passportLine)
    hairColor = match(hairColorRegex, passportLine)
    eyeColor = match(eyeColorRegex, passportLine)
    passportID = match(passportIDRegex, passportLine)
    
    global currPassportData["birthYear"] = haskey(currPassportData, "birthYear") && currPassportData["birthYear"] != nothing ? currPassportData["birthYear"] : birthYear;
    global currPassportData["issueYear"] = haskey(currPassportData, "issueYear") && currPassportData["issueYear"] != nothing ? currPassportData["issueYear"] : issueYear;
    global currPassportData["expirationYear"] = haskey(currPassportData, "expirationYear") && currPassportData["expirationYear"] != nothing ? currPassportData["expirationYear"] : expirationYear;
    global currPassportData["height"] = haskey(currPassportData, "height") && currPassportData["height"] != nothing ? currPassportData["height"] : height;
    global currPassportData["hairColor"] = haskey(currPassportData, "hairColor") && currPassportData["hairColor"] != nothing ? currPassportData["hairColor"] : hairColor;
    global currPassportData["eyeColor"] = haskey(currPassportData, "eyeColor") && currPassportData["eyeColor"] != nothing ? currPassportData["eyeColor"] : eyeColor;
    global currPassportData["passportID"] = haskey(currPassportData, "passportID") && currPassportData["passportID"] != nothing ? currPassportData["passportID"] : passportID;
end

main()