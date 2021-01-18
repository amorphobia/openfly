local function processor(key, env)
    local engine = env.engine
    local context = engine.context
    local kNoop = 2

    local sep = package.config:sub(1,1)
    -- https://stackoverflow.com/a/14425862/6676742
    if (sep == "\\") then
        -- Windows
        if context.input == "oav" then
            os.execute('start "path" %ProgramFiles(x86)%\\Rime\\weasel-0.14.3')
            context:clear()
        elseif context.input == "ocm" then
            os.execute('start "cmd" "cmd.exe"')
            context:clear()
        elseif context.input == "odn" then
            os.execute('start "pc" "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"')
            context:clear()
        elseif context.input == "oec" then
            os.execute('start "excel" "excel.exe"')
            context:clear()
        elseif context.input == "ogj" then
            os.execute('start "path" %appdata%\\Rime')
            context:clear()
        elseif context.input == "oht" then
            os.execute('start "paint" "mspaint.exe"')
            context:clear()
        elseif context.input == "ojs" then
            os.execute('start "calc" "calc.exe"')
            context:clear()
        elseif context.input == "owd" then
            os.execute('start "word" "winword.exe"')
            context:clear()
        end
        return kNoop
    end

    local sys = io.popen("uname -s"):read("*l")
    if (sys == "Darwin") then
        -- macOS
    elseif (sys == "Linux") then
        -- Linux
    end
    return kNoop
end

return processor
