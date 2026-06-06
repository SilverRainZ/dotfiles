---
name: aur-to-archlinuxcn
description: 当用户提供一个 AUR 包名，要把它加入 archlinuxcn 仓库时使用
---

# 将 AUR 包加入 ArchlinuxCN

## 概述

从 AUR 下载包 → 用 devtools 验证构建 → 编写 lilac.yaml 使 lilac 自动构建 → 用 `addpkg:` 消息提交。

## 完整流程

```
用户提供 AUR 包名
      │
      ▼
cd ~/pkg/gitrepo/archlinuxcn
paru -G <包名>（下载）
      │
      ▼
调用 AUR RPC API 获取上游维护者
      │
      ▼
删除包目录中的 .git/ 和 .SRCINFO
      │
      ▼
cd <包名>
extra-x86_64-build
      │
  ┌──────────────────┐
  │ 构建成功？       │
  └───┬──────────┬───┘
      是         否
      │          │
      ▼          ▼
编写 lilac.yaml  报告错误，修复后重试
      │
      ▼
git add . && git commit -m "addpkg: <包名>"
```

## 第 1 步：下载 AUR 包

```bash
paru -G <包名>
```

在 `~/pkg/gitrepo/archlinuxcn/` 目录下执行。如果该目录已存在，先提醒用户。

## 第 2 步：获取 AUR 上游维护者

通过 AUR RPC API 查询包的维护者（必填）。API 返回 `Maintainer` 字段，注意 `Maintainer` 可能为 `null`（孤儿包）：

```bash
curl -s 'https://aur.archlinux.org/rpc/v5/info/<包名>' | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d['results'][0].get('Maintainer') or 'orphan')"
```

如果包名和 pkgbase 不同（如 `python-xxx` 的 pkgbase 可能是 `python-xxx` 或另一个名字），需用 pkgbase 查询。pkgbase 可从 `paru -G` 下载后查看 `.SRCINFO` 中的 `pkgbase` 行。

返回的 `Maintainer` 值直接用作 lilac.yaml 中 `aur_pre_build(maintainers=['<这里>'])` 的参数。如果返回 `null`，表示该包是孤儿包，可省略 `maintainers=` 参数（此时 `aur_pre_build()` 不覆盖维护者行）。

## 第 3 步：清理文件

AUR 快照包含一个 `.git` 目录，删除它以便提交到 archlinuxcn 仓库：

```bash
rm -rf ~/pkg/gitrepo/archlinuxcn/<包名>/.git
```

同时删除 `.SRCINFO`（lilac 会自动重新生成）：

```bash
rm -f ~/pkg/gitrepo/archlinuxcn/<包名>/.SRCINFO
```

## 第 4 步：用 Devtools 构建

在包目录下执行构建。`extra-x86_64-build` 默认使用干净 chroot 并跳过签名检查：

```bash
cd ~/pkg/gitrepo/archlinuxcn/<包名>
extra-x86_64-build
```

默认使用 `extra-x86_64-build`。仅当包的依赖只在 archlinuxcn 仓库中存在时才改用 `archlinuxcn-x86_64-build`。

`extra-x86_64-build` 默认已传递 `-c -n -C` 给 `makechrootpkg`。常用选项：

- `-c`：构建前重建 chroot
- `-r <dir>`：指定自定义 chroot 目录
- `-- <args>`：透传额外参数给 `makechrootpkg`

常见构建问题及修复：

- **缺少 makedepends**：手动安装到 chroot 或补充 PKGBUILD 中的 makedepends
- **GPG 签名错误**：默认 `-n` 已跳过签名检查；若仍报错，检查 keyring 是否最新
- **超时**：大多数包默认时限足够；大包需要在 lilac.yaml 中设置 `time_limit_hours`

## 第 5 步：编写 lilac.yaml

构建成功后，分析 PKGBUILD 并生成 lilac.yaml：

### 4a. 确定更新源（update_on）

| PKGBUILD 特征                                                | 使用 `update_on` 源               |
| ------------------------------------------------------------ | --------------------------------- |
| `source=("git+https://github.com/...")`                      | `github`                          |
| `source=("$pkgname-$pkgver.tar.gz::https://github.com/...")` | `github` + `use_latest_release`   |
| 标准 `source=("https://...")` 带上游 release 链接            | `github` 或 `aur`，视上游情况而定 |
| 有 `pkgver()` 函数，从 GitHub 解析版本                       | `github`                          |
| 简单下载 + 校验和，无自动版本检测                            | `aur`（让 AUR 跟踪版本）          |

