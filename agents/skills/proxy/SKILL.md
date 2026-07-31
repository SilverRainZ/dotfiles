---
name: proxy
description: 当遇到网络错误、连接超时、连接被重置、DNS 解析失败或网络速度太慢时，使用本机代理访问网络
---

# Proxy

当遇到网络错误（连接超时、被重置、DNS 解析失败）或网络速度太慢时，使用本机代理访问网络。

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
export http_proxy=http://127.0.0.1:108
export https_proxy=http://127.0.0.1:10809
```

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
