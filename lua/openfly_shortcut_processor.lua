local common = require("openfly_common")

local command = {
    ["Windows"] = {
        ["oav"] = 'start "" "%ProgramFiles(x86)%\\Rime\\weasel-0.14.3"',
        ["ocm"] = 'start "" "cmd.exe"',
        ["odn"] = 'start "" "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"',
        ["oec"] = 'start "" "excel.exe"',
        ["ogj"] = 'start "" "%appdata%\\Rime"',
        ["oht"] = 'start "" "mspaint.exe"',
        ["ojs"] = 'start "" "calc.exe"',
        ["owd"] = 'start "" "winword.exe"'
    },
    ["Darwin"] = {
        ["ocm"] = 'open -a Terminal.app',
        ["odn"] = 'open -a Finder.app',
        ["ogj"] = 'open ~/Library/Rime',
        ["ojs"] = 'open -a Calculator.app'
    }
}

local function processor(key, env)
    local engine = env.engine
    local context = engine.context

    local sys = common.detect_os()
    local cmd = command[sys][context.input]
    if cmd ~= nil then
        os.execute(cmd)
        context:clear()
    end
    return common.kNoop
end

return processor
