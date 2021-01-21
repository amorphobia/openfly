local function detect_os()
    local sys = ""
    local sep = package.config:sub(1,1)
    if sep == "\\" then
        sys = "Windows"
    else
        local f = io.open("/usr/bin/uname", "r")
        local h = os.getenv("HOME")
        if f ~= nil then
            io.close(f)
            sys = io.popen("uname -s"):read("*l")
        elseif string.find(h, "/private/var/mobile/") ~= nil then
            sys = "iOS"
        else
            sys = "Others"
        end
    end
    return sys
end

return { detect_os = detect_os }
