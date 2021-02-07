local common = require("openfly_common")

local labels = {
  ["Windows"] = {
    ["oav"] = "[安装目录]",
    ["ocm"] = "[命令提示符]",
    ["odn"] = "[文件管理器]",
    ["oec"] = "[Excel]",
    ["ogj"] = "[Rime 用户目录]",
    ["oht"] = "[画图]",
    ["ojs"] = "[计算器]",
    ["owd"] = "[Word]",
    ["owt"] = "[Windows Terminal]"
  },
  ["Darwin"] = {
    ["ocm"] = "[终端]",
    ["odn"] = "[访达]",
    ["ogj"] = "[Rime 用户目录]",
    ["ojs"] = "[计算器]"
  }
}

local function translator(input, seg, env)
  local context = env.engine.context
  local sys = common.detect_os()
  local label = labels[sys][context.input]
  if label ~= nil then
    yield(Candidate("shortcut", seg.start, seg._end, " ", label))
  end
end

return translator
