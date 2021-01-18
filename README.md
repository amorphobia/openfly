# 开源小鹤

配方： ℞ **openfly**

词库开源的[小鹤音形](https://flypy.com) [Rime](https://rime.im) 输入方案

## 用法

参考[小鹤入门](http://xhrm.flypy.com)

## 安装

### 最新版本
[东风破](https://github.com/rime/plum) 安装口令：
```bash
$ bash rime-install amorphobia/openfly
```

由于 plum 不能自动为 lua 脚本打补丁，因此还需手动在 `rime.lua` 文件中添加以下代码：
<span id="patch"></span>
```lua
openfly_shortcut_processor = require("openfly_shortcut_processor")
openfly_date_translator = require("openfly_date_translator")
openfly_time_translator = require("openfly_time_translator")
openfly_hint_filter = require("openfly_hint_filter")
```

### 特定版本
东风破 安装口令：
```bash
$ bash rime-install amorphobia/openfly@<tag>
```

注意：
- [版本列表](https://github.com/amorphobia/openfly/releases)
- v9.9j 版本不支持自动复制 lua 脚本，需手动复制
- 需要在 `rime.lua` 中添加[补丁代码](#patch)

### 手动安装
1. 将所需文件复制（或软链）到 Rime 的用户目录

2. 将 `lua` 目录中的所有 `*.lua` 文件复制（或软链）到 Rime 的用户目录中的 `lua` 目录下，若无此目录需要新建，并在用户目录中的 `rime.lua` 文件后添加[补丁代码](#patch)

3. 在 `defult.custom.yaml` 里启用此方案，然后重新部署

## 词典分类

- **首选字词** openfly.primary.dict.yaml
- **次选字** openfly.secondary.char.dict.yaml
- **次选词** openfly.secondary.word.dict.yaml
- **表外字** openfly.off-table.dict.yaml
- **符号编码** openfly.symbols.dict.yaml
- **快符号** openfly.fast.symbols.dict.yaml
- **直通车** 部分实现，见[直通车](#直通车)部分
- **随心所欲** openfly.whimsicality.dict.yaml
- **隐藏全码** 未直接收录，反查词典是基于全码首选的单字和隐藏全码的单字生成
- **二重简码** openfly.secondary.short.code.dict.yaml
- **内嵌提示** 官方未单独显示此词库 openfly.embedded.hint.dict.yaml

## 直通车

[官方版 Rime 挂载配方](http://flypy.ys168.com/)已通过 `lua_translator` 实现时间和日期的输入，本配方稍作修改，使其与官方安装版输出一致。

四个小鹤的网址放在 openfly.web.dict.yaml 里，与官方安装版不同的是，网址是作为上屏词组输出，而非直接运行浏览器打开。

直通车中打开外部程序的命令通过 `lua_processor` 实现。由于 [librime-lua 只支持 `SimpleCandidate`](https://github.com/hchunhui/librime-lua/issues/11#issuecomment-504748077)，暂时无法实现原版小鹤音形中显示为候选项、再选择候选项运行命令，只能在输入编码后直接运行命令。另外，由于 [Lua 中 `os.execute` 的限制](https://stackoverflow.com/a/6365296/6676742)，在 Windows 中运行命令时会闪现一个命令提示符窗口。

已实现的快捷指令（括号内标注已实现平台）：

- `oav` 打开 Rime 安装目录 (Windows)
- `ocm` 命令提示符 (Windows)
- `odn` 文件管理器 (Windows)
- `oec` Excel (Windows)
- `ogj` 高级设置，即打开 Rime 用户目录 (Windows)
- `oht` 画图软件 (Windows)
- `ojs` 计算器 (Windows)
- `owd` Word (Windows)

## 已知问题

- 部分编码可更优化 [#6](https://github.com/amorphobia/openfly/issues/6)

## 许可和授权条款

### 小鹤音形官方词库和原始配置文件

见 [小鹤音形输入法最终用户许可协议](flypy-eula.md)

### 其他整理词库和配置文件

[`BY-NC`](by-nc.md)

### 程序代码部分

[`MIT`](LICENSE)
