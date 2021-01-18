local function processor(key, env)
    local engine = env.engine
    local context = engine.context
    local kNoop = 2

    local cmd = ''
    local sys = ''
    -- https://stackoverflow.com/a/14425862/6676742
    local sep = package.config:sub(1,1)
    if (sep == "\\") then
        -- Windows
        if context.input == "oav" then
            cmd = 'start "" "%ProgramFiles(x86)%\\Rime\\weasel-0.14.3"'
        elseif context.input == "ocm" then
            cmd = 'start "" "cmd.exe"'
        elseif context.input == "odn" then
            cmd = 'start "" "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"'
        elseif context.input == "oec" then
            cmd = 'start "" "excel.exe"'
        elseif context.input == "ogj" then
            cmd = 'start "" "%appdata%\\Rime"'
        elseif context.input == "oht" then
            cmd = 'start "" "mspaint.exe"'
        elseif context.input == "ojs" then
            cmd = 'start "" "calc.exe"'
        elseif context.input == "owd" then
            cmd = 'start "" "winword.exe"'
        end
    else
        sys = io.popen("uname -s"):read("*l")
    end

    if (sys == "Darwin") then
        -- macOS
        if context.input == "ocm" then
            cmd = 'open -a Terminal.app'
        elseif context.input == "odn" then
            cmd = 'open -a Finder.app'
        elseif context.input == "ogj" then
            cmd = 'open ~/Library/Rime'
        elseif context.input == "ojs" then
            cmd = 'open -a Calculator.app'
        end
    elseif (sys == "Linux") then
        -- Linux
    end
    if (cmd ~= "") then
        os.execute(cmd)
        context:clear()
    end
    return kNoop
end

return processor