**经验法则**：若 PKGBUILD 已包含自动版本检测（如通过 git tag 或 GitHub API 的 `pkgver()`），用 `github` 源直连上游。否则用 `aur` 作为更新源。

### 4b. 确定 build_prefix

- **`extra-x86_64`**：默认值，用于大多数包。使用 Arch `[extra]` 仓库的 chroot。
- **`archlinuxcn-x86_64`**：当 PKGBUILD 中的 `depends=()` 或 `makedepends=()` 包含仅在 archlinuxcn 中存在的包时使用。`portable`/`-bin` 类包若依赖 archlinuxcn 工具也使用此值。

### 4c. 编写 pre_build / post_build 脚本

**AUR 跟踪型**（最常用）：

`aur_pre_build(maintainers=[...])` 中的上游维护者 **必须填写**。值来自第 2 步 AUR API 返回的 `Maintainer` 字段：

```yaml
pre_build_script: |
  aur_pre_build(maintainers=['<AUR Maintainer>'])

post_build: aur_post_build
```

- 多个维护者用 `['aaa', 'bbb']` 格式
- 若 API 返回 `null`（孤儿包），省略 `maintainers=` 参数，直接用 `aur_pre_build()`
- 若 API 返回的维护者名包含空格或特殊字符，需要加引号

**GitHub / 直连上游型**：

```yaml
pre_build_script: |
  update_pkgver_and_pkgrel(_G.newver.lstrip('v'))

post_build_script: |
  git_pkgbuild_commit()
  update_aur_repo()
```

- 若 tag 不带 `v` 前缀，去掉 `.lstrip('v')`
- 若 tag 有特殊命名规则，使用 `include_regex` 过滤，并在脚本中做相应字符串处理
- **何时用 `update_aur_repo()`**：仅当该包在 AUR 中存在，且希望 lilac 把更新后的 PKGBUILD 推回 archlinuxcn 的 AUR 镜像时使用。非 AUR 包省略此行。

### 4d. 固定 maintainers 块

```yaml
maintainers:
  - github: SilverRainZ
    email: Shengyu Zhang <la@archlinuxcn.org>
```

### 4e. 可选字段

**`time_limit_hours`**：构建耗时超过 1 小时的包必须设置（如 `linux-cachyos`、大型 C++/Rust 项目）。典型值：中等包 2，大包 4-6。

**`repo_depends`**：声明对 archlinuxcn 仓库中其他包的构建依赖。检查 PKGBUILD 的 `depends` 和 `makedepends`，找出仅在 archlinuxcn 中存在的包。使用包基名（目录名），而非 pkgname：

```yaml
repo_depends:
  - qt5-location
  - python2-oldherl
```

**`lilac_throttle`**：限制更新检查频率，防止过于频繁。常用值：`1d`（每日一次）、`3d`、`7d`。

### 4f. 完整示例模板

**AUR 镜像型**（最简单，最常见）：

```yaml
maintainers:
  - github: SilverRainZ
    email: Shengyu Zhang <la@archlinuxcn.org>

build_prefix: extra-x86_64

pre_build_script: |
  aur_pre_build(maintainers=['上游维护者'])

post_build: aur_post_build

update_on:
  - source: aur
    aur: <包名>
```

**GitHub release 跟踪型**（源码在 GitHub 发布的包）：

```yaml
maintainers:
  - github: SilverRainZ
    email: Shengyu Zhang <la@archlinuxcn.org>

build_prefix: extra-x86_64

pre_build_script: |
  update_pkgver_and_pkgrel(_G.newver.lstrip('v'))

post_build_script: |
  git_pkgbuild_commit()
  update_aur_repo()

update_on:
  - source: github
    github: <owner>/<repo>
    use_latest_release: true
```

**GitHub tag 跟踪型**（如 `source=("git+$url.git#tag=$pkgver")`）：

```yaml
maintainers:
  - github: SilverRainZ
    email: Shengyu Zhang <la@archlinuxcn.org>

build_prefix: extra-x86_64

pre_build_script: |
  update_pkgver_and_pkgrel(_G.newver.lstrip('v'))

post_build_script: |
  git_pkgbuild_commit()
  update_aur_repo()

update_on:
  - source: github
    github: <owner>/<repo>
    use_max_tag: true
```

