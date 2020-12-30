function date_translator(input, seg)
    if (input == "orq") then
        --- Candidate(type, start, end, text, comment)
        yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), ""))
        yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), " "))
    end
end

function time_translator(input, seg)
    if (input == "ouj") then
        local cand = Candidate("time", seg.start, seg._end, os.date("%H:%M"), " ")
        cand.quality = 1
        yield(cand)
    end
end

function openfly_hint_filter(input)
    for cand in input:iter() do
        local last = string.sub(cand.text, -1)
        if (last >= 'a' and last <= 'z') then
            local word = string.sub(cand.text, 1, -2)
            yield(Candidate("text", cand.start, cand._end, word, last))
        else
            yield(cand)
        end
    end
end
