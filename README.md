# 开源小鹤

配方： ℞ **openfly**

词库开源的[小鹤音形](https://flypy.com) [Rime](https://rime.im) 输入方案

## 用法

参考[小鹤入门](http://xhrm.flypy.com)

## 安装

### 最新版本
[东风破](https://github.com/rime/plum) 安装口令：
```bash
$ bash rime-install amorphobia/openfly@main
```

由于 plum 不能自动为 lua 脚本打补丁，因此还需手动在 `rime.lua` 文件中添加以下代码：
```lua
openfly_date_translator = require("openfly_date_translator")
openfly_time_translator = require("openfly_time_translator")
openfly_hint_filter = require("openfly_hint_filter")
```

注意：
- 默认分支版本为 `main` 而非 `master`，当前 plum 不支持更新默认分支为 main 的仓库 [plum/issues/43](https://github.com/rime/plum/issues/43), 因此更新时务必添加 `@main`

### 特定版本
东风破 安装口令：
```bash
$ bash rime-install amorphobia/openfly@<tag>
```

注意：
- [版本列表](https://github.com/amorphobia/openfly/releases)
- v9.9j 版本不支持自动复制 lua 脚本，需手动复制，并且在 `rime.lua` 中添加补丁代码

### 手动安装
1. 将所需文件复制（或软链）到 Rime 的用户目录

2. 将 `lua` 目录中的所有 `*.lua` 文件复制（或软链）到 Rime 的用户目录中的 `lua` 目录下，若无此目录需要新建，并在用户目录中的 `rime.lua` 文件后添加补丁代码

3. 在 `defult.custom.yaml` 里启用此方案，然后重新部署

## 词典分类

- **首选字词** openfly.primary.dict.yaml
- **次选字** openfly.secondary.char.dict.yaml
- **次选词** openfly.secondary.word.dict.yaml
- **表外字** openfly.off-table.dict.yaml
- **符号编码** openfly.symbols.dict.yaml
- **快符号** openfly.fast.symbols.dict.yaml
- **直通车** 小部分实现，四个网址放在 openfly.web.dict.yaml 里
- **随心所欲** openfly.whimsicality.dict.yaml
- **隐藏全码** 未收录
- **二重简码** openfly.secondary.short.code.dict.yaml
- **内嵌提示** 官方未单独显示此词库 openfly.embedded.hint.dict.yaml

## 已知问题

- 部分编码可更优化 [#6](https://github.com/amorphobia/openfly/issues/6)

## 许可和授权条款

### 小鹤音形官方词库和原始配置文件

见 [小鹤音形输入法最终用户许可协议](flypy-eula.md)

### 其他整理词库和配置文件

[`BY-NC`](by-nc.md)

### 程序代码部分

[`MIT`](LICENSE)
