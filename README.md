# 开源小鹤

配方： ℞ **openfly**

词库开源的[小鹤音形](https://flypy.com) [Rime](https://rime.im) 输入方案

## 问题和资源

### 小鹤音形的使用相关

请参考[小鹤入门](http://xhrm.flypy.com)和[小鹤论坛](https://bbs.flypy.com)，也欢迎在[讨论页面](https://github.com/amorphobia/openfly/discussions)参与讨论。

### Rime 引擎的配置相关

请参考 [Rime 官方帮助页面](https://rime.im/docs/), 以及网上也能搜索到许多教程。如果还是有问题，也可以在[讨论页面](https://github.com/amorphobia/openfly/discussions)提出。

### 本配方相关

请先参考本文，如果是本文没有提到的使用上的问题，可以在[讨论页面](https://github.com/amorphobia/openfly/discussions)提出；如果怀疑是程序错误、词库错误、配置错误等，可以在[议题页面](https://github.com/amorphobia/openfly/issues)提出；如果想要贡献代码或修改词库，也可以提交[拉取请求](https://github.com/amorphobia/openfly/pulls)。

## 安装

### 最新版本
[东风破](https://github.com/rime/plum) 安装口令：
```bash
# 默认版本，词典分为多个文件
$ bash rime-install amorphobia/openfly
# 词典合并版本，除用户词典以外，合并为一个文件
$ bash rime-install amorphobia/openfly@merged_dict
```
更新口令（在安装口令后加 `:update`, 可以不覆盖 `openfly.user.dict.yaml` 和 `openfly.user.top.dict.yaml` 两个文件）：
```bash
# 默认版本
$ bash rime-install amorphobia/openfly:update
# 词典合并版本
$ bash rime-install amorphobia/openfly@merged_dict:update
```

由于 plum 不能自动为 lua 脚本打补丁，因此还需手动在 `rime.lua` 文件中添加以下代码：
<span id="patch"></span>
```lua
openfly_shortcut_processor = require("openfly_shortcut_processor")
openfly_date_translator = require("openfly_date_translator")
openfly_time_translator = require("openfly_time_translator")
openfly_shortcut_translator = require("openfly_shortcut_translator")
openfly_hint_filter = require("openfly_hint_filter")
openfly_deletion_filter = require("openfly_deletion_filter")
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
- **二重简码** openfly.secondary.short.code.dict.yaml, 默认开启，可在 `openfly.dict.yaml` 里注释掉以关闭
- **内嵌提示** 官方未单独显示此词库 openfly.embedded.hint.dict.yaml

## 直通车

[官方版 Rime 挂载配方](http://flypy.ys168.com/)已通过 `lua_translator` 实现时间和日期的输入，本配方稍作修改，使其与官方安装版输出一致。

四个小鹤的网址放在 openfly.web.dict.yaml 里，与官方安装版不同的是，网址是作为上屏词组输出，而非直接运行浏览器打开。

直通车中打开外部程序的命令通过 `lua_processor` 实现。<del>由于 [librime-lua 只支持 `SimpleCandidate`](https://github.com/hchunhui/librime-lua/issues/11#issuecomment-504748077)，暂时无法实现原版小鹤音形中显示为候选项、再选择候选项运行命令，只能在输入编码后直接运行命令。</del>已通过 `openfly_shortcut_translator` 和 `openfly_shortcut_processor` 搭配实现。由于 [Lua 中 `os.execute` 的限制](https://stackoverflow.com/a/6365296/6676742)，在 Windows 中运行命令时会闪现一个命令提示符窗口。

在 macOS 中输入编码之后需要再按任意一个键才能运行命令，暂不知道原因。（推荐按下 <kbd>Shift</kbd>）

已实现的快捷指令（括号内标注已实现平台）：

- `oav` 打开 Rime 安装目录 (Windows)
- `ocm` 打开命令提示符或终端 (Windows/macOS)
- `odn` 文件管理器 (Windows/macOS)
- `oec` Excel (Windows)
- `ogj` 高级设置，即打开 Rime 用户目录 (Windows/macOS)
- `oht` 画图软件 (Windows)
- `ojs` 计算器 (Windows/macOS)
- `owd` Word (Windows)

## 删词功能

从 [6ee1bac](https://github.com/amorphobia/openfly/commit/6ee1bacdcc20fdf93f10793f8c5c942fb42b4425) 起，支持在用户词典中加入编码来删除词库中（包括内嵌编码提示词库）的词条，使用方式是在用户词典 `openfly.user.dict.yaml` 或 `openfly.user.top.dict.yaml` 中添加如下格式的词条

```
词语`[删]	编码
```

其实在任意一个词典里添加都可以，不过建议不修改配方中的词典，这也是为什么推出删词功能的原因——删词的时候可以不修改配方中的词典，避免更新的时候改动被覆盖。

需要注意的是，词语后的撇号是键盘上数字 <kbd>1</kbd> 左边的符号；撇号后面的“删”字前后有半角的方括号，和编码之间是制表符而不是空格。

例如，想要删除“鹤	eh”这个不规则的编码，可以在用户词典里加上：

```
鹤`[删]	eh
```

如此一来，“鹤”字就只能通过 `hedn` 这个编码打出，而 `eh` 就可以放入你想要的词了。

## 许可和授权条款

### 小鹤音形官方词库和原始配置文件

见 [小鹤音形输入法最终用户许可协议](flypy-eula.md)

### 其他整理词库和配置文件

[`BY-NC`](by-nc.md)

### 程序代码部分

[`MIT`](LICENSE)
