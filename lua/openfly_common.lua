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

local function status(context)
  local stat = {}
  local composition = context.composition
  stat.always = true
  stat.composing = context:is_composing()
  stat.empty = not stat.composing
  stat.has_menu = context:has_menu()
  stat.paging = not composition.empty() and composition:back():has_tag("paging")
  return stat
end

return {
  detect_os = detect_os,
  status = status,
  kRejected = 0,
  kAccepted = 1,
  kNoop = 2
}