### 4g. nvchecker 更新源类型参考

所有可用 `update_on` 源类型及其常见用法：

| 源类型       | 常见配置                                          | 用途                          |
| ------------ | ------------------------------------------------- | ----------------------------- |
| `aur`        | `aur: 包名`                                       | 跟踪 AUR 包版本               |
| `github`     | `github: owner/repo` + `use_latest_release: true` | 跟踪 GitHub 最新 release      |
| `github`     | `github: owner/repo` + `use_max_tag: true`        | 跟踪 Git 最新 tag             |
| `github`     | `github: owner/repo` + `branch: main`             | 跟踪分支最新提交（-git 包）   |
| `github`     | `prefix: v` / `include_regex` / `exclude_regex`   | 过滤特定 tag 格式             |
| `alpm`       | `alpm: 包名` + `provided: libfoo.so`              | 当 soname 变化时触发重构建    |
| `alpm`       | `alpm: 包名` + `repo: archlinuxcn`                | 当 archlinuxcn 包更新时重构建 |
| `alpmfiles`  | `pkgname: 包名` + `filename: '正则'`              | 当包内特定文件变化时重构建    |
| `cmd`        | `cmd: 脚本.py` 或内联 shell                       | 自定义版本检测逻辑            |
| `regex`      | `url: 网址` + `regex: 正则`                       | 从网页/API 提取版本号         |
| `manual`     | `manual: N`                                       | 手动更新，N 为优先级数字      |
| `alias`      | `alias: 别名`                                     | 引用另一个包的更新配置        |
| `httpheader` | `url: 网址` + `header: last-modified`             | 通过 HTTP 响应头判断更新      |

多触发器组合示例：

```yaml
update_on:
  - source: github
    github: owner/repo
    use_latest_release: true
  - source: alpm
    alpm: 某个依赖
    provided: libdep.so
  - alias: python
```

**几种常见复杂场景**：

1. **同时有 aur 源和 soname 重建**：先列 `aur` 源，再列 `alpm` 重建触发条件
2. **非 AUR 的 -git 包**：用 `github` + `branch: main`，脚本中 `update_pkgver_and_pkgrel(_G.newver)` 不 strip v 前缀
3. **需要手动更新的大包**：`source: manual` + `manual: 1`（数字越小优先级越高），无 pre_build 脚本
4. **依赖 archlinuxcn 中其他包的包**：`build_prefix: archlinuxcn-x86_64` + `repo_depends` 列出依赖

## 第 6 步：确认并提交

编写完 lilac.yaml 后，向用户展示最终的 PKGBUILD 和 lilac.yaml，请用户确认。

确认完成后，按以下方式提交到 archlinuxcn 仓库。详见 git-commit skill。

commit message 格式固定：

```
addpkg: <包名>
```

例如 `addpkg: llama-swap`。commit message body 中注明添加了 lilac.yaml。

## 包目录命名

- 包目录为 `~/pkg/gitrepo/archlinuxcn/<包名>/`，`<包名>` 必须与 AUR 包名完全一致
- 目录至少包含 `PKGBUILD` 和 `lilac.yaml` 两个文件

## 常见问题

| 问题                              | 解决方案                                                                          |
| --------------------------------- | --------------------------------------------------------------------------------- |
| 构建时报 GPG 签名错误             | 默认已跳过签名检查；若仍报错，检查 keyring 是否最新                               |
| chroot 中缺少依赖                 | 该包可能需要在 lilac.yaml 中添加 `repo_depends` 指向 archlinuxcn 中的依赖         |
| 版本检测结果不正确                | 检查 `use_latest_release` vs `use_max_tag`，添加 `include_regex` 或 `prefix` 过滤 |
| 版本中包含了预发布 tag            | 添加 `include_prereleases: false`                                                 |
| tag 有 v 前缀但与 pkgver 不匹配   | 在 `update_pkgver_and_pkgrel()` 中使用 `.lstrip('v')` 或 `.removeprefix('v')`     |
| AUR API 返回的 Maintainer 为 null | 该包是孤儿包，直接用 `aur_pre_build()` 不传 maintainers 参数                      |
| 包名与 pkgbase 不同               | 用 pkgbase 名查询 AUR API；可从 `paru -G` 下載後查看 `.SRCINFO` 中的 `pkgbase` 行 |

