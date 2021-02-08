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
  local index = common.select_index(env, key) + 1
  if index <= 0 then return common.kNoop end
  local cmd = command[sys][context.input][index]
  if cmd ~= nil then
    os.execute(cmd)
    context:clear()
    return common.kAccepted
  end
  return common.kNoop
end

return processor
