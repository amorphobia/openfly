local common = require("openfly_common")

local install_path = (rime_api ~= nil and rime_api.get_shared_data_dir ~= nil
  and {rime_api:get_shared_data_dir()}
  or {'%ProgramFiles(x86)%\\Rime\\weasel-0.14.3'})[1]
local user_path = (rime_api ~= nil and rime_api.get_user_data_dir ~= nil
  and {rime_api:get_user_data_dir()}
  or {'%appdata%\\Rime'})[1]

local command = {
  ["Windows"] = {
    ["oav"] = {'start "" "' .. install_path .. '"'},
    ["ocm"] = {'start "" "cmd.exe"', 'start "" "wt.exe"'},
    ["odn"] = {'start "" "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"'},
    ["oec"] = {'start "" "excel.exe"'},
    ["ogj"] = {'start "" "' .. user_path .. '"'},
    ["oht"] = {'start "" "mspaint.exe"'},
    ["ojs"] = {'start "" "calc.exe"'},
    ["owd"] = {'start "" "winword.exe"'}
  },
  ["Darwin"] = {
    ["ocm"] = {'open -a Terminal.app'},
    ["odn"] = {'open -a Finder.app'},
    ["ogj"] = {'open ~/Library/Rime'},
    ["ojs"] = {'open -a Calculator.app'}
  }
}

local function processor(key, env)
  local context = env.engine.context
  local sys = common.detect_os()
  if key:release() or key:alt() then return common.kNoop end
  local index = common.select_index(env, key)
  if index < 0 then return common.kNoop end
  if command[sys][context.input] ~= nil then
    local cmd = command[sys][context.input][index+1]
    if cmd ~= nil then
      os.execute(cmd)
      context:clear()
      return common.kAccepted
    end
  end

  local comp = context.composition
  if comp.empty == nil then return common.kNoop end
  if comp:empty() then return common.kNoop end
  local seg = comp:back()
  if seg == nil or seg.menu == nil or seg:has_tag("raw") then return common.kNoop end
  local page_size = env.engine.schema.page_size
  if index >= page_size then return common.kNoop end
  local page_start = math.floor(seg.selected_index / page_size) * page_size
  local cand = seg:get_candidate_at(page_start + index)
  if cand == nil then return common.kNoop end
  if cand.type:sub(1,1) ~= "$" then return common.kNoop end
  local new_input = string.match(cand.type, "%$(%w+)")
  if new_input == nil or new_input == "" then return common.kNoop end
  context.input = new_input
  return common.kAccepted
end

return processor
