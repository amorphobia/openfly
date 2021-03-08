local function filter(input, env)
  local is_short = string.len(env.engine.context.input) < 3
  local yielded_count = 0
  local disable_2nd = false
  if is_short then
    disable_2nd = not env.engine.context:get_option("openfly_enable_2nd_short")
  end
  -- http://lua-users.org/lists/lua-l/2006-12/msg00440.html
  -- In `repeat ... until true` use `break` to continue
  -- Use `_break = true break` to break normally
  for cand in input:iter() do local _break = false repeat
    if is_short and disable_2nd and yielded_count > 0 and cand.type ~= "completion" then break end
    local delimiter = string.find(cand.text, "`[^`]*$")
    if (delimiter == nil) then
      yield(cand)
    else
      local word = string.sub(cand.text, 1, delimiter - 1)
      local comment = string.sub(cand.text, delimiter + 1)
      if (word == "" or comment == "") then
        yield(cand)
      else
        local original_comment = cand:get_genuine().comment
        if word:sub(1,1) ~= "$" then
          yield(Candidate(cand.type, cand.start, cand._end, word, original_comment .. comment))
        else
          yield(Candidate(word, cand.start, cand._end, original_comment .. comment, ""))
        end
      end
    end
    yielded_count = yielded_count + 1
  until true if _break then break end end
end

return filter
