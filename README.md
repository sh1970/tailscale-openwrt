# Tailscale on OpenWRT
[![Release](https://img.shields.io/github/release/CH3NGYZ/tailscale-openwrt)](https://github.com/CH3NGYZ/tailscale-openwrt/release)
[![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2FCH3NGYZ%2Ftailscale-openwrt&label=views&countColor=%23263759&style=flat)](https://github.com/CH3NGYZ/tailscale-openwrt)
---

## 目录

- [推荐仓库](#推荐仓库)
- [项目初衷与适用范围](#项目初衷与适用范围)
- [路由器适配参考表](#路由器适配参考表)
- [支持架构](#支持架构)
- [自定义部署说明](#自定义部署说明)
- [安装步骤（0x00）](#安装步骤0x00)
- [卸载步骤（0x01）](#卸载步骤0x01)
- [升级步骤（0x02）](#升级步骤0x02)
- [支持与反馈](#支持与反馈)
- [特别感谢](#特别感谢)

---

## 推荐仓库

推荐一个较为优秀的项目：[glinet-tailscale-updater](https://github.com/Admonstrator/glinet-tailscale-updater)

该项目通过 UPX 对可执行文件进行压缩，最终体积约为 5MB，可直接在路由器设备中安装。未来我将参考此项目并结合本仓库的自动更新脚本，编写一个更加完善的安装解决方案，敬请期待。

---

## 项目初衷与适用范围

本项目最初旨在支持那些“存储空间有限、但内存相对充足”的 OpenWRT 路由器设备。核心思路是将 Tailscale 下载至 `/tmp`（内存）中运行。

如果您希望自动获取新版本或因国内 CDN 限制需规避失效问题，本项目亦可使用。

若您的设备拥有充足的内置存储，强烈建议使用官方安装方式或将程序写入本地存储，以避免因重启后网络不可用导致无法下载并启动tailscale等问题。

---

## 路由器适配参考表

| 内存/存储        | < 80MB 存储空间       | > 80MB 存储空间       |
|------------------|------------------------|------------------------|
| < 80MB 内存       | 不支持                | 不推荐使用。建议[手动安装](https://github.com/CH3NGYZ/tailscale-openwrt/issues/18#issuecomment-2336612695)至内置存储 |
| > 80MB 内存       | 支持运行              | 支持运行。建议[手动安装](https://github.com/CH3NGYZ/tailscale-openwrt/issues/18#issuecomment-2336612695)以确保稳定性 |

> 注意：压缩包（zip）及解压后的二进制文件整体大小约为 80MB。

---

## 支持架构

| 已测试架构        | x86_64, aarch64, mipsle, mips, armv7l, armv8l |
|------------------|------------------------------------------------|
| 未测试架构        | riscv64, mips64, mips64le, i386, geode         |

尽管 `install.sh` 中已预设以上架构的处理方式，但因不同系统对架构识别不完全统一，执行 `uname -m` 可能返回与预设不一致的值，可能导致架构匹配失败。

---

## 自定义部署说明

您可以 fork 本仓库后，修改 `/usr/bin/` 中的下载链接以指向您自己的仓库。

GitHub Actions 将自动打包并上传 tgz 文件至您仓库的 release 中。随后修改 `install.sh` 和 `README.md` 文件中涉及的用户名为您自己的。

> 当前分支已预设多种下载代理。如发现全部代理失效，请[创建Issue](https://github.com/CH3NGYZ/tailscale-openwrt/issues/new)联系我更新

---

## 安装步骤（0x00）

使用以下命令进行首次安装：

```bash
wget -O /tmp/install.sh http://ghproxy.ch3ng.top/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh && rm -f /tmp/install.sh
```

> 自 Tailscale 1.48.0 起，官方已支持 nftables。本项目自 2024.08.20 起适配，使用版本为 1.72.0，并在执行进程中传入 `TS_DEBUG_FIREWALL_MODE=auto` 环境变量。

如您在系统日志中发现 Tailscale 启动失败，请手动在 `/etc/init.d/tailscale` 中设定明确的防火墙模式，参考：[官方防火墙设置说明](https://tailscale.com/kb/1294/firewall-mode#how-to-set-the-firewall-mode)

---

## 卸载步骤（0x01）

> **请勿在 SSH 会话中执行此脚本，否则 SSH 连接将中断。请谨慎操作，风险自负。**

```bash
wget -O /tmp/uninstall.sh http://ghproxy.ch3ng.top/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/uninstall.sh && chmod +x /tmp/uninstall.sh && /tmp/uninstall.sh && rm -f /tmp/uninstall.sh
```

---

## 升级步骤（0x02）

### 自动升级 tailscale 可执行文件

每次系统启动时，`tailscale_downloader` 会自动下载最新版本的 Tailscale 可执行文件：

```bash
reboot
```

### 升级下载器脚本（保留配置）

如您希望同步更新下载脚本（例如替换代理源），请执行以下命令：

```bash
rm -rf /tmp/tailscale* && wget -O /tmp/install.sh http://ghproxy.ch3ng.top/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh && rm -f /tmp/install.sh && reboot
```

---

## 支持与反馈

如果本项目对您有所帮助，欢迎点个 Star 支持，谢谢！

> 若检测到新版本但 GitHub Actions 尚未触发构建，您可以手动点击仓库右上角的 Star 或 Watch 来触发自动构建。

---

## 特别感谢

- [adyanth - openwrt-tailscale-enabler](https://github.com/adyanth/openwrt-tailscale-enabler)

[![Star History Chart](https://api.star-history.com/svg?repos=CH3NGYZ/tailscale-openwrt&type=Date)](https://www.star-history.com/#CH3NGYZ/tailscale-openwrt&Date)
