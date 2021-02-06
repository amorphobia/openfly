local function filter(input, env)
  local skip = env.engine.context.input:sub(1,1) == "`"
  local candidates = {}
  local del_text = {}
  local index_text = {}
  for cand in input:iter() do
    if not skip then
      table.insert(index_text, cand.text)
      candidates[cand.text] = cand
      if cand:get_genuine().comment == "[删]" then
        table.insert(del_text, cand.text)
      end
    else
      yield(cand)
    end
  end
  for i, t in pairs(del_text) do
    candidates[t] = nil
  end
  for i, t in pairs(index_text) do
    if candidates[t] ~= nil then
      yield(candidates[t])
    end
  end
end

return filter
