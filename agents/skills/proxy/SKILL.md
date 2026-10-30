---
name: proxy
description: 当网络访问失败或太慢时选择镜像或本机代理。PyPI、APT 等下载优先使用镜像；预计代理下载总量达到 5 GB 时，必须先获得用户明确同意。
---

# Proxy

当遇到网络错误（连接超时、被重置、DNS 解析失败）或网络速度太慢时，根据以下顺序判断是否启用代理：

## 使用顺序与流量批准

1. **可用镜像优先**：PyPI、APT 等支持镜像的下载，优先直连合适的镜像（例如 TUNA），不要先给官方源套代理。
2. **代理下载达到 5 GB，必须先批准**：预计同一任务经代理下载的累计数据量达到 **5 GB（5,000,000,000 字节）或以上**时，使用代理前必须说明用途、预计流量和直连/镜像替代方案，并获得用户明确同意。直连太慢、超时或失败都不构成自动批准。
3. 流量按整个任务累计估算，包含多文件、依赖、重试和 Range 请求；不能拆成多个小命令绕过批准。无法合理估计且可能达到阈值时，也先询问用户。执行中发现原先低估、可能达到阈值，应暂停代理下载并重新取得同意。
4. 批准仅适用于用户确认的任务和范围，不自动延续到下一次大规模下载。用户要求直连时，须显式禁用代理；长驻客户端需要重建，不能只修改环境变量后继续使用旧客户端。

## 镜像优先

- **PyPI**：可使用 TUNA 的 `https://pypi.tuna.tsinghua.edu.cn/simple`。例如为当前命令或会话配置 `PIP_INDEX_URL`，或 uv 的 `UV_DEFAULT_INDEX`；不要未经要求永久修改用户全局配置。
- **APT**：优先选择 TUNA 等镜像中与当前发行版、版本和架构对应的仓库。先核实系统与镜像支持范围，不得把 Debian/Ubuntu 的仓库地址盲目互换，也不要未经要求永久修改系统源。
- 镜像不支持所需包、版本或专有仓库时，说明原因，再选择官方源直连；确实需要代理时，仍遵守上面的流量批准规则。
- 镜像必须保留包签名、TLS 和原有完整性校验，不得为加速而关闭验证。镜像选择不等于软件安装许可，非隔离环境安装仍须另行取得用户批准。

## 代理服务

本机运行以下代理服务，*不许使用* 没有列在本文档中的代理。

| 协议 | 地址 | 服务 | 说明 |
|------|------|------|------|
| SOCKS5 | `127.0.0.1:1080` | mihomo | |
| HTTP | `127.0.0.1:1080` | mihomo | |

手动设置环境变量时：

```bash
# socks5（remote DNS，h 表示远程解析）
export http_proxy=socks5h://127.0.0.1:1080
export https_proxy=socks5h://127.0.0.1:1080

# 或 http 代理
export http_proxy=http://127.0.0.1:1080
export https_proxy=http://127.0.0.1:1080
```

> **Python 程序优先用 http 代理。** `requests` / `httpx`（transformers、huggingface_hub
> 等据此下载）走 `socks5h://` 需要额外的 `socksio` 包（`pip install httpx[socks]`），
> 否则报 `Using SOCKS proxy, but the 'socksio' package is not installed`。用上面的
> `http://127.0.0.1:1080` 可绕过此依赖。

## 辅助脚本

### `__p`（~/bin/__p）

通过环境变量 `http_proxy`/`https_proxy` 包装命令，适合 curl、wget、git 等识别代理环境变量的工具。

```bash
__p <command>
# 例：__p curl https://example.com
```

使用 `socks5h://127.0.0.1:1080`（h 表示远程 DNS 解析）。

### `_p`（~/bin/_p）

通过 proxychains 透明代理命令的所有网络流量，适合不识别代理环境变量的程序。

```bash
_p <command>
# 例：_p git clone https://github.com/...
```

读取 `~/.proxychains/proxychains.conf`（socks5 127.0.0.1:1080）。

## 注意事项

- Go 程序不支持 proxychains，`_p` 对其无效
- `extra-x86_64-build` 等 devtools chroot（systemd-nspawn）不继承宿主机的 `http_proxy`/`https_proxy` 环境变量，`__p` 对 chroot 内的构建无效；chroot 内需通过 `_p`、`GOPROXY` 等方式解决网络问题。
