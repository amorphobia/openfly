local function filter(input)
    for cand in input:iter() do
        local delimiter = string.find(cand.text, "`")
        if (delimiter == nil) then
            yield(cand)
        else
            local word = string.sub(cand.text, 1, delimiter - 1)
            local comment = string.sub(cand.text, delimiter + 1)
            if (word == "" or comment == "") then
                yield(cand)
            else
                yield(Candidate(cand.type, cand.start, cand._end, word, comment))
            end
        end
    end
end

return filter
