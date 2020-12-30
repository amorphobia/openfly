# Openfly

开放词库的小鹤音形 Rime 配置

## 小鹤音形

[官网](https://flypy.com/)

## 安装方法

1. 将所需文件复制（或软链）到 Rime 的用户目录
```shell
$ git clone https://github.com/amorphobia/openfly
$ cp *.yaml *.lua <Rime 用户目录>
```

2. 根据需要新建用户词典 `openfly.user.dict.yaml` 和 `openfly.user.top.dict.yaml` 或者在 `openfly.dict.yaml` 里删除相应行

3. 根据需要新建自定义设置 `openfly.custom.yaml`

4. 在 `defult.custom.yaml` 里启用此方案，然后重新部署

## 已知问题

1. 缺少部分内嵌编码 [#3](https://github.com/amorphobia/openfly/issues/3)
2. 暂时无法经部署生成反查文件 [#4](https://github.com/amorphobia/openfly/issues/4)
