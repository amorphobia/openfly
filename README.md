# 开源小鹤

配方： ℞ **openfly**

词库开源的[小鹤音形](https://flypy.com) [Rime](https://rime.im) 输入方案

> [!NOTE]
> ## 声明
> 注意到输入法同好时常会有方案性能对比的图表，但 Openfly 无意参与其中，因为本方案仅仅是对于 v9 时代官方小鹤的复刻，任何性能表现均类似或不敌官方小鹤。烦请看到本声明的同好将 Openfly 从中拿掉，感谢理解。

## 现状

由于小鹤官方的词库是「闭源」的，并且在禁止反编译的情况下难以导出，我已经放弃小鹤音形，转而使用[星空键道](https://github.com/xkinput/Rime_JD)（入门推荐[这个第三方教程](https://pingshunhuangalex.gitbook.io/rime-xkjd/)），词库版本就无限期停留在 [v10.9z](https://github.com/amorphobia/openfly/releases/tag/v10.9z)。但这个仓库不会归档，因此有任何词库上、lua 代码上的更新，欢迎提出拉取请求。如果有公认的更好的分叉仓库，我会更新 README 引流过去。

## 问题和资源

### 小鹤音形的使用相关

请参考[小鹤入门](http://xhrm.flypy.com)和[小鹤论坛](https://bbs.flypy.com)，也欢迎在[讨论页面](https://github.com/amorphobia/openfly/discussions)参与讨论。

### Rime 引擎的配置相关

请参考 [Rime 官方帮助页面](https://rime.im/docs/), 以及网上也能搜索到许多教程。如果还是有问题，也可以在[讨论页面](https://github.com/amorphobia/openfly/discussions)提出。

本配方使用了较新版本的 librime 的特性，Windows 用户请升级到[小狼毫 0.15.0](https://github.com/rime/weasel/releases/tag/0.15.0) 或以上版本。

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

### 特定版本
东风破 安装口令：
```bash
$ bash rime-install amorphobia/openfly@<tag>
```

注意：
- [版本列表](https://github.com/amorphobia/openfly/releases)
- v9.9j 版本不支持自动复制 lua 脚本，需手动复制

### 手动安装
1. 将所需文件复制（或软链）到 Rime 的用户目录

2. 将 `lua` 目录中的所有 `*.lua` 文件复制（或软链）到 Rime 的用户目录中的 `lua` 目录下，若无此目录需要新建

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
- **一简词** openfly.secondary.single.word.dict.yaml, 默认开启，可在 `openfly.dict.yaml` 里注释掉以关闭

## 直通车

[官方版 Rime 挂载配方](http://flypy.ys168.com/)已通过 `lua_translator` 实现时间和日期的输入，本配方稍作修改，使其与官方安装版输出一致。

四个小鹤的网址放在 `openfly.web.dict.yaml` 里，与官方安装版不同的是，网址是作为上屏词组输出，而非直接运行浏览器打开。

直通车中打开外部程序的命令通过 `lua_processor` 实现。由于 [Lua 中 `os.execute` 的限制](https://stackoverflow.com/a/6365296/6676742)，在 Windows 中运行命令时会闪现一个命令提示符窗口。

已实现的快捷指令（括号内标注已实现平台）：

- `oav` 打开 Rime 程序目录 (Windows/macOS)
- `ocm` 打开命令提示符或终端 (Windows/macOS)
- `odn` 文件管理器 (Windows/macOS)
- `oec` Excel (Windows/macOS)
- `ogj` 高级设置，即打开 Rime 用户目录 (Windows/macOS)
- `oht` 画图软件 (Windows)
- `ojs` 计算器 (Windows/macOS)
- `owd` Word (Windows/macOS)

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

## 候选展开

原版小鹤音形基于多多输入法，可以使用命令生成特殊的候选，选择之后并非上屏词语，而是展开新的输入。比如输入 `ofb`, 显示的候选是「d(标点)、，。」，但选择之后输入码变成了 `ofbd`, 候选也变成了相应的。

从 [626d100](https://github.com/amorphobia/openfly/commit/626d100fe941a472f4f49e841ce116f62ac9b574) 起，本配方使用 lua 脚本实现了这个功能。

### 候选格式

用于展开的候选与普通候选一样，由词组、`tab` 和编码组成，其中词组分为两个部分，第一部分是展开后的编码，用 `$` 标识出，第二部分用于候选展开前的显示，与第一部分用 `` ` `` 隔开。例如

```
$ofbd`d(标点)、，。	ofb
```

其中 `$ofbd` 是展开后的编码，选中这个候选就如同输入了 `ofbd`，`d(标点)、，。` 是展开前的提示，而与之用 `tab` 隔开的 `ofb` 则是输入码。

### 已知限制

1. 由于 librime-lua 的一个程序错误，直到 [00c999b](https://github.com/hchunhui/librime-lua/commit/00c999b3c9230d7a6a4f6410479e123b5010d9b8) 之后，才能正确地判断一个 `Composition` 是否为空，因此对于较旧的版本，候选展开不起作用，会直接上屏。请升级 rime 引擎到 [1.7.2](https://github.com/rime/librime/releases/tag/1.7.2) 或以上。
2. 二重简码的切换开关暂时无法使用。目前 librime 最新的版本为 [1.7.3](https://github.com/rime/librime/releases/tag/1.7.3)，发布于2021年2月12日；二重简码切换开关依赖于 librime-lua 的 [88ba821](https://github.com/hchunhui/librime-lua/commit/88ba82165306ec6d49b9a9bfcd369d096a1f6d94)，代码合并于2021年3月5日。如果要将其打开，一个暂时的方案是在 `switches` 里加上一个名为 `openfly_enable_2nd_short` 的开关，设其值为 1，见[此例](https://github.com/amorphobia/my-rime-config/blob/ea4b310ea6336efa0626dc9ee1345a52152b7240/openfly.custom.yaml#L10)；有能力的可以使用最新的代码编译 librime 及其插件。

## 许可和授权条款

### 小鹤音形官方词库和原始配置文件

见 [小鹤音形输入法最终用户许可协议](flypy-eula.md)

### 其他整理词库和配置文件

[`BY-NC`](by-nc.md)

### 程序代码部分

[`MIT`](LICENSE)
